//	void CLXM (const unsigned char *in,
//			      unsigned char *tag,
//			      const unsigned char *KS1,
//			      unsigned char *ctr)

.extern total_calls

.globl CLXM
CLXM:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx

# setting up
	pxor	%xmm0, %xmm0
	pxor	%xmm13, %xmm13
	xorq	%r8, %r8
	xorq	%r12, %r12
	movq	$0x8000000000000000, %r13
	movq	$0x00007f0000000000, %r10
	pinsrq	$0x1, %r10, %xmm13
	addq	$-112, %rdi

# add some check for maximum message length

PROCESS_BLOCK:
	addq	$112, %rdi
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL_1
	pinsrw	$0x7, %r8d, %xmm1
	incq	%r8

	movdqu	14(%rdi), %xmm2
	ptest	%xmm2, %xmm13
	je	RESIDUAL_2
	pinsrw	$0x7, %r8d, %xmm2
	incq	%r8

	movdqu	28(%rdi), %xmm3
	ptest	%xmm3, %xmm13
	je	RESIDUAL_3
	pinsrw	$0x7, %r8d, %xmm3
	incq	%r8

	movdqu	42(%rdi), %xmm4
	ptest	%xmm4, %xmm13
	je	RESIDUAL_4
	pinsrw	$0x7, %r8d, %xmm4
	incq	%r8

	movdqu	56(%rdi), %xmm5
	ptest	%xmm5, %xmm13
	je	RESIDUAL_5
	pinsrw	$0x7, %r8d, %xmm5
	incq	%r8

	movdqu	70(%rdi), %xmm6
	ptest	%xmm6, %xmm13
	je	RESIDUAL_6
	pinsrw	$0x7, %r8d, %xmm6
	incq	%r8

	movdqu	84(%rdi), %xmm7
	ptest	%xmm7, %xmm13
	je	RESIDUAL_7
	pinsrw	$0x7, %r8d, %xmm7
	incq	%r8

	movdqu	98(%rdi), %xmm8
	ptest	%xmm8, %xmm13
	je	RESIDUAL_8
	pinsrw	$0x7, %r8d, %xmm8
	incq	%r8

PIPELINED:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4
	pxor	%xmm9, %xmm5
	pxor	%xmm9, %xmm6
	pxor	%xmm9, %xmm7
	pxor	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7
	aesenc	%xmm11, %xmm8

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7
	aesenc	%xmm12, %xmm8

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7
	aesenc	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7
	aesenc	%xmm11, %xmm8

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7
	aesenc	%xmm12, %xmm8

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7
	aesenc	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	aesenclast	%xmm11, %xmm5
	aesenclast	%xmm11, %xmm6
	aesenclast	%xmm11, %xmm7
	aesenclast	%xmm11, %xmm8
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm5, %xmm6
	pxor		%xmm7, %xmm8
	pxor		%xmm2, %xmm4
	pxor		%xmm6, %xmm8
	pxor		%xmm4, %xmm8
	pxor		%xmm8, %xmm0

	addq		$8, %r12	

	jmp		PROCESS_BLOCK

RESIDUAL_1:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	aesenc	%xmm10, %xmm1
	aesenc	%xmm11, %xmm1
	aesenc	%xmm12, %xmm1

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm10, %xmm1
	aesenc	%xmm11, %xmm1
	aesenc	%xmm12, %xmm1

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc		%xmm9, %xmm1
	aesenc		%xmm10, %xmm1
	aesenclast	%xmm11, %xmm1

	pxor		%xmm1, %xmm0

	addq		$1, %r12

	jmp FINAL_ENC

RESIDUAL_2:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2

	pxor		%xmm1, %xmm0
	pxor		%xmm2, %xmm0

	addq		$2, %r12

	jmp FINAL_ENC

RESIDUAL_3:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm0
	pxor		%xmm2, %xmm0

	addq		$3, %r12

	jmp FINAL_ENC

RESIDUAL_4:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm2, %xmm0
	pxor		%xmm4, %xmm0

	addq		$4, %r12

	jmp FINAL_ENC

RESIDUAL_5:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4
	pxor	%xmm9, %xmm5

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	aesenclast	%xmm11, %xmm5
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm5, %xmm0
	pxor		%xmm2, %xmm4
	pxor		%xmm4, %xmm0

	addq		$5, %r12

	jmp FINAL_ENC

RESIDUAL_6:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4
	pxor	%xmm9, %xmm5
	pxor	%xmm9, %xmm6

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	aesenclast	%xmm11, %xmm5
	aesenclast	%xmm11, %xmm6
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm5, %xmm6
	pxor		%xmm2, %xmm4
	pxor		%xmm6, %xmm0
	pxor		%xmm4, %xmm0

	addq		$6, %r12

	jmp FINAL_ENC

