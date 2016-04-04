/**********************************************************************/
/* The 1st IPSJ SIG-ARC High-Performance Processor Design Contest     */
/* 320mm Version 2013-10-13                                           */
/**********************************************************************/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

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
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            buf1[x + y*n] = init_data[d % (64*1024)];
            buf2[x + y*n] = 0;
            d++;
        }
    }

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

    printf("\n");

    for(y = 0; y < 16; y++) {
        for(x = 0; x < 8; x++) {
            printf("%08x ", buf1[x + y*n]);
        }
        printf("\n");
    }


    int sum = 0;
    for(y=0; y<n; y++) {
        for(x=0; x<n; x++) {
            sum += buf1[x + y*n];
        }
    }
    printf("%08x\n", sum);

    return 0;
}
/**********************************************************************/
