# 1 "./main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./main.c"
# 22 "./main.c"
# 1 "././lib.c" 1
# 34 "././lib.c"
static char output_buffer[1024];
static int output_buffer_size = 0;

static void output_buffer_flush()
{
    int retcode;


    asm volatile(
        "li\t$4,1\n\t"
        "move\t$5,%1\n\t"
        "move\t$6,%2\n\t"
        "li\t$2,4004\n\t"
        "syscall\n\t"
        "move\t%0,$2\n\t"
        : "=r"(retcode) : "r"(output_buffer), "r"(output_buffer_size) : "$2", "$4", "$5", "$6" );

    output_buffer_size = 0;
}

static void output_buffer_put(int c)
{
    output_buffer[output_buffer_size++] = c & 0xff;
    if (output_buffer_size >= 1024)
        output_buffer_flush();
}



void mylib_wait()
{
  volatile int sum = 0;
  int i;
  for(i = 0; i < 40; i++) sum += i;
}

void mylib_display_dec(int val)
{




  int i;
  int c[(256)];
  int cnt = 0;
  int minus_flag = 0;

  if (val < 0) {

    minus_flag = 1;

    val *= -1;
  }

  if (val == 0) {
    c[0] = '0';
    cnt = 1;
  } else {
    while (val) {
      c[cnt] = (val%10 == 0) ? '0' :
               (val%10 == 1) ? '1' :
           (val%10 == 2) ? '2' :
           (val%10 == 3) ? '3' :
           (val%10 == 4) ? '4' :
           (val%10 == 5) ? '5' :
           (val%10 == 6) ? '6' :
           (val%10 == 7) ? '7' :
           (val%10 == 8) ? '8' : '9';
      cnt++;
      val /= 10;
      if ((val == 0) && (minus_flag)) {
        c[cnt] = '-';
        cnt++;
      }
    }
  }

  for (i = cnt - 1; i >= 0; i--) {

    output_buffer_put(c[i]);



  }
}

void mylib_display_hex(int val)
{




  int i;
  int c[(8)];
  int cnt = 0;

  while (cnt < (8)) {
    c[cnt] = ((val & 0x0000000f) == 0) ? '0' :
             ((val & 0x0000000f) == 1) ? '1' :
             ((val & 0x0000000f) == 2) ? '2' :
             ((val & 0x0000000f) == 3) ? '3' :
             ((val & 0x0000000f) == 4) ? '4' :
             ((val & 0x0000000f) == 5) ? '5' :
             ((val & 0x0000000f) == 6) ? '6' :
             ((val & 0x0000000f) == 7) ? '7' :
             ((val & 0x0000000f) == 8) ? '8' :
             ((val & 0x0000000f) == 9) ? '9' :
             ((val & 0x0000000f) == 10) ? 'a' :
             ((val & 0x0000000f) == 11) ? 'b' :
             ((val & 0x0000000f) == 12) ? 'c' :
             ((val & 0x0000000f) == 13) ? 'd' :
             ((val & 0x0000000f) == 14) ? 'e' : 'f';
    cnt++;
    val = val >> 4;
  }

  for (i = cnt - 1; i >= 0; i--) {

    output_buffer_put(c[i]);



  }
}

void mylib_display_char(int val)
{




  output_buffer_put(val);

}

void mylib_display_newline()
{
  mylib_display_char('\n');
  mylib_display_char('\r');
}

void mylib_flush()
{

  output_buffer_flush();







}

void mylib_finalize()
{
  mylib_display_newline();
  mylib_display_char('E');
  mylib_display_char('N');
  mylib_display_char('D');
  mylib_display_newline();

  mylib_flush();



  asm volatile(
      "li\t$4,0\n\t"
      "li\t$2,4001\n\t"
      "syscall\n\t"
      : : : "$2", "$4" );



}



