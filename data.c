/**********************************************************************/
/* The 1st IPSJ SIG-ARC High-Performance Processor Design Contest     */
/* for 320mm Version 2013-10-13                                       */
/**********************************************************************/
#include <stdio.h>
#include <stdlib.h>

/**********************************************************************/
#define SIZE (64*1024) 

/**********************************************************************/
#define VALUE_MAX (500)

unsigned int GetRandom()
{
    return (int)(rand()*(VALUE_MAX+1.0)/(1.0+RAND_MAX));
}

/**********************************************************************/
struct data_t {
    int buf[SIZE-2];  // 256KB -4Byte buffer
    int n;   
    int iter;
};

/**********************************************************************/
int main(int argc, char *argv[])
{
    FILE* fp;
    int i;

    struct data_t data;
    
    if (argc != 4) {
        printf("## Data Generator for 320_mm Ver.2013-10-13\n");
        printf("## Usage: ./data_gen i random_seed\n");
        printf("##      : n = i * 16\n");
        exit(1);
    }
    
    int random_seed = atoi(argv[3]);
    srand(random_seed);

    for (i=0; i<SIZE-1; i++){
        data.buf[i] = GetRandom();
        // printf("%d\n", data.buf[i]);
    }
    
    data.n    = 32 * atoi(argv[1]);
    data.iter =  2 * atoi(argv[2]);
    
    fp = fopen("330stencil.dat", "wb");
    if (fp==NULL) { fputs("fail to open\n", stderr); exit(1); }
    
    fwrite(&data, sizeof(unsigned int), SIZE, fp);
    fclose(fp);

    return 0;
}
/**********************************************************************/
