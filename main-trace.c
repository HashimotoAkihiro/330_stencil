/**********************************************************************/
/* The 1st IPSJ SIG-ARC High-Performance Processor Design Contest     */
/* 320mm Version 2013-10-13                                           */
/**********************************************************************/

/* USE_SIMD alternatives
#define USE_SIMD        0    (using SIMD emulation)
#define USE_SIMD        1    (using real SIMD instructions)
*/
#define USE_SIMD        0

#define TRACE_OUT       1

#include "../lib/lib.c"
#if defined USE_SIMD && USE_SIMD == 0
#include "../lib/simd-emu.c"
#endif

/**********************************************************************/
#ifdef __ALTERA__
volatile int *init_data = (int*)0x0c000000;
volatile int *init_n    = (int*)0x0c03fff8;
volatile int *init_iter = (int*)0x0c03fffc;
#define BUF1 0xc100000
#define BUF2 0xc200000
#else
volatile int *init_data = (int*)0x00040000;
volatile int *init_n    = (int*)0x0007fff8;
volatile int *init_iter = (int*)0x0007fffc;
#define BUF1 0x100000
#define BUF2 0x200000
#endif

static void simd128_display(simd128 v)
{
    mylib_display_hex(v[3]);    /* HH */
    mylib_display_char('_');
    mylib_display_hex(v[2]);    /* HL */
    mylib_display_char('_');
    mylib_display_hex(v[1]);    /* LH */
    mylib_display_char('_');
    mylib_display_hex(v[0]);    /* LL */
}

/**********************************************************************/
int main(void) {
    int n         = *init_n;
    int iteration = *init_iter;

    mylib_display_char('s');
    mylib_display_char('t');
    mylib_display_char('e');
    mylib_display_char('n');
    mylib_display_char('c');
    mylib_display_char('i');
    mylib_display_char('l');
    mylib_display_char(' ');
    mylib_display_char('n');
    mylib_display_char('=');
    mylib_display_dec(n);
    mylib_display_char(' ');
    mylib_display_char('i');
    mylib_display_char('=');
    mylib_display_dec(iteration);
    mylib_display_newline();
    
    int *buf1 = (int*) BUF1;
    int *buf2 = (int*) BUF2;

    int x, y, i;

    int d = 0;
#ifdef  USE_SIMD    

#if USE_SIMD == 0

    for(i = 0; i < n*n; i += 8) {
        simd128 v0, v1;
        simd128 zero = { 0, 0, 0, 0 };

        simd128_load(v0, (int*)&init_data[d]);
        simd128_load(v1, (int*)&init_data[d+4]);

        simd128_store(v0, &buf1[i]);
        simd128_store(v1, &buf1[i+4]);

        simd128_store(zero, &buf2[i]);
        simd128_store(zero, &buf2[i+4]);

#ifdef  TRACE_OUT
        mylib_display_hex((int)&buf1[i]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(v0);
        mylib_display_newline();

        mylib_display_hex((int)&buf1[i+4]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(v1);
        mylib_display_newline();
#endif
        d = (d + 8) % (64*1024);
    }

#elif USE_SIMD == 1

    /* zero clear SPR[0] */
/*  // this is NG code
    asm volatile (".set   noat\n\t"
                  "psubw  $0,$0,$0\n\t"
                  ".set   at");*/
    asm volatile (".set   noat\n\t"
                  "pinsw  $0,$0,$0,0\n\t"
                  "nop\n\t"
                  "nop\n\t"
                  "pinsw  $0,$0,$0,1\n\t"
                  "nop\n\t"
                  "nop\n\t"
                  "pinsw  $0,$0,$0,2\n\t"
                  "nop\n\t"
                  "nop\n\t"
                  "pinsw  $0,$0,$0,3\n\t"
                  ".set   at");

    for (i = 0; i < n*n; i += 8) {
        /* load two quadwords onto SPR[1] and SPR[2] */
        asm volatile (".set    noat\n\t"
                      "lq      $1,(%0)\n\t"
                      "lq      $2,16(%0)\n\t"
                      "sq      $0,(%2)\n\t"
                      "sq      $0,16(%2)\n\t"
                      "sq      $1,(%1)\n\t"
                      "sq      $2,16(%1)\n\t"
                      ".set    at\n"
                      : : "r" (&init_data[d]), "r" (&buf1[i]), "r" (&buf2[i]) );

        d = (d + 8) % (64*1024);
     }

#else
# error "illegal USE_SIMD setting"
#endif

#else
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            buf1[x + y*n] = init_data[d % (64*1024)];
            buf2[x + y*n] = 0;
            d++;
        }
    }
#endif

    for(i=0; i<(iteration/2); i++){

#ifdef  USE_SIMD    

#if USE_SIMD == 0

        /***************
         * first half  *
         ***************/

        for(y=1; y<n-1; y++) {
            simd128 v0, v1, v2, v3;
            simd128 v4, v5, v6, v7;
            simd128 v8, v9, v10, v11;
            simd128 u0, u1, u2;
            simd128 u;
            simd128 hi, lo;
            int shift_out0, shift_out1, shift_out2;

            /* calc first 4-word of upper line */
            simd128_load(v0, buf1 + (y-1)*n);
            simd128_load(v1, buf1 + (y-1)*n + 4);
            simd128_shift_left_word(v2, v0, 0);
            simd128_shift_right_word(v3, v0, v1[0]);
            simd128_add(u0, v0, v2);
            simd128_add(u0, u0, v3);

            /* calc first 4-word of middle line */
            simd128_load(v4, buf1 + y*n);
            simd128_load(v5, buf1 + y*n + 4);
            simd128_shift_left_word(v6, v4, 0);
            simd128_shift_right_word(v7, v4, v5[0]);
            simd128_add(u1, v4, v6);
            simd128_add(u1, u1, v7);

            /* calc first 4-word of lower line */
            simd128_load(v8, buf1 + (y+1)*n);
            simd128_load(v9, buf1 + (y+1)*n + 4);
            simd128_shift_left_word(v10, v8, 0);
            simd128_shift_right_word(v11, v8, v9[0]);
            simd128_add(u2, v8, v10);
            simd128_add(u2, u2, v11);

            /* resulting first 4-word of middle line */
            simd128_add(u, u0, u1);
            simd128_add(u, u, u2);
#if 0
            mylib_display_char('u');
            mylib_display_char('-'); mylib_display_char(':');
            simd128_display(u);
            mylib_display_newline();
#endif
            simd128_mult_scalar(hi, lo, u, 0x38e38e39);
            simd128_shift_right_arithmetic(u, hi, 1);

            /* first word of target line is untouched */
            u[0] = buf2[y*n + 0];

            simd128_store(u, buf2 + y*n);

#ifdef  TRACE_OUT
            mylib_display_hex((int)(buf1 + (y-1)*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v0);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + (y-1)*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v1);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + y*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v4);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + y*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v5);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + (y+1)*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v8);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + (y+1)*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v9);
            mylib_display_newline();

            mylib_display_char('v');
            mylib_display_char('2'); mylib_display_char(':');
            simd128_display(v2);
            mylib_display_newline();
            mylib_display_char('v');
            mylib_display_char('3'); mylib_display_char(':');
            simd128_display(v3);
            mylib_display_newline();
            mylib_display_char('v');
            mylib_display_char('6'); mylib_display_char(':');
            simd128_display(v6);
            mylib_display_newline();
            mylib_display_char('v');
            mylib_display_char('7'); mylib_display_char(':');
            simd128_display(v7);
            mylib_display_newline();
            mylib_display_char('v');
            mylib_display_char('a'); mylib_display_char(':');
            simd128_display(v10);
            mylib_display_newline();
            mylib_display_char('v');
            mylib_display_char('b'); mylib_display_char(':');
            simd128_display(v11);
            mylib_display_newline();

            mylib_display_char('u');
            mylib_display_char('0'); mylib_display_char(':');
            simd128_display(u0);
            mylib_display_newline();
            mylib_display_char('u');
            mylib_display_char('1'); mylib_display_char(':');
            simd128_display(u1);
            mylib_display_newline();
            mylib_display_char('u');
            mylib_display_char('2'); mylib_display_char(':');
            simd128_display(u2);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + y*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(u);
            mylib_display_newline();
