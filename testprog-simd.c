/**********************************************************************/
/* The 1st IPSJ SIG-ARC High-Performance Processor Design Contest     */
/* 320mm Version 2013-10-13                                           */
/**********************************************************************/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "../lib/simd-emu.c"

#define SIZE (64*1024)

volatile int init_data[SIZE];
volatile int *init_n = init_data + SIZE-2;
volatile int *init_iter = init_data + SIZE-1;

int BUF1[0x100000];
int BUF2[0x100000];


void setup_data()
{
    FILE *fp;
    fp = fopen("330stencil.dat", "rb");
    if (fp == NULL) {
        printf("fail to open file\n");
        exit(1);
    }
    
    fread((void *)init_data, sizeof(unsigned int), SIZE, fp);

    fclose(fp);
}


/**********************************************************************/
int main(void) {
    setup_data();

    int n         = *init_n;
    int iteration = *init_iter;

    /* n is multiple of 32,  i is multiple of 2 */
    printf("stencil n=%d i=%d\n", n, iteration);

    int *buf1 = BUF1;
    int *buf2 = BUF2;

    int x, y, i;

    int d = 0;
#if 1
    for(i = 0; i < n*n; i += 8) {
        simd128 v0, v1;
        simd128 zero = { 0, 0, 0, 0 };

        simd128_load(v0, (int*)&init_data[d]);
        simd128_load(v1, (int*)&init_data[d+4]);

        simd128_store(v0, &buf1[i]);
        simd128_store(v1, &buf1[i+4]);

        simd128_store(zero, &buf2[i]);
        simd128_store(zero, &buf2[i+4]);

        d = (d + 8) % (64*1024);
    }
#else
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            buf1[x + y*n] = init_data[d % (64*1024)];
            buf2[x + y*n] = 0;
            d++;
        }
    }
#endif

#if 1
    for(i=0; i<(iteration/2); i++){

#if 1
        for(y=1; y<n-1; y++) {
            long long int v;
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
            simd128_mult_scalar(hi, lo, u, 0x38e38e39);
            simd128_shift_right_arithmetic(u, hi, 1);

            /* first word of target line is untouched */
            u[0] = buf2[y*n + 0];

            simd128_store(u, buf2 + y*n);

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
        }

#else
        for(y=1; y<n-1; y++) {
            for(x=1; x<n-1; x++) {
                long long int v;
                int v1, v2, v3;

                v1 = buf1[(x-1) + (y-1)*n] +
                    buf1[(x  ) + (y-1)*n] +
                    buf1[(x+1) + (y-1)*n];

                v2 = buf1[(x-1) + (y  )*n] +
                    buf1[(x  ) + (y  )*n] +
                    buf1[(x+1) + (y  )*n];

                v3 = buf1[(x-1) + (y+1)*n] +
                    buf1[(x  ) + (y+1)*n] +
                    buf1[(x+1) + (y+1)*n];

//                v = (v1 + v2 + v3) / 9;
                v = (v1 + v2 + v3) * 0x38e38e39LL;
                v >>= 33;
//                v = v - ((v1 + v2 + v3) >> 31); /* only for negative val */

                buf2[(x) + (y)*n] = v;
            }
        }

#endif
/*
        printf("buf2(0): %08x %08x %08x %08x\n",
               buf2[n], buf2[n+1], buf2[n+2], buf2[n+3]);
        printf("buf2(1): %08x %08x %08x %08x\n",
               buf2[n+4], buf2[n+5], buf2[n+6], buf2[n+7]);
        printf("buf2(-2): %08x %08x %08x %08x\n",
               buf2[n*(n-1)-8], buf2[n*(n-1)-7],
               buf2[n*(n-1)-6], buf2[n*(n-1)-5]);
        printf("buf2(-1): %08x %08x %08x %08x\n",
               buf2[n*(n-1)-4], buf2[n*(n-1)-3],
               buf2[n*(n-1)-2], buf2[n*(n-1)-1]);
*/

        buf2[n+1] = 0x9999999; // hot spot

#if 1
        for(y=1; y<n-1; y++) {
            long long int v;
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
        }

#else
        for(y=1; y<n-1; y++) {
            for(x=1; x<n-1; x++) {
                long long int v;
                int v1, v2, v3;

                v1 = buf2[(x-1) + (y-1)*n] +
                    buf2[(x  ) + (y-1)*n] +
                    buf2[(x+1) + (y-1)*n];

                v2 = buf2[(x-1) + (y  )*n] +
                    buf2[(x  ) + (y  )*n] +
                    buf2[(x+1) + (y  )*n];

                v3 = buf2[(x-1) + (y+1)*n] +
                    buf2[(x  ) + (y+1)*n] +
                    buf2[(x+1) + (y+1)*n];

//                v = (v1 + v2 + v3) / 9;
                v = (v1 + v2 + v3) * 0x38e38e39LL;
                v >>= 33;
//                v = v - ((v1 + v2 + v3) >> 31); /* only for negative val */

                buf1[(x) + (y)*n] = v;
            }
        }
#endif

/*
        printf("buf1(0): %08x %08x %08x %08x\n",
               buf1[n], buf1[n+1], buf1[n+2], buf1[n+3]);
        printf("buf1(1): %08x %08x %08x %08x\n",
               buf1[n+4], buf1[n+5], buf1[n+6], buf1[n+7]);
        printf("buf1(-2): %08x %08x %08x %08x\n",
               buf1[n*(n-1)-8], buf1[n*(n-1)-7],
               buf1[n*(n-1)-6], buf1[n*(n-1)-5]);
        printf("buf1(-1): %08x %08x %08x %08x\n",
               buf1[n*(n-1)-4], buf1[n*(n-1)-3],
               buf1[n*(n-1)-2], buf1[n*(n-1)-1]);
*/

        buf1[n+1] = 0x9999999; // hot spot
    }

#else

    for(i=0; i<(iteration/2); i++){

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

    }
#endif

    printf("\n");

#if 1
    for(y = 0; y < 16; y++) {
        int *p = &buf1[n*y];
        simd128 v0, v1;

        simd128_load(v0, p);
        simd128_load(v1, p+4);

        printf("%08x %08x %08x %08x ",
               v0[0], v0[1], v0[2], v0[3]);
        printf("%08x %08x %08x %08x ",
               v1[0], v1[1], v1[2], v1[3]);

        printf("\n");
    }
#else
    for(y = 0; y < 16; y++) {
        for(x = 0; x < 8; x++) {
            printf("%08x ", buf1[x + y*n]);
        }
        printf("\n");
    }
#endif

#if 1
    int sum = 0;
    simd128 s0, s1;
    simd128 zero = {0, 0, 0, 0};

    simd128_move(s0, zero);
    simd128_move(s1, zero);

    for (i = 0; i < n*n; i += 8) {
        simd128 s2, s3;

        simd128_load(s2, &buf1[i]);
        simd128_load(s3, &buf1[i+4]);
        simd128_add(s0, s0, s2);
        simd128_add(s1, s1, s3);
    }

    sum = s0[0] + s0[1] + s0[2] + s0[3];
    sum += s1[0] + s1[1] + s1[2] + s1[3];
    
    printf("%08x\n", sum);
#else
    int sum = 0;
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            sum += buf1[x + y*n];
        }
    }
    printf("%08x\n", sum);
#endif

    return 0;
}
/**********************************************************************/