RESIDUAL_7:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4
	pxor	%xmm9, %xmm5
	pxor	%xmm9, %xmm6
	pxor	%xmm9, %xmm7

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	aesenclast	%xmm11, %xmm5
	aesenclast	%xmm11, %xmm6
	aesenclast	%xmm11, %xmm7
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm5, %xmm6
	pxor		%xmm7, %xmm0
	pxor		%xmm2, %xmm4
	pxor		%xmm6, %xmm0
	pxor		%xmm4, %xmm0

	addq		$7, %r12

	jmp FINAL_ENC

RESIDUAL_8:
	movdqa	(%rdx), %xmm9
	movdqa	16(%rdx), %xmm10
	movdqa	32(%rdx), %xmm11
	movdqa	48(%rdx), %xmm12

	pxor	%xmm9, %xmm1
	pxor	%xmm9, %xmm2
	pxor	%xmm9, %xmm3
	pxor	%xmm9, %xmm4
	pxor	%xmm9, %xmm5
	pxor	%xmm9, %xmm6
	pxor	%xmm9, %xmm7
	pxor	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7
	aesenc	%xmm11, %xmm8

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7
	aesenc	%xmm12, %xmm8

	movdqa	64(%rdx), %xmm9
	movdqa	80(%rdx), %xmm10
	movdqa	96(%rdx), %xmm11
	movdqa	112(%rdx), %xmm12

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7
	aesenc	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenc	%xmm11, %xmm1
	aesenc	%xmm11, %xmm2
	aesenc	%xmm11, %xmm3
	aesenc	%xmm11, %xmm4
	aesenc	%xmm11, %xmm5
	aesenc	%xmm11, %xmm6
	aesenc	%xmm11, %xmm7
	aesenc	%xmm11, %xmm8

	aesenc	%xmm12, %xmm1
	aesenc	%xmm12, %xmm2
	aesenc	%xmm12, %xmm3
	aesenc	%xmm12, %xmm4
	aesenc	%xmm12, %xmm5
	aesenc	%xmm12, %xmm6
	aesenc	%xmm12, %xmm7
	aesenc	%xmm12, %xmm8

	movdqa	128(%rdx), %xmm9
	movdqa	144(%rdx), %xmm10
	movdqa	160(%rdx), %xmm11

	aesenc	%xmm9, %xmm1
	aesenc	%xmm9, %xmm2
	aesenc	%xmm9, %xmm3
	aesenc	%xmm9, %xmm4
	aesenc	%xmm9, %xmm5
	aesenc	%xmm9, %xmm6
	aesenc	%xmm9, %xmm7
	aesenc	%xmm9, %xmm8

	aesenc	%xmm10, %xmm1
	aesenc	%xmm10, %xmm2
	aesenc	%xmm10, %xmm3
	aesenc	%xmm10, %xmm4
	aesenc	%xmm10, %xmm5
	aesenc	%xmm10, %xmm6
	aesenc	%xmm10, %xmm7
	aesenc	%xmm10, %xmm8

	aesenclast	%xmm11, %xmm1
	aesenclast	%xmm11, %xmm2
	aesenclast	%xmm11, %xmm3
	aesenclast	%xmm11, %xmm4
	aesenclast	%xmm11, %xmm5
	aesenclast	%xmm11, %xmm6
	aesenclast	%xmm11, %xmm7
	aesenclast	%xmm11, %xmm8
	
	pxor		%xmm1, %xmm2
	pxor		%xmm3, %xmm4
	pxor		%xmm5, %xmm6
	pxor		%xmm7, %xmm8
	pxor		%xmm2, %xmm4
	pxor		%xmm6, %xmm8
	pxor		%xmm4, %xmm8
	pxor		%xmm8, %xmm0

	addq		$8, %r12

	jmp		FINAL_ENC	

FINAL_ENC:
	movq	(%rcx), %r8
	movq	8(%rcx), %r9
	movq	%r8, %xmm1
	pinsrq	$0x1, %r9, %xmm1

	pxor	%xmm3, %xmm3
	pinsrq	$0x1, %r13, %xmm3
	por	%xmm3, %xmm1
	
	pxor	(%rdx), %xmm1

	movdqu	160(%rdx), %xmm2

	aesenc		16(%rdx), %xmm1
	aesenc		32(%rdx), %xmm1
	aesenc		48(%rdx), %xmm1
	aesenc		64(%rdx), %xmm1
	aesenc		80(%rdx), %xmm1
	aesenc		96(%rdx), %xmm1
	aesenc		112(%rdx), %xmm1
	aesenc		128(%rdx), %xmm1
	aesenc		144(%rdx), %xmm1
	aesenclast	%xmm2, %xmm1

	pxor		%xmm1, %xmm0

	movdqu		%xmm0, (%rsi)
	movq		%r12, total_calls

	inc	%r8
	jne	EXIT
	inc	%r9
	movq	%r9, 8(%rcx)
EXIT:
	movq	%r8, (%rcx)

	ret