#endif

            for(x = 4; x < n-1 -3; x += 4) {

                shift_out0 = v0[3];
                shift_out1 = v4[3];
                shift_out2 = v8[3];

                simd128_move(v0, v1);
                simd128_load(v1, buf1 + (y-1)*n + x + 4);

                simd128_move(v4, v5);
                simd128_load(v5, buf1 + y*n + x + 4);

                simd128_move(v8, v9);
                simd128_load(v9, buf1 + (y+1)*n + x + 4);

                /* calc first 4-word of upper line */
                simd128_shift_left_word(v2, v0, shift_out0);
                simd128_shift_right_word(v3, v0, v1[0]);
                simd128_add(u0, v0, v2);
                simd128_add(u0, u0, v3);

                /* calc first 4-word of middle line */
                simd128_shift_left_word(v6, v4, shift_out1);
                simd128_shift_right_word(v7, v4, v5[0]);
                simd128_add(u1, v4, v6);
                simd128_add(u1, u1, v7);

                /* calc first 4-word of lower line */
                simd128_shift_left_word(v10, v8, shift_out2);
                simd128_shift_right_word(v11, v8, v9[0]);
                simd128_add(u2, v8, v10);
                simd128_add(u2, u2, v11);

                /* resulting first 4-word of middle line */
                simd128_add(u, u0, u1);
                simd128_add(u, u, u2);
                simd128_mult_scalar(hi, lo, u, 0x38e38e39);
                simd128_shift_right_arithmetic(u, hi, 1);

                simd128_store(u, buf2 + y*n + x);

#ifdef  TRACE_OUT
                mylib_display_hex((int)(buf1 + (y-1)*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v0);
                mylib_display_newline();
                mylib_display_hex((int)(buf1 + (y-1)*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v1);
                mylib_display_newline();

                mylib_display_hex((int)(buf1 + y*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v4);
                mylib_display_newline();
                mylib_display_hex((int)(buf1 + y*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v5);
                mylib_display_newline();

                mylib_display_hex((int)(buf1 + (y+1)*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v8);
                mylib_display_newline();
                mylib_display_hex((int)(buf1 + (y+1)*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v9);
                mylib_display_newline();

                mylib_display_hex((int)(buf2 + y*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(u);
                mylib_display_newline();
#endif
            }


            shift_out0 = v0[3];
            shift_out1 = v4[3];
            shift_out2 = v8[3];

            simd128_move(v0, v1);
            simd128_load(v1, buf1 + (y-1)*n + x + 4);

            simd128_move(v4, v5);
            simd128_load(v5, buf1 + y*n + x + 4);

            simd128_move(v8, v9);
            simd128_load(v9, buf1 + (y+1)*n + x + 4);

            /* calc first 4-word of upper line */
            simd128_shift_left_word(v2, v0, shift_out0);
            simd128_shift_right_word(v3, v0, v1[0]);
            simd128_add(u0, v0, v2);
            simd128_add(u0, u0, v3);

            /* calc first 4-word of middle line */
            simd128_shift_left_word(v6, v4, shift_out1);
            simd128_shift_right_word(v7, v4, v5[0]);
            simd128_add(u1, v4, v6);
            simd128_add(u1, u1, v7);

            /* calc first 4-word of lower line */
            simd128_shift_left_word(v10, v8, shift_out2);
            simd128_shift_right_word(v11, v8, v9[0]);
            simd128_add(u2, v8, v10);
            simd128_add(u2, u2, v11);

            /* resulting first 4-word of middle line */
            simd128_add(u, u0, u1);
            simd128_add(u, u, u2);
            simd128_mult_scalar(hi, lo, u, 0x38e38e39);
            simd128_shift_right_arithmetic(u, hi, 1);

            /* last word of target line is untouched */
            u[3] = buf2[y*n + x + 3];

            simd128_store(u, buf2 + y*n + x);

#ifdef  TRACE_OUT
            mylib_display_hex((int)(buf1 + (y-1)*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v0);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + (y-1)*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v1);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + y*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v4);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + y*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v5);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + (y+1)*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v8);
            mylib_display_newline();
            mylib_display_hex((int)(buf1 + (y+1)*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v9);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + y*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(u);
            mylib_display_newline();
#endif
        }

        buf2[n+1] = 0x9999999; // hot spot


        /***************
         * second half *
         ***************/

        for(y=1; y<n-1; y++) {
            simd128 v0, v1, v2, v3;
            simd128 v4, v5, v6, v7;
            simd128 v8, v9, v10, v11;
            simd128 u0, u1, u2;
            simd128 u;
            simd128 hi, lo;
            int shift_out0, shift_out1, shift_out2;

            /* calc first 4-word of upper line */
            simd128_load(v0, buf2 + (y-1)*n);
            simd128_load(v1, buf2 + (y-1)*n + 4);
            simd128_shift_left_word(v2, v0, 0);
            simd128_shift_right_word(v3, v0, v1[0]);
            simd128_add(u0, v0, v2);
            simd128_add(u0, u0, v3);

            /* calc first 4-word of middle line */
            simd128_load(v4, buf2 + y*n);
            simd128_load(v5, buf2 + y*n + 4);
            simd128_shift_left_word(v6, v4, 0);
            simd128_shift_right_word(v7, v4, v5[0]);
            simd128_add(u1, v4, v6);
            simd128_add(u1, u1, v7);

            /* calc first 4-word of lower line */
            simd128_load(v8, buf2 + (y+1)*n);
            simd128_load(v9, buf2 + (y+1)*n + 4);
            simd128_shift_left_word(v10, v8, 0);
            simd128_shift_right_word(v11, v8, v9[0]);
            simd128_add(u2, v8, v10);
            simd128_add(u2, u2, v11);

            /* resulting first 4-word of middle line */
            simd128_add(u, u0, u1);
            simd128_add(u, u, u2);
            simd128_mult_scalar(hi, lo, u, 0x38e38e39);
            simd128_shift_right_arithmetic(u, hi, 1);

            /* first word of target line is untouched */
            u[0] = buf1[y*n + 0];

            simd128_store(u, buf1 + y*n);

#ifdef  TRACE_OUT
            mylib_display_hex((int)(buf2 + (y-1)*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v0);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + (y-1)*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v1);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + y*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v4);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + y*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v5);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + (y+1)*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v8);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + (y+1)*n + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v9);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + y*n));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(u);
            mylib_display_newline();
