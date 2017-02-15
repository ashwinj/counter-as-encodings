#include<stdio.h>
#include<stdlib.h>

#ifdef C
#define D "./stateful-deterministic/CDXM.output"
#define K "./stateful-deterministic/CKXM.output"
#define L8 "./stateful-deterministic/CLXM8.output"
#define L16 "./stateful-deterministic/CLXM16.output"
#define L32 "./stateful-deterministic/CLXM32.output"
#define L64 "./stateful-deterministic/CLXM64.output"
#define CPB "./stateful-deterministic/C-CPB.dat"
#define CALLS "./stateful-deterministic/C-CALLS.dat"
#define LATEX "./stateful-deterministic/C-LATEX.dat"
#endif

#ifdef H
#define D "./haifa/DHAIFA.output"
#define K "./haifa/KHAIFA.output"
#define L8 "./haifa/LHAIFA8.output"
#define L16 "./haifa/LHAIFA16.output"
#define L32 "./haifa/LHAIFA32.output"
#define L64 "./haifa/LHAIFA64.output"
#define CPB "./haifa/H-CPB.dat"
#define CALLS "./haifa/H-CALLS.dat"
#define LATEX "./haifa/H-LATEX.dat"
#endif

#ifdef L
#define D "./stateless-deterministic/DLM.output"
#define K "./stateless-deterministic/KLLM.output"
#define L8 "./stateless-deterministic/LM8.output"
#define L16 "./stateless-deterministic/LM16.output"
#define L32 "./stateless-deterministic/LM32.output"
#define L64 "./stateless-deterministic/LM64.output"
#define CPB "./stateless-deterministic/L-CPB.dat"
#define CALLS "./stateless-deterministic/L-CALLS.dat"
#define LATEX "./stateless-deterministic/L-LATEX.dat"
#endif

int main()
{
	int i,x;
	unsigned int d, k, l8, l16, l32, l64;
	double dlm, kllm, lm8, lm16, lm32, lm64;
	FILE *dlm_f, *kllm_f, *lm8_f, *lm16_f, *lm32_f, *lm64_f, *cpb_f, *calls_f, *table_f;

	dlm_f = fopen(D,"r");
	kllm_f = fopen(K,"r");
	lm8_f = fopen(L8,"r");
	lm16_f = fopen(L16,"r");
	lm32_f = fopen(L32,"r");
	lm64_f = fopen(L64,"r");
	cpb_f = fopen(CPB,"w");
	calls_f = fopen(CALLS,"w");
	table_f = fopen(LATEX,"w");

	for(i = 7; i < 21; i++)
	{
		fscanf(dlm_f, "%d %lf\n", &d, &dlm);
		fscanf(kllm_f, "%d %lf\n", &k, &kllm);
		fscanf(lm64_f, "%d %lf\n", &l64, &lm64);
		fscanf(lm32_f, "%d %lf\n", &l32, &lm32);
		if(i < 12) {
			fscanf(lm16_f, "%d %lf\n", &l16, &lm16);
			fscanf(lm8_f, "%d %lf\n", &l8, &lm8);
			fprintf(calls_f, "%d %lf %lf %lf %lf %lf %lf\n", 
					i, (double)(1<<(i-4))/d, (double)(1<<(i-4))/k, (double)(1<<(i-4))/l64, 
					(double)(1<<(i-4))/l32, (double)(1<<(i-4))/l16, (double)(1<<(i-4))/l8);
			fprintf(cpb_f, "%d %lf %lf %lf %lf %lf %lf\n", 
					i, (double)dlm, (double)kllm, (double)lm64, (double)lm32, (double)lm16, (double)lm8);
			fprintf(table_f, "& %.2lf & %.2lf & %.2lf & %.2lf & %.2lf & %.2lf\\\\ \\hline\n", 
					(double)lm8, (double)lm16, (double)lm32, (double)lm64, (double)kllm, (double)dlm);
		}
		else if(i < 20) {
			fscanf(lm16_f, "%d %lf\n", &l16, &lm16);
			fprintf(calls_f, "%d %lf %lf %lf %lf %lf\n", 
					i, (double)(1<<(i-4))/d, (double)(1<<(i-4))/k, (double)(1<<(i-4))/l64, 
					(double)(1<<(i-4))/l32, (double)(1<<(i-4))/l16);
			fprintf(cpb_f, "%d %lf %lf %lf %lf %lf\n", 
					i, (double)dlm, (double)kllm, (double)lm64, (double)lm32, (double)lm16);
			fprintf(table_f, "& - & %.2lf & %.2lf & %.2lf & %.2lf & %.2lf\\\\ \\hline\n", 
					(double)lm16, (double)lm32, (double)lm64, (double)kllm, (double)dlm);
		}
		else {
			fprintf(calls_f, "%d %lf %lf %lf %lf\n",  
					i, (double)(1<<(i-4))/d, (double)(1<<(i-4))/k, 
					(double)(1<<(i-4))/l64, (double)(1<<(i-4))/l32);
			fprintf(cpb_f, "%d %lf %lf %lf %lf\n", 
					i, (double)dlm, (double)kllm, (double)lm64, (double)lm32);
			fprintf(table_f, "& - & - & %.2lf & %.2lf & %.2lf & %.2lf\\\\ \\hline\n", 
					(double)lm32, (double)lm64, (double)kllm, (double)dlm);
		}
	}
	fclose(dlm_f);
	fclose(kllm_f);
	fclose(lm8_f);
	fclose(lm16_f);
	fclose(lm32_f);
	fclose(lm64_f);
	fclose(cpb_f);
	fclose(calls_f);
	fclose(table_f);
	return 0;
}
