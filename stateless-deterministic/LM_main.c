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

#define MEASURE(x)			\
	for (i=0; i< WARMUP; i++)	\
	{x;}				\
	start_clk=get_Clks();		\
	for (i = 0; i < REPEAT; i++)	\
	{				\
		{x;}			\
	}				\
	end_clk=get_Clks();		\
	total_clk=(double)(end_clk-start_clk)/REPEAT;

typedef struct KEY_SCHEDULE {
	ALIGN16 unsigned char KEY[16*15];
	unsigned int nr;
} AES_KEY;

typedef union
{
	unsigned long long uint64_val;
	unsigned char c_val[sizeof(unsigned long long)];
} ctr_t; 

ALIGN16 uint8_t AES128_TEST_KEY1[] = {0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,
				     0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c};

ALIGN16 uint8_t AES128_TEST_KEY2[] = {0x1c,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,
				     0x15,0x1f,0x28,0xae,0xc3,0x4b,0x7e,0x10};

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
	AES_KEY key1, key2;
	uint8_t *PLAINTEXT;
	uint8_t TAGTEXT[STATE_SIZE]={0};
	uint8_t *CIPHER_KEY1;
	uint8_t *CIPHER_KEY2;
	int i,j;
	unsigned long k;
	int key_length;
	CIPHER_KEY1 = AES128_TEST_KEY1;
	CIPHER_KEY2 = AES128_TEST_KEY2;
	AES_set_encrypt_key(CIPHER_KEY1, &key1);
	AES_set_encrypt_key(CIPHER_KEY2, &key2);
	for(j=0x1;j<0x40001;j<<=1)
	{
		k = j<<7;
		PLAINTEXT = uniform_random_byte_sampler(k);
		MEASURE(LM(PLAINTEXT, TAGTEXT, key1.KEY, key2.KEY));
		printf("%llu ",total_calls);
		printf("%lf\n",total_clk/k);
		free(PLAINTEXT);
	}
}
