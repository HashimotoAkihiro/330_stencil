/***************************************************************************/
/* The 2nd ARC/CPSY/RECONF High-Performance Computer System Design Contest */
/* lib.c Version 2014-06-06                                                */
/***************************************************************************/

/*
 * modified for running on gem5/MIPS simulator (SE-mode)
 *   by kim 2014.11.26
 */

//#define GEM5_MIPS       /* comment-out me if you want to use for MIQS processor */

#define DIGIT_DEC (256)
#define DIGIT_HEX (8)

#ifndef WAITCOUNT
#define WAITCOUNT 40    /* default 40 (value for real MIQS processor) */
#endif

#ifdef __ALTERA__
#define TXD_ADR 0x00041000
#elif defined __XILINX__
#define TXD_ADR 0x00000000
#else
#define TXD_ADR 0x00000000
#endif

#ifdef  GEM5_MIPS

#ifndef OBUFSIZE
#define OBUFSIZE  1024  /* buffer size of output */
#endif

static char output_buffer[OBUFSIZE];
static int output_buffer_size = 0;

static void output_buffer_flush()
{
    int retcode;

    /* write to stdout */
    asm volatile(
        "li\t$4,1\n\t"            /* 1 is file descriptor number for stdout */
        "move\t$5,%1\n\t"
        "move\t$6,%2\n\t"
        "li\t$2,4004\n\t"         /* 4004 is the function code of 'write'-syscall */
        "syscall\n\t"
        "move\t%0,$2\n\t"
        : "=r"(retcode) : "r"(output_buffer), "r"(output_buffer_size) : "$2", "$4", "$5", "$6" );

    output_buffer_size = 0;
}

static void output_buffer_put(int c)
{
    output_buffer[output_buffer_size++] = c & 0xff;
    if (output_buffer_size >= OBUFSIZE)
        output_buffer_flush();
}

#endif

void mylib_wait()
{
  volatile int sum = 0;
  int i;
  for(i = 0; i < WAITCOUNT; i++) sum += i;
}

void mylib_display_dec(int val)
{
#ifndef GEM5_MIPS
  volatile int *e_txd = (int*) TXD_ADR; // memory mapped I/O
#endif

  int i;
  int c[DIGIT_DEC];
  int cnt = 0;
  int minus_flag = 0;
  
  if (val < 0) {
    /* ----- setting + or -  ----- */
    minus_flag = 1;
    /* ----- calclate absolute value ----- */
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
#ifdef  GEM5_MIPS
    output_buffer_put(c[i]);
#else
    mylib_wait(); *e_txd = c[i];
#endif
  }
}

void mylib_display_hex(int val)
{
#ifndef GEM5_MIPS
  volatile int *e_txd = (int*) TXD_ADR; // memory mapped I/O
#endif

  int i;
  int c[DIGIT_HEX]; 
  int cnt = 0;
  
  while (cnt < DIGIT_HEX) {
    c[cnt] = ((val & 0x0000000f) == 0)  ? '0' :
             ((val & 0x0000000f) == 1)  ? '1' :        
             ((val & 0x0000000f) == 2)  ? '2' :        
             ((val & 0x0000000f) == 3)  ? '3' :        
             ((val & 0x0000000f) == 4)  ? '4' :        
             ((val & 0x0000000f) == 5)  ? '5' :        
             ((val & 0x0000000f) == 6)  ? '6' :        
             ((val & 0x0000000f) == 7)  ? '7' :        
             ((val & 0x0000000f) == 8)  ? '8' :        
             ((val & 0x0000000f) == 9)  ? '9' :        
             ((val & 0x0000000f) == 10) ? 'a' :        
             ((val & 0x0000000f) == 11) ? 'b' :        
             ((val & 0x0000000f) == 12) ? 'c' :        
             ((val & 0x0000000f) == 13) ? 'd' :        
             ((val & 0x0000000f) == 14) ? 'e' : 'f';
    cnt++;
    val = val >> 4;
  }
  
  for (i = cnt - 1; i >= 0; i--) {
#ifdef  GEM5_MIPS
    output_buffer_put(c[i]);
#else
    mylib_wait(); *e_txd = c[i];
#endif
  }
}

void mylib_display_char(int val)
{
#ifndef GEM5_MIPS
  volatile int *e_txd = (int*) TXD_ADR; // memory mapped I/O
  mylib_wait(); *e_txd = val;
#else
  output_buffer_put(val);
#endif
}

void mylib_display_newline()
{
  mylib_display_char('\n');
  mylib_display_char('\r');
}

void mylib_flush() 
{
#ifdef  GEM5_MIPS
  output_buffer_flush();
#else
  int i;
  for(i=0; i<1024; i++) // flush size = 1024
    {
      mylib_display_char('_');
    }
#endif
}

void mylib_finalize()
{
  mylib_display_newline();
  mylib_display_char('E');
  mylib_display_char('N');
  mylib_display_char('D');
  mylib_display_newline();

  mylib_flush();

#ifdef GEM5_MIPS
  /* exit syscall */
  asm volatile(
      "li\t$4,0\n\t"            /* process exit-code (0: exit success) */
      "li\t$2,4001\n\t"         /* 4001 is the function code of 'exit'-syscall */
      "syscall\n\t"
      : : : "$2", "$4" );
#else
  while(1);
#endif
}
#ifdef GEM5_MIPS
#define SIZE 0x160000
//char dummy_mem[0x80000] __attribute__ ((section(".dummy_space")));
int dummy_mem[SIZE] __attribute__ ((section(".dummy_space"))) __attribute((aligned(16)));
#endif