#endif

            for(x = 4; x < n-1 -3; x += 4) {

                shift_out0 = v0[3];
                shift_out1 = v4[3];
                shift_out2 = v8[3];

                simd128_move(v0, v1);
                simd128_load(v1, buf2 + (y-1)*n + x + 4);

                simd128_move(v4, v5);
                simd128_load(v5, buf2 + y*n + x + 4);

                simd128_move(v8, v9);
                simd128_load(v9, buf2 + (y+1)*n + x + 4);

                /* calc first 4-word of upper line */
                simd128_shift_left_word(v2, v0, shift_out0);
                simd128_shift_right_word(v3, v0, v1[0]);
                simd128_add(u0, v0, v2);
                simd128_add(u0, u0, v3);

                /* calc first 4-word of middle line */
                simd128_shift_left_word(v6, v4, shift_out1);
                simd128_shift_right_word(v7, v4, v5[0]);
                simd128_add(u1, v4, v6);
                simd128_add(u1, u1, v7);

                /* calc first 4-word of lower line */
                simd128_shift_left_word(v10, v8, shift_out2);
                simd128_shift_right_word(v11, v8, v9[0]);
                simd128_add(u2, v8, v10);
                simd128_add(u2, u2, v11);

                /* resulting first 4-word of middle line */
                simd128_add(u, u0, u1);
                simd128_add(u, u, u2);
                simd128_mult_scalar(hi, lo, u, 0x38e38e39);
                simd128_shift_right_arithmetic(u, hi, 1);

                simd128_store(u, buf1 + y*n + x);

#ifdef  TRACE_OUT
                mylib_display_hex((int)(buf2 + (y-1)*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v0);
                mylib_display_newline();
                mylib_display_hex((int)(buf2 + (y-1)*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v1);
                mylib_display_newline();

                mylib_display_hex((int)(buf2 + y*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v4);
                mylib_display_newline();
                mylib_display_hex((int)(buf2 + y*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v5);
                mylib_display_newline();

                mylib_display_hex((int)(buf2 + (y+1)*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v8);
                mylib_display_newline();
                mylib_display_hex((int)(buf2 + (y+1)*n + x + 4));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(v9);
                mylib_display_newline();

                mylib_display_hex((int)(buf1 + y*n + x));
                mylib_display_char(':'); mylib_display_char(' ');
                simd128_display(u);
                mylib_display_newline();
#endif
            }


            shift_out0 = v0[3];
            shift_out1 = v4[3];
            shift_out2 = v8[3];

            simd128_move(v0, v1);
            simd128_load(v1, buf2 + (y-1)*n + x + 4);

            simd128_move(v4, v5);
            simd128_load(v5, buf2 + y*n + x + 4);

            simd128_move(v8, v9);
            simd128_load(v9, buf2 + (y+1)*n + x + 4);

            /* calc first 4-word of upper line */
            simd128_shift_left_word(v2, v0, shift_out0);
            simd128_shift_right_word(v3, v0, v1[0]);
            simd128_add(u0, v0, v2);
            simd128_add(u0, u0, v3);

            /* calc first 4-word of middle line */
            simd128_shift_left_word(v6, v4, shift_out1);
            simd128_shift_right_word(v7, v4, v5[0]);
            simd128_add(u1, v4, v6);
            simd128_add(u1, u1, v7);

            /* calc first 4-word of lower line */
            simd128_shift_left_word(v10, v8, shift_out2);
            simd128_shift_right_word(v11, v8, v9[0]);
            simd128_add(u2, v8, v10);
            simd128_add(u2, u2, v11);

            /* resulting first 4-word of middle line */
            simd128_add(u, u0, u1);
            simd128_add(u, u, u2);
            simd128_mult_scalar(hi, lo, u, 0x38e38e39);
            simd128_shift_right_arithmetic(u, hi, 1);

            /* last word of target line is untouched */
            u[3] = buf1[y*n + x + 3];

            simd128_store(u, buf1 + y*n + x);

#ifdef  TRACE_OUT
            mylib_display_hex((int)(buf2 + (y-1)*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v0);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + (y-1)*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v1);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + y*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v4);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + y*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v5);
            mylib_display_newline();

            mylib_display_hex((int)(buf2 + (y+1)*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v8);
            mylib_display_newline();
            mylib_display_hex((int)(buf2 + (y+1)*n + x + 4));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(v9);
            mylib_display_newline();

            mylib_display_hex((int)(buf1 + y*n + x));
            mylib_display_char(':'); mylib_display_char(' ');
            simd128_display(u);
            mylib_display_newline();
#endif
        }

        buf1[n+1] = 0x9999999; // hot spot


#elif USE_SIMD == 1

        int shift_out0, shift_out1, shift_out2;

        /***************
         * first half  *
         ***************/

        for(y=1; y<n-1; y++) {

            /*
              v0 = SPR[1], v1 = SPR[2], v2 = SPR[3], v3 = SPR[4]
              v4 = SPR[5], v5 = SPR[6], v6 = SPR[7], v7 = SPR[8]
              v8 = SPR[9], v9 = SPR[10], v10 = SPR[11], v11 = SPR[12]
              u0 = SPR[13], u1 = SPR[14], u2 = SPR[15], u = SPR[16]
            */

            asm volatile (".set    noat\n\t");
                          
            /* calc first 4-word of upper line */
            asm volatile ("lq      $2,16(%0)\n\t"       // v1
                          "lq      $1,(%0)\n\t"         // v0
                          "nop\n\t"
                          "pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                          "psllww  $3,$1,$0\n\t"        // v2 <= v0, GPR[0]
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                          "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                          :: "r" (buf1 + (y-1)*n) );

            /* calc first 4-word of middle line */
            asm volatile ("lq      $6,16(%0)\n\t"       // v5
                          "lq      $5,(%0)\n\t"         // v4
                          "nop\n\t"
                          "pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                          "psllww  $7,$5,$0\n\t"        // v6 <= v4, GPR[0]
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                          "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                          :: "r" (buf1 + y*n) );

            /* calc first 4-word of lower line */
            asm volatile ("lq      $10,16(%0)\n\t"       // v9
                          "lq      $9,(%0)\n\t"          // v8
                          "nop\n\t"
                          "pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                          "psllww  $11,$9,$0\n\t"        // v10 <= v8, GPR[0]
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"        // v11 <= v8, GPR[1]
                          "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                          :: "r" (buf1 + (y+1)*n) );

            /* resulting first 4-word of middle line */
            asm volatile ("paddw   $16,$13,$14\n\t"     // u = u0 + u1
                          "move    $1,%0\n\t"           // GPR[1] = 0x38e38e39
                          "paddw   $16,$16,$15\n\t"     // u = u + u2
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"          // u = u * GPR[1]
                          "pmfhi   $16\n\t"             // u <= hi
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"       // u = u >> 1
                          :: "r" (0x38e38e39));

            /* first word of target line is untouched */
            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,0\n\t"    // u[0] = buf2[y*n + 0]
                          :: "r" (buf2[y*n + 0]));

            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"        // store u
                          :: "r" (buf2 + y*n) );

            asm volatile (".set    at\n\t");

            for(x = 4; x < n-1 -3; x += 4) {

                asm volatile (".set    noat\n\t");

                /* word-shift of double-quadword */
                asm volatile ("pextw   %0,$1,3\n\t"         // get v0[3] => shift_out0
                              "pextw   %1,$5,3\n\t"         // get v4[3] => shift_out1
                              "pextw   %2,$9,3\n\t"         // get v8[3] => shift_out2

                              "paddw   $1,$2,$0\n\t"        // v0 = v1
                              "lq      $2,(%3)\n\t"
                              "paddw   $4,$5,$0\n\t"        // v4 = v5
                              "lq      $5,(%4)\n\t"
                              "paddw   $8,$9,$0\n\t"        // v8 = v9
                              "lq      $9,(%5)\n\t"

                              : "=r" (shift_out0),
                                "=r" (shift_out1),
                                "=r" (shift_out2)
                              : "r" (buf1 + (y-1)*n + x + 4),
                                "r" (buf1 + y*n + x + 4),
                                "r" (buf1 + (y+1)*n + x + 4) );

                /* calc first 4-word of upper line */
                asm volatile ("pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                              "psllww  $3,$1,%0\n\t"        // v2 <= v0
                              "nop\n\t"
                              "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                              "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                              "nop\n\t"
                              "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                              :: "r" (shift_out0) );

                /* calc first 4-word of middle line */
                asm volatile ("pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                              "psllww  $7,$5,%0\n\t"        // v6 <= v4
                              "nop\n\t"
                              "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                              "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                              "nop\n\t"
                              "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                              :: "r" (shift_out1) );

                /* calc first 4-word of lower line */
                asm volatile ("pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                              "psllww  $11,$9,%0\n\t"        // v10 <= v8
                              "nop\n\t"
                              "psrlww  $12,$9,$1\n\t"        // v11 <= v8,GPR[1]
                              "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                              "nop\n\t"
                              "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                              :: "r" (shift_out2) );

                /* resulting first 4-word of middle line */
                asm volatile ("paddw   $16,$13,$14\n\t"      // u = u0 + u1
                              "move    $1,%0\n\t"         // GPR[1] = 0x38e38e39
                              "paddw   $16,$16,$15\n\t"      // u = u + u2
                              "nop\n\t"
                              "nop\n\t"
                              "pmultsw $16,$1\n\t"          // u * GPR[1]
                              "pmfhi   $16\n\t"             // u <= hi
                              "nop\n\t"
                              "nop\n\t"
                              "psraw   $16,$16,1\n\t"       // u = u >> 1
                              "nop\n\t"
                              "nop\n\t"
                              "sq      $16,(%1)\n\t"        // store u
                              :: "r" (0x38e38e39), "r" (buf2 + y*n + x) );

                asm volatile (".set    at\n\t");
            }

            asm volatile (".set    noat\n\t");

            /* word-shift of double-quadword */
            asm volatile ("pextw   %0,$1,3\n\t"         // get v0[3]
                          "pextw   %1,$5,3\n\t"         // get v4[3]
                          "pextw   %2,$9,3\n\t"         // get v8[3]

                          "paddw   $1,$2,$0\n\t"        // v0 = v1
                          "lq      $2,(%3)\n\t"
                          "paddw   $4,$5,$0\n\t"        // v4 = v5
                          "lq      $5,(%4)\n\t"
                          "paddw   $8,$9,$0\n\t"        // v8 = v9
                          "lq      $9,(%5)\n\t"

                          : "=r" (shift_out0),
                            "=r" (shift_out1),
                            "=r" (shift_out2)
                          : "r" (buf1 + (y-1)*n + x + 4),
                            "r" (buf1 + y*n + x + 4),
                            "r" (buf1 + (y+1)*n + x + 4) );

            /* calc first 4-word of upper line */
            asm volatile ("pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                          "psllww  $3,$1,%0\n\t"        // v2 <= v0
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                          "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                          :: "r" (shift_out0) );

            /* calc first 4-word of middle line */
            asm volatile ("pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                          "psllww  $7,$5,%0\n\t"        // v6 <= v4
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                          "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                          :: "r" (shift_out1) );

            /* calc first 4-word of lower line */
            asm volatile ("pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                          "psllww  $11,$9,%0\n\t"        // v10 <= v8
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"        // v11 <= v8,GPR[1]
                          "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                          :: "r" (shift_out2) );

            /* resulting first 4-word of middle line */
            asm volatile ("paddw   $16,$13,$14\n\t"      // u = u0 + u1
                          "move    $1,%0\n\t"         // GPR[1] = 0x38e38e39
                          "paddw   $16,$16,$15\n\t"      // u = u + u2
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"          // u * GPR[1]
                          "pmfhi   $16\n\t"             // u <= hi
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"       // u = u >> 1
                          :: "r" (0x38e38e39));

            /* last word of target line is untouched */
            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,3\n\t"    // u[3] = buf2[y*n + x + 3]
                          :: "r" (buf2[y*n + x + 3]) );

            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"        // store u
                          :: "r" (buf2 + y*n + x) );

            asm volatile (".set    at\n\t");
        }

        buf2[n+1] = 0x9999999; // hot spot


        /***************
         * second half *
         ***************/

        for(y=1; y<n-1; y++) {

            /*
              v0 = SPR[1], v1 = SPR[2], v2 = SPR[3], v3 = SPR[4]
              v4 = SPR[5], v5 = SPR[6], v6 = SPR[7], v7 = SPR[8]
              v8 = SPR[9], v9 = SPR[10], v10 = SPR[11], v11 = SPR[12]
              u0 = SPR[13], u1 = SPR[14], u2 = SPR[15], u = SPR[16]
            */

            asm volatile (".set    noat\n\t");
                          
            /* calc first 4-word of upper line */
            asm volatile ("lq      $2,16(%0)\n\t"       // v1
                          "lq      $1,(%0)\n\t"         // v0
                          "nop\n\t"
                          "pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                          "psllww  $3,$1,$0\n\t"        // v2 <= v0, GPR[0]
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                          "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                          :: "r" (buf2 + (y-1)*n) );

            /* calc first 4-word of middle line */
            asm volatile ("lq      $6,16(%0)\n\t"       // v5
                          "lq      $5,(%0)\n\t"         // v4
                          "nop\n\t"
                          "pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                          "psllww  $7,$5,$0\n\t"        // v6 <= v4, GPR[0]
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                          "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                          :: "r" (buf2 + y*n) );

            /* calc first 4-word of lower line */
            asm volatile ("lq      $10,16(%0)\n\t"       // v9
                          "lq      $9,(%0)\n\t"          // v8
                          "nop\n\t"
                          "pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                          "psllww  $11,$9,$0\n\t"        // v10 <= v8, GPR[0]
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"        // v11 <= v8, GPR[1]
                          "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                          :: "r" (buf2 + (y+1)*n) );

            /* resulting first 4-word of middle line */
            asm volatile ("paddw   $16,$13,$14\n\t"     // u = u0 + u1
                          "move    $1,%0\n\t"           // GPR[1] = 0x38e38e39
                          "paddw   $16,$16,$15\n\t"     // u = u + u2
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"          // u = u * GPR[1]
                          "pmfhi   $16\n\t"             // u <= hi
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"       // u = u >> 1
                          :: "r" (0x38e38e39));

            /* first word of target line is untouched */
            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,0\n\t"    // u[0] = buf1[y*n + 0]
                          :: "r" (buf1[y*n + 0]));

            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"        // store u
                          :: "r" (buf1 + y*n) );

            asm volatile (".set    at\n\t");

            for(x = 4; x < n-1 -3; x += 4) {

                asm volatile (".set    noat\n\t");

                /* word-shift of double-quadword */
                asm volatile ("pextw   %0,$1,3\n\t"         // get v0[3] => shift_out0
                              "pextw   %1,$5,3\n\t"         // get v4[3] => shift_out1
                              "pextw   %2,$9,3\n\t"         // get v8[3] => shift_out2

                              "paddw   $1,$2,$0\n\t"        // v0 = v1
                              "lq      $2,(%3)\n\t"
                              "paddw   $4,$5,$0\n\t"        // v4 = v5
                              "lq      $5,(%4)\n\t"
                              "paddw   $8,$9,$0\n\t"        // v8 = v9
                              "lq      $9,(%5)\n\t"

                              : "=r" (shift_out0),
                                "=r" (shift_out1),
                                "=r" (shift_out2)
                              : "r" (buf2 + (y-1)*n + x + 4),
                                "r" (buf2 + y*n + x + 4),
                                "r" (buf2 + (y+1)*n + x + 4) );

                /* calc first 4-word of upper line */
                asm volatile ("pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                              "psllww  $3,$1,%0\n\t"        // v2 <= v0
                              "nop\n\t"
                              "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                              "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                              "nop\n\t"
                              "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                              :: "r" (shift_out0) );

                /* calc first 4-word of middle line */
                asm volatile ("pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                              "psllww  $7,$5,%0\n\t"        // v6 <= v4
                              "nop\n\t"
                              "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                              "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                              "nop\n\t"
                              "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                              :: "r" (shift_out1) );

                /* calc first 4-word of lower line */
                asm volatile ("pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                              "psllww  $11,$9,%0\n\t"        // v10 <= v8
                              "nop\n\t"
                              "psrlww  $12,$9,$1\n\t"        // v11 <= v8,GPR[1]
                              "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                              "nop\n\t"
                              "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                              :: "r" (shift_out2) );

                /* resulting first 4-word of middle line */
                asm volatile ("paddw   $16,$13,$14\n\t"      // u = u0 + u1
                              "move    $1,%0\n\t"         // GPR[1] = 0x38e38e39
                              "paddw   $16,$16,$15\n\t"      // u = u + u2
                              "nop\n\t"
                              "nop\n\t"
                              "pmultsw $16,$1\n\t"          // u * GPR[1]
                              "pmfhi   $16\n\t"             // u <= hi
                              "nop\n\t"
                              "nop\n\t"
                              "psraw   $16,$16,1\n\t"       // u = u >> 1
                              "nop\n\t"
                              "nop\n\t"
                              "sq      $16,(%1)\n\t"        // store u
                              :: "r" (0x38e38e39), "r" (buf1 + y*n + x) );

                asm volatile (".set    at\n\t");
            }

            asm volatile (".set    noat\n\t");

            /* word-shift of double-quadword */
            asm volatile ("pextw   %0,$1,3\n\t"         // get v0[3]
                          "pextw   %1,$5,3\n\t"         // get v4[3]
                          "pextw   %2,$9,3\n\t"         // get v8[3]

                          "paddw   $1,$2,$0\n\t"        // v0 = v1
                          "lq      $2,(%3)\n\t"
                          "paddw   $4,$5,$0\n\t"        // v4 = v5
                          "lq      $5,(%4)\n\t"
                          "paddw   $8,$9,$0\n\t"        // v8 = v9
                          "lq      $9,(%5)\n\t"

                          : "=r" (shift_out0),
                            "=r" (shift_out1),
                            "=r" (shift_out2)
                          : "r" (buf2 + (y-1)*n + x + 4),
                            "r" (buf2 + y*n + x + 4),
                            "r" (buf2 + (y+1)*n + x + 4) );

            /* calc first 4-word of upper line */
            asm volatile ("pextw   $1,$2,0\n\t"         // GPR[1] = v1[0]
                          "psllww  $3,$1,%0\n\t"        // v2 <= v0
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"        // v3 <= v0, GPR[1]
                          "paddw   $13,$1,$3\n\t"       // u0 = v0 + v2
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"      // u0 = u0 + v3
                          :: "r" (shift_out0) );

            /* calc first 4-word of middle line */
            asm volatile ("pextw   $1,$6,0\n\t"         // GPR[1] = v5[0]
                          "psllww  $7,$5,%0\n\t"        // v6 <= v4
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"        // v7 <= v4, GPR[1]
                          "paddw   $14,$4,$7\n\t"       // u1 = v4 + v6
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"      // u1 = u1 + v7
                          :: "r" (shift_out1) );

            /* calc first 4-word of lower line */
            asm volatile ("pextw   $1,$10,0\n\t"         // GPR[1] = v9[0]
                          "psllww  $11,$9,%0\n\t"        // v10 <= v8
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"        // v11 <= v8,GPR[1]
                          "paddw   $15,$9,$11\n\t"       // u2 = v8 + v10
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"      // u2 = u2 + v11
                          :: "r" (shift_out2) );

            /* resulting first 4-word of middle line */
            asm volatile ("paddw   $16,$13,$14\n\t"      // u = u0 + u1
                          "move    $1,%0\n\t"         // GPR[1] = 0x38e38e39
                          "paddw   $16,$16,$15\n\t"      // u = u + u2
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"          // u * GPR[1]
                          "pmfhi   $16\n\t"             // u <= hi
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"       // u = u >> 1
                          :: "r" (0x38e38e39));

            /* last word of target line is untouched */
            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,3\n\t"    // u[3] = buf1[y*n + x + 3]
                          :: "r" (buf1[y*n + x + 3]) );

            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"        // store u
                          :: "r" (buf1 + y*n + x) );

            asm volatile (".set    at\n\t");
        }

        buf1[n+1] = 0x9999999; // hot spot


#else
# error "illegal USE_SIMD setting"
#endif

#else
        /* original code */
        for(y=1; y<n-1; y++) {
            for(x=1; x<n-1; x++) {
                buf2[(x) + (y)*n] =
                    (buf1[(x  ) + (y-1)*n] + buf1[(x-1) + (y  )*n] +
                     buf1[(x+1) + (y  )*n] + buf1[(x  ) + (y+1)*n] +
                     buf1[(x-1) + (y-1)*n] + buf1[(x+1) + (y-1)*n] +
                     buf1[(x-1) + (y+1)*n] + buf1[(x+1) + (y+1)*n] +
                     buf1[(x  ) + (y  )*n]) / 9;
            }
        }

        buf2[n+1] = 0x9999999; // hot spot

        for(y=1; y<n-1; y++) {
            for(x=1; x<n-1; x++) {
                buf1[(x) + (y)*n] =
                    (buf2[(x  ) + (y-1)*n] + buf2[(x-1) + (y  )*n] +
                     buf2[(x+1) + (y  )*n] + buf2[(x  ) + (y+1)*n] +
                     buf2[(x-1) + (y-1)*n] + buf2[(x+1) + (y-1)*n] +
                     buf2[(x-1) + (y+1)*n] + buf2[(x+1) + (y+1)*n] +
                     buf2[(x  ) + (y  )*n]) / 9;
            }
        }
        buf1[n+1] = 0x9999999; // hot spot
#endif
    }

    mylib_display_newline();

#ifdef USE_SIMD

#if USE_SIMD == 0

    for(y = 0; y < 16; y++) {
        int *p = &buf1[n*y];
        simd128 v0, v1;

        simd128_load(v0, p);
        simd128_load(v1, p+4);

        mylib_display_hex(v0[0]);
        mylib_display_char(' ');
        mylib_display_hex(v0[1]);
        mylib_display_char(' ');
        mylib_display_hex(v0[2]);
        mylib_display_char(' ');
        mylib_display_hex(v0[3]);
        mylib_display_char(' ');

        mylib_display_hex(v1[0]);
        mylib_display_char(' ');
        mylib_display_hex(v1[1]);
        mylib_display_char(' ');
        mylib_display_hex(v1[2]);
        mylib_display_char(' ');
        mylib_display_hex(v1[3]);
        mylib_display_char(' ');

        mylib_display_newline();
    }

#elif USE_SIMD == 1

    for(y = 0; y < 16; y++) {
        int *p = &buf1[n*y];
        int v0, v1, v2, v3, v4, v5, v6, v7;

        /* load two quadwords onto SPR[1] and SPR[2] */
        asm volatile (".set    noat\n\t"
                      "lq      $1,(%0)\n\t"
                      "lq      $2,16(%0)\n\t"
                      ".set    at\n"
                      : : "r" (p));

        asm volatile (".set    noat\n\t"
                      "nop\n\t"
                      /* read from first qword */
                      "pextw   %0,$1,0\n\t"
                      "pextw   %1,$1,1\n\t"
                      "pextw   %2,$1,2\n\t"
                      "pextw   %3,$1,3\n\t"
                      /* read from second qword */
                      "pextw   %4,$2,0\n\t"
                      "pextw   %5,$2,1\n\t"
                      "pextw   %6,$2,2\n\t"
                      "pextw   %7,$2,3\n\t"
                      ".set    at\n\t"
                      : "=r" (v0), "=r" (v1), "=r" (v2), "=r" (v3),
                        "=r" (v4), "=r" (v5), "=r" (v6), "=r" (v7) :);

        mylib_display_hex(v0);
        mylib_display_char(' ');
        mylib_display_hex(v1);
        mylib_display_char(' ');
        mylib_display_hex(v2);
        mylib_display_char(' ');
        mylib_display_hex(v3);
        mylib_display_char(' ');
        mylib_display_hex(v4);
        mylib_display_char(' ');
        mylib_display_hex(v5);
        mylib_display_char(' ');
        mylib_display_hex(v6);
        mylib_display_char(' ');
        mylib_display_hex(v7);
        mylib_display_char(' ');

        mylib_display_newline();
    }

#else
# error "illegal USE_SIMD setting"
#endif

#else
    for(y = 0; y < 16; y++) {
        for(x = 0; x < 8; x++) {
            mylib_display_hex(buf1[x + y*n]);
            mylib_display_char(' ');
        }
        mylib_display_newline();
    }
#endif

#ifdef USE_SIMD

#if USE_SIMD == 0

    int sum = 0;
    simd128 s = { 0, 0, 0, 0, };
    
    for (i = 0; i < n*n; i += 16) {
        simd128 s2, s3, s4, s5;

        simd128_load(s2, &buf1[i]);
        simd128_load(s3, &buf1[i+4]);
        simd128_load(s4, &buf1[i+8]);
        simd128_load(s5, &buf1[i+12]);

        simd128_add(s2, s2, s3);
        simd128_add(s4, s4, s5);

        simd128_add(s, s, s2);
        simd128_add(s, s, s4);

#ifdef  TRACE_OUT
        mylib_display_hex((int)&buf1[i]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(s2);
        mylib_display_newline();

        mylib_display_hex((int)&buf1[i+4]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(s3);
        mylib_display_newline();

        mylib_display_hex((int)&buf1[i+8]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(s4);
        mylib_display_newline();

        mylib_display_hex((int)&buf1[i+12]);
        mylib_display_char(':'); mylib_display_char(' ');
        simd128_display(s5);
        mylib_display_newline();

        mylib_display_char('s'); mylib_display_char('=');
        simd128_display(s);
        mylib_display_newline();
#endif

    }

    sum = s[0] + s[1] + s[2] + s[3];
    
    mylib_display_hex(sum);
    mylib_display_newline();

#elif USE_SIMD == 1

    int sum = 0;
    int s0, s1, s2, s3;

    /* set SPR[1] to zero (for summation) */
    asm volatile (".set    noat\n\t"
                  "psubw   $1,$0,$0\n\t"
                  ".set    at\n"
                  : : "r" (&buf1[i]));

    for (i = 0; i < n*n; i += 16) {
        asm volatile (".set    noat\n\t"
                      "lq      $2,(%0)\n\t"
                      "lq      $3,16(%0)\n\t"
                      "lq      $4,32(%0)\n\t"
                      "lq      $5,48(%0)\n\t"
                      "paddw   $2,$2,$3\n\t"
                      "nop\n\t"
                      "paddw   $4,$4,$5\n\t"
                      "paddw   $1,$1,$2\n\t"
                      "nop\n\t"
                      "nop\n\t"
                      "paddw   $1,$1,$4\n\t"
                      ".set    at\n"
                      : : "r" (&buf1[i]));
    }

    asm volatile (".set    noat\n\t"
                  "pextw   %0,$1,0\n\t"
                  "pextw   %1,$1,1\n\t"
                  "pextw   %2,$1,2\n\t"
                  "pextw   %3,$1,3\n\t"
                  ".set    at\n\t"
                  : "=r" (s0), "=r" (s1), "=r" (s2), "=r" (s3) :);

    sum = s0 + s1 + s2 + s3;

    mylib_display_hex(sum);
    mylib_display_newline();

#else
# error "illegal USE_SIMD setting"
#endif

#else
    int sum = 0;
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            sum += buf1[x + y*n];
        }
    }
    mylib_display_hex(sum);
    mylib_display_newline();
#endif

    mylib_finalize();
    return 0;
}
/**********************************************************************/