int dummy_mem[0x160000] __attribute__ ((section(".dummy_space"))) __attribute((aligned(16)));
# 23 "./main.c" 2
# 36 "./main.c"
int *init_data __attribute((aligned(16)));
int *init_n ;
int *init_iter ;
int buf[0x80000] __attribute__ ((section(".dummy_space2"))) __attribute((aligned(16)));
# 161 "./main.c"
int main(void) {



    int n;
    int iteration;

    extern int _binary_330stencil_dat_start[];
    extern int _binary_330stencil_dat_end[];
    extern int _binary_330stencil_dat_size;

    init_data = _binary_330stencil_dat_start;
    init_n = &init_data[0xfffe];
    init_iter = &init_data[0xffff];

    n = *init_n;
    iteration = *init_iter;
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

    int *buf1 = (int*) &buf[0x0];
    int *buf2 = (int*) &dummy_mem[0x0];

    int x, y, i;

    int d = 0;
# 263 "./main.c"
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
# 288 "./main.c"
         asm volatile (".set    noat\n\t"
                      "lq      $1,(%0)\n\t"
                      "lq      $2,16(%0)\n\t"
        ".set    at\n\t"
         :: "r"(&init_data[d]));


  asm volatile(".set   noat\n\t"
        "cache  0x0d,(%0)\n\t"
        "cache  0x0d,16(%0)\n\t"
        ".set   at\n\t"
        ::"r"(&buf1[i]));

  asm volatile(".set   noat\n\t"
                      "sq      $1,(%0)\n\t"
                      "sq      $2,16(%0)\n\t"
                      ".set    at\n"
                      : : "r" (&buf1[i]) );


        d = (d + 8) % (64*1024);
     }
# 325 "./main.c"
    for(i=0; i<(iteration/2); i++){
# 1167 "./main.c"
        int shift_out0, shift_out1, shift_out2;





        for(y=1; y<n-1; y++) {
# 1182 "./main.c"
            asm volatile (".set    noat\n\t");
# 1198 "./main.c"
            asm volatile ("lq      $2,16(%0)\n\t"
                          "lq      $1,(%0)\n\t"
                          "nop\n\t"
                          "pextw   $1,$2,0\n\t"
                          "psllww  $3,$1,$0\n\t"
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"
                          "paddw   $13,$1,$3\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"
                          :: "r" (buf1 + (y-1)*n) );


            asm volatile ("lq      $6,16(%0)\n\t"
                          "lq      $5,(%0)\n\t"
                          "nop\n\t"
                          "pextw   $1,$6,0\n\t"
                          "psllww  $7,$5,$0\n\t"
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"
                          "paddw   $14,$5,$7\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"
                          :: "r" (buf1 + y*n) );


            asm volatile ("lq      $10,16(%0)\n\t"
                          "lq      $9,(%0)\n\t"
                          "nop\n\t"
                          "pextw   $1,$10,0\n\t"
                          "psllww  $11,$9,$0\n\t"
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"
                          "paddw   $15,$9,$11\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"
                          :: "r" (buf1 + (y+1)*n) );


            asm volatile ("paddw   $16,$13,$14\n\t"
                          "move    $1,%0\n\t"
                          "nop\n\t"
                          "paddw   $16,$16,$15\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"
                          "pmfhi   $16\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"
                          :: "r" (0x38e38e39));


            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,0\n\t"
                          :: "r" (buf2[y*n + 0]));



     asm volatile (".set   noat\n\t"
     "cache  0x0d,(%0)\n\t"
     ".set   at\n\t"
     ::"r"(buf2+y*n));
            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"
                          :: "r" (buf2 + y*n) );

            asm volatile (".set    at\n\t");

            for(x = 4; x < n-1 -3; x += 4) {

                asm volatile (".set    noat\n\t");




                asm volatile ("pextw   %0,$1,3\n\t"
                              "pextw   %1,$5,3\n\t"
                              "pextw   %2,$9,3\n\t"
                              : "=r" (shift_out0),
                                "=r" (shift_out1),
                                "=r" (shift_out2)
                              : );
# 1314 "./main.c"
                asm volatile (
                              "paddw   $1,$2,$0\n\t"
                              "lq      $2,(%0)\n\t"
                              "paddw   $5,$6,$0\n\t"
                              "lq      $6,(%1)\n\t"
                              "paddw   $9,$10,$0\n\t"
                              "lq      $10,(%2)\n\t"
         :
                              : "r" (buf1 + (y-1)*n + x + 4),
                                "r" (buf1 + y*n + x + 4),
                                "r" (buf1 + (y+1)*n + x + 4) );


                asm volatile ("pextw   $1,$2,0\n\t"
                              "psllww  $3,$1,%0\n\t"
                              "nop\n\t"
                              "psrlww  $4,$1,$1\n\t"
                              "paddw   $13,$1,$3\n\t"
                              "nop\n\t"
                              "nop\n\t"
                              "paddw   $13,$13,$4\n\t"
                              :: "r" (shift_out0) );


                asm volatile ("pextw   $1,$6,0\n\t"
                              "psllww  $7,$5,%0\n\t"
                              "nop\n\t"
                              "psrlww  $8,$5,$1\n\t"
                              "paddw   $14,$5,$7\n\t"
                              "nop\n\t"
                              "nop\n\t"
                              "paddw   $14,$14,$8\n\t"
                              :: "r" (shift_out1) );


                asm volatile ("pextw   $1,$10,0\n\t"
                              "psllww  $11,$9,%0\n\t"
                              "nop\n\t"
                              "psrlww  $12,$9,$1\n\t"
                              "paddw   $15,$9,$11\n\t"
                              "nop\n\t"
                              "nop\n\t"
                              "paddw   $15,$15,$12\n\t"
                              :: "r" (shift_out2) );


                asm volatile ("paddw   $16,$13,$14\n\t"
                              "move    $1,%0\n\t"
                              "nop\n\t"
                              "paddw   $16,$16,$15\n\t"
                              "nop\n\t"
                              "nop\n\t"
                              "pmultsw $16,$1\n\t"
                              "pmfhi   $16\n\t"
                              "nop\n\t"
                              "nop\n\t"
                              "psraw   $16,$16,1\n\t"
                              :: "r" (0x38e38e39) );


  asm volatile ("cache 0x0d,(%0)\n\t"
         "nop\n\t"
                              "nop\n\t"
                              "sq      $16,(%0)\n\t"
         ::"r" (buf2 + y*n + x));

                asm volatile (".set    at\n\t");
            }

            asm volatile (".set    noat\n\t");


            asm volatile ("pextw   %0,$1,3\n\t"
                          "pextw   %1,$5,3\n\t"
                          "pextw   %2,$9,3\n\t"

                          : "=r" (shift_out0),
                            "=r" (shift_out1),
                            "=r" (shift_out2)
                          : );
