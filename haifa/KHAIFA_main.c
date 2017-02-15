#include<stdint.h>
#include<stdio.h>
#include<fcntl.h>
#include<string.h>
#include<wmmintrin.h>

#if !defined (ALIGN16)
#if defined (__GNUC__)
#define ALIGN16 __attribute__ ((aligned (16)))
#else
#define ALIGN16 __declspec (align (16))
#endif
#endif

#ifndef REPEAT
#define REPEAT 1000000
//#define REPEAT 4
#endif

#ifndef WARMUP
#define WARMUP REPEAT/4
#endif

#define STATE_SIZE		16
#define PARALLEL		8

uint64_t start_clk,end_clk;
double total_clk;

uint64_t total_calls;

inline uint64_t get_Clks(void) {
	uint64_t tmp;
	__asm__ volatile(
	"rdtsc\n\t\
	mov %%eax,(%0)\n\t\
	mov %%edx,4(%0)"::"rm"(&tmp):"eax","edx");
	return tmp;
}

#define MEASURE(x)						\
	for (i=0; i< WARMUP; i++)				\
	{x;}							\
	start_clk=get_Clks();					\
	for (i = 0; i < REPEAT; i++)				\
	{							\
		{x;}						\
	}							\
	end_clk=get_Clks();					\
	total_clk=(double)(end_clk-start_clk)/REPEAT;

unsigned char *uniform_random_byte_sampler(unsigned int num)
{
	unsigned char *bytes;
	int j,uniform_random_dist;
	bytes = (unsigned char *)malloc((num+16)*sizeof(unsigned char));
	uniform_random_dist = open("/dev/urandom",O_RDONLY);
	read(uniform_random_dist,bytes,num);
	for(j=0;j<num/8;*((unsigned long long *)bytes + j++) |= 0x2411214428112481LL);
	memset(bytes+num,0x0,16);
	bytes[num]=0x80;
	return bytes;
}

int main()
{
	uint8_t *PLAINTEXT;
	uint8_t HASH[STATE_SIZE]={0};
	int i,j;
	unsigned long k;
	for(j=0x1;j<0x40001;j<<=1)
	{	
		k = j<<7;
		PLAINTEXT = uniform_random_byte_sampler(k);
		MEASURE(KHAIFA(PLAINTEXT, HASH, k));
		printf("%llu ",total_calls);
		printf("%lf\n",total_clk/k);
		free(PLAINTEXT);
	}
}