# 1408 "./main.c"
            asm volatile (
                          "paddw   $1,$2,$0\n\t"
                          "lq      $2,(%0)\n\t"
                          "paddw   $5,$6,$0\n\t"
                          "lq      $6,(%1)\n\t"
                          "paddw   $9,$10,$0\n\t"
                          "lq      $10,(%2)\n\t"
     :
                          : "r" (buf1 + (y-1)*n + x + 4),
                            "r" (buf1 + y*n + x + 4),
                            "r" (buf1 + (y+1)*n + x + 4) );


            asm volatile ("pextw   $1,$2,0\n\t"
                          "psllww  $3,$1,%0\n\t"
                          "nop\n\t"
                          "psrlww  $4,$1,$1\n\t"
                          "paddw   $13,$1,$3\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $13,$13,$4\n\t"
                          :: "r" (shift_out0) );


            asm volatile ("pextw   $1,$6,0\n\t"
                          "psllww  $7,$5,%0\n\t"
                          "nop\n\t"
                          "psrlww  $8,$5,$1\n\t"
                          "paddw   $14,$5,$7\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $14,$14,$8\n\t"
                          :: "r" (shift_out1) );


            asm volatile ("pextw   $1,$10,0\n\t"
                          "psllww  $11,$9,%0\n\t"
                          "nop\n\t"
                          "psrlww  $12,$9,$1\n\t"
                          "paddw   $15,$9,$11\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "paddw   $15,$15,$12\n\t"
                          :: "r" (shift_out2) );


            asm volatile ("paddw   $16,$13,$14\n\t"
                          "move    $1,%0\n\t"
                          "nop\n\t"
                          "paddw   $16,$16,$15\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "pmultsw $16,$1\n\t"
                          "pmfhi   $16\n\t"
                          "nop\n\t"
                          "nop\n\t"
                          "psraw   $16,$16,1\n\t"
                          :: "r" (0x38e38e39));


            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "pinsw   $16,$16,%0,3\n\t"
                          :: "r" (buf2[y*n + x + 3]) );


     asm volatile (".set   noat\n\t"
     "cache  0x0d,(%0)\n\t"
     ".set   at\n\t"
     ::"r"(buf2 + y*n + x));

            asm volatile ("nop\n\t"
                          "nop\n\t"
                          "sq      $16,(%0)\n\t"
                          :: "r" (buf2 + y*n + x) );

            asm volatile (".set    at\n\t");
        }

        buf2[n+1] = 0x9999999;






        for(y=1; y<n-1; y++) {
# 1517 "./main.c"
   asm volatile (".set    noat\n\t");


   asm volatile ("lq      $2,16(%0)\n\t"
   "lq      $1,(%0)\n\t"
   "nop\n\t"
   "pextw   $1,$2,0\n\t"
   "psllww  $3,$1,$0\n\t"
   "nop\n\t"
   "psrlww  $4,$1,$1\n\t"
   "paddw   $13,$1,$3\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $13,$13,$4\n\t"
   :: "r" (buf2 + (y-1)*n) );


   asm volatile ("lq      $6,16(%0)\n\t"
   "lq      $5,(%0)\n\t"
   "nop\n\t"
   "pextw   $1,$6,0\n\t"
   "psllww  $7,$5,$0\n\t"
   "nop\n\t"
   "psrlww  $8,$5,$1\n\t"
   "paddw   $14,$5,$7\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $14,$14,$8\n\t"
   :: "r" (buf2 + y*n) );


   asm volatile ("lq      $10,16(%0)\n\t"
   "lq      $9,(%0)\n\t"
   "nop\n\t"
   "pextw   $1,$10,0\n\t"
   "psllww  $11,$9,$0\n\t"
   "nop\n\t"
   "psrlww  $12,$9,$1\n\t"
   "paddw   $15,$9,$11\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $15,$15,$12\n\t"
   :: "r" (buf2 + (y+1)*n) );


   asm volatile ("paddw   $16,$13,$14\n\t"
   "move    $1,%0\n\t"
   "nop\n\t"
   "paddw   $16,$16,$15\n\t"
   "nop\n\t"
   "nop\n\t"
   "pmultsw $16,$1\n\t"
   "pmfhi   $16\n\t"
   "nop\n\t"
   "nop\n\t"
   "psraw   $16,$16,1\n\t"
   :: "r" (0x38e38e39));


   asm volatile ("nop\n\t"
   "nop\n\t"
   "pinsw   $16,$16,%0,0\n\t"
   :: "r" (buf1[y*n + 0]));
# 1588 "./main.c"
   asm volatile ("cache   0x0d,(%0)\n\t"
   "nop\n\t"
   "nop\n\t"
   "sq      $16,(%0)\n\t"
   :: "r" (buf1 + y*n) );

   asm volatile (".set    at\n\t");

   for(x = 4; x < n-1 -3; x += 4) {

     asm volatile (".set    noat\n\t");


     asm volatile ("pextw   %0,$1,3\n\t"
     "pextw   %1,$5,3\n\t"
     "pextw   %2,$9,3\n\t"
     : "=r" (shift_out0),
       "=r" (shift_out1),
       "=r" (shift_out2)
     : );
# 1639 "./main.c"
     asm volatile (
     "paddw   $1,$2,$0\n\t"
     "lq      $2,(%0)\n\t"
     "paddw   $5,$6,$0\n\t"
     "lq      $6,(%1)\n\t"
     "paddw   $9,$10,$0\n\t"
     "lq      $10,(%2)\n\t"
     :
     : "r" (buf2 + (y-1)*n + x + 4),
       "r" (buf2 + y*n + x + 4),
       "r" (buf2 + (y+1)*n + x + 4) );


     asm volatile ("pextw   $1,$2,0\n\t"
     "psllww  $3,$1,%0\n\t"
     "nop\n\t"
     "psrlww  $4,$1,$1\n\t"
     "paddw   $13,$1,$3\n\t"
     "nop\n\t"
     "nop\n\t"
     "paddw   $13,$13,$4\n\t"
     :: "r" (shift_out0) );


     asm volatile ("pextw   $1,$6,0\n\t"
     "psllww  $7,$5,%0\n\t"
     "nop\n\t"
     "psrlww  $8,$5,$1\n\t"
     "paddw   $14,$5,$7\n\t"
     "nop\n\t"
     "nop\n\t"
     "paddw   $14,$14,$8\n\t"
     :: "r" (shift_out1) );


     asm volatile ("pextw   $1,$10,0\n\t"
     "psllww  $11,$9,%0\n\t"
     "nop\n\t"
     "psrlww  $12,$9,$1\n\t"
     "paddw   $15,$9,$11\n\t"
     "nop\n\t"
     "nop\n\t"
     "paddw   $15,$15,$12\n\t"
     :: "r" (shift_out2) );


     asm volatile ("paddw   $16,$13,$14\n\t"
     "move    $1,%0\n\t"
     "nop\n\t"
     "paddw   $16,$16,$15\n\t"
     "nop\n\t"
     "nop\n\t"
     "pmultsw $16,$1\n\t"
     "pmfhi   $16\n\t"
     "nop\n\t"
     "nop\n\t"
     "psraw   $16,$16,1\n\t"
     :: "r" (0x38e38e39) );

     asm volatile( "cache  0x0d,(%0)\n\t"
     "nop\n\t"
     "nop\n\t"
     "sq      $16,(%0)\n\t"
     :: "r" (buf1 + y*n + x));

     asm volatile (".set    at\n\t");
   }

   asm volatile (".set    noat\n\t");


   asm volatile ("pextw   %0,$1,3\n\t"
   "pextw   %1,$5,3\n\t"
   "pextw   %2,$9,3\n\t"
   : "=r" (shift_out0),
     "=r" (shift_out1),
     "=r" (shift_out2)
   : );
# 1733 "./main.c"
   asm volatile (
   "paddw   $1,$2,$0\n\t"
   "lq      $2,(%0)\n\t"
   "paddw   $5,$6,$0\n\t"
   "lq      $6,(%1)\n\t"
   "paddw   $9,$10,$0\n\t"
   "lq      $10,(%2)\n\t"
   :
   : "r" (buf2 + (y-1)*n + x + 4),
     "r" (buf2 + y*n + x + 4),
     "r" (buf2 + (y+1)*n + x + 4) );


   asm volatile ("pextw   $1,$2,0\n\t"
   "psllww  $3,$1,%0\n\t"
   "nop\n\t"
   "psrlww  $4,$1,$1\n\t"
   "paddw   $13,$1,$3\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $13,$13,$4\n\t"
   :: "r" (shift_out0) );


   asm volatile ("pextw   $1,$6,0\n\t"
   "psllww  $7,$5,%0\n\t"
   "nop\n\t"
   "psrlww  $8,$5,$1\n\t"
   "paddw   $14,$5,$7\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $14,$14,$8\n\t"
   :: "r" (shift_out1) );


   asm volatile ("pextw   $1,$10,0\n\t"
   "psllww  $11,$9,%0\n\t"
   "nop\n\t"
   "psrlww  $12,$9,$1\n\t"
   "paddw   $15,$9,$11\n\t"
   "nop\n\t"
   "nop\n\t"
   "paddw   $15,$15,$12\n\t"
   :: "r" (shift_out2) );


   asm volatile ("paddw   $16,$13,$14\n\t"
   "move    $1,%0\n\t"
   "nop\n\t"
   "paddw   $16,$16,$15\n\t"
   "nop\n\t"
   "nop\n\t"
   "pmultsw $16,$1\n\t"
   "pmfhi   $16\n\t"
   "nop\n\t"
   "nop\n\t"
   "psraw   $16,$16,1\n\t"
   :: "r" (0x38e38e39));


   asm volatile ("nop\n\t"
   "nop\n\t"
   "pinsw   $16,$16,%0,3\n\t"
   :: "r" (buf1[y*n + x + 3]) );

   asm volatile ("nop\n\t"
   "nop\n\t"
   "sq      $16,(%0)\n\t"
   :: "r" (buf1 + y*n + x) );

   asm volatile (".set    at\n\t");
        }

        buf1[n+1] = 0x9999999;
# 1840 "./main.c"
    }

    mylib_display_newline();
# 1878 "./main.c"
    for(y = 0; y < 16; y++) {
        int *p = &buf1[n*y];
        int v0, v1, v2, v3, v4, v5, v6, v7;


        asm volatile (".set    noat\n\t"
                      "lq      $1,(%0)\n\t"
                      "lq      $2,16(%0)\n\t"
                      ".set    at\n"
                      : : "r" (p));

        asm volatile (".set    noat\n\t"
                      "nop\n\t"

                      "pextw   %0,$1,0\n\t"
                      "pextw   %1,$1,1\n\t"
                      "pextw   %2,$1,2\n\t"
                      "pextw   %3,$1,3\n\t"

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
# 2013 "./main.c"
    int sum = 0;
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            sum += buf1[x + y*n];
        }
    }
    mylib_display_hex(sum);
    mylib_display_newline();






    mylib_finalize();
    return 0;
}
