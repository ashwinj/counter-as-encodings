//	void KLLM (const unsigned char *in,
//			      unsigned char *tag,
//			      unsigned long length,
//			      const unsigned char *KS1,
//			      const unsigned char *KS2)

.extern total_calls

.globl KLLM
KLLM:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
# parameter 5: %r8

# setting up
	pxor	%xmm0, %xmm0
	xorq	%r11, %r11

# computing counter size
	movq	$0x01, %r9
	cmpq	$0xf00, %rdx
	jl	CTR_1_NO_PIPELINE
	movq	$0x02, %r9
	cmpq	$0xe0000, %rdx
	jl	CTR_2_NO_PIPELINE
	movq	$0x04, %r9
	movq	$0xc00000000, %r12
	cmpq	%r12, %rdx
	jl	CTR_4_NO_PIPELINE
	movq	$0x08, %r9			

# counter size in		%r9
# no. of simd blocks		%rax
# counter in			%r11

# computing number of pipelinable blocks
CTR_8_NO_PIPELINE:
	xorq	%r12, %r12
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	shrq	$0x3, %rax
	je	CTR_8_REMAINDER_8

CTR_8_LOOP_8:
	movdqu	(%rdi), %xmm1
	pinsrq	$0x1, %r11, %xmm1
	incq	%r11
	movdqu	8(%rdi), %xmm2
	pinsrq	$0x1, %r11, %xmm2
	incq	%r11
	movdqu	16(%rdi), %xmm3
	pinsrq	$0x1, %r11, %xmm3
	incq	%r11
	movdqu	24(%rdi), %xmm4
	pinsrq	$0x1, %r11, %xmm4
	incq	%r11
	movdqu	32(%rdi), %xmm5
	pinsrq	$0x1, %r11, %xmm5
	incq	%r11
	movdqu	40(%rdi), %xmm6
	pinsrq	$0x1, %r11, %xmm6
	incq	%r11
	movdqu	48(%rdi), %xmm7
	pinsrq	$0x1, %r11, %xmm7
	incq	%r11
	movdqu	56(%rdi), %xmm8
	pinsrq	$0x1, %r11, %xmm8
	incq	%r11

	addq	$8, %r12

	movdqa	(%rcx), %xmm9
	movdqa	16(%rcx), %xmm10
	movdqa	32(%rcx), %xmm11
	movdqa	48(%rcx), %xmm12

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

	movdqa	64(%rcx), %xmm9
	movdqa	80(%rcx), %xmm10
	movdqa	96(%rcx), %xmm11
	movdqa	112(%rcx), %xmm12

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

	movdqa	128(%rcx), %xmm9
	movdqa	144(%rcx), %xmm10
	movdqa	160(%rcx), %xmm11

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

CTR_8_LAST_8:
	addq		$64, %rdi

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

	decq		%rax
	jne		CTR_8_LOOP_8

CTR_8_REMAINDER_8:
	shlq	$61, %r10
	shrq	$61, %r10
	testq	%rdx, %rdx
	je	CTR_8_RESIDUALS
	incq	%r10
CTR_8_RESIDUALS:
	decq	%r10
	je	FINAL_ENC
	
CTR_8_LOOP_8_2:
	movdqu	(%rdi), %xmm1
	pinsrq	$0x1, %r11, %xmm1
	incq	%r11

	incq	%r12

	addq	$8, %rdi

	pxor	(%rcx), %xmm1

	movdqu	160(%rcx), %xmm2

	aesenc	16(%rcx), %xmm1
	aesenc	32(%rcx), %xmm1
	aesenc	48(%rcx), %xmm1
	aesenc	64(%rcx), %xmm1
	aesenc	80(%rcx), %xmm1
	aesenc	96(%rcx), %xmm1
	aesenc	112(%rcx), %xmm1
	aesenc	128(%rcx), %xmm1
	aesenc	144(%rcx), %xmm1
	
CTR_8_LAST_8_2:
	aesenclast	%xmm2, %xmm1

	pxor		%xmm1, %xmm0

	decq		%r10
	jne		CTR_8_LOOP_8_2
	jmp		FINAL_ENC

# computing number of pipelinable blocks
CTR_4_NO_PIPELINE:
	xorq	%r12, %r12
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	shrq	$0x3, %rax
	je	CTR_4_REMAINDER_8
	
CTR_4_LOOP_8:
	movdqu	(%rdi), %xmm1
	pinsrd	$0x3, %r11d, %xmm1
	incq	%r11
	movdqu	12(%rdi), %xmm2
	pinsrd	$0x3, %r11d, %xmm2
	incq	%r11
	movdqu	24(%rdi), %xmm3
	pinsrd	$0x3, %r11d, %xmm3
	incq	%r11
	movdqu	36(%rdi), %xmm4
	pinsrd	$0x3, %r11d, %xmm4
	incq	%r11
	movdqu	48(%rdi), %xmm5
	pinsrd	$0x3, %r11d, %xmm5
	incq	%r11
	movdqu	60(%rdi), %xmm6
	pinsrd	$0x3, %r11d, %xmm6
	incq	%r11
	movdqu	72(%rdi), %xmm7
	pinsrd	$0x3, %r11d, %xmm7
	incq	%r11
	movdqu	84(%rdi), %xmm8
	pinsrd	$0x3, %r11d, %xmm8
	incq	%r11

	addq	$8, %r12

	movdqa	(%rcx), %xmm9
	movdqa	16(%rcx), %xmm10
	movdqa	32(%rcx), %xmm11
	movdqa	48(%rcx), %xmm12

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

	movdqa	64(%rcx), %xmm9
	movdqa	80(%rcx), %xmm10
	movdqa	96(%rcx), %xmm11
	movdqa	112(%rcx), %xmm12

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

	movdqa	128(%rcx), %xmm9
	movdqa	144(%rcx), %xmm10
	movdqa	160(%rcx), %xmm11

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

CTR_4_LAST_8:
	addq		$96, %rdi

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

	decq		%rax
	jne		CTR_4_LOOP_8

CTR_4_REMAINDER_8:
	shlq	$61, %r10
	shrq	$61, %r10
	testq	%rdx, %rdx
	je	CTR_4_RESIDUALS
	incq	%r10
CTR_4_RESIDUALS:
	decq	%r10
	je	FINAL_ENC
	
CTR_4_LOOP_8_2:
	movdqu	(%rdi), %xmm1
	pinsrd	$0x3, %r11d, %xmm1
	incq	%r11

	incq	%r12

	addq	$12, %rdi

	pxor	(%rcx), %xmm1

	movdqu	160(%rcx), %xmm2

	aesenc	16(%rcx), %xmm1
	aesenc	32(%rcx), %xmm1
	aesenc	48(%rcx), %xmm1
	aesenc	64(%rcx), %xmm1
	aesenc	80(%rcx), %xmm1
	aesenc	96(%rcx), %xmm1
	aesenc	112(%rcx), %xmm1
	aesenc	128(%rcx), %xmm1
	aesenc	144(%rcx), %xmm1
	
CTR_4_LAST_8_2:
	aesenclast	%xmm2, %xmm1

	pxor		%xmm1, %xmm0

	decq		%r10
	jne		CTR_4_LOOP_8_2
	jmp		FINAL_ENC

# computing number of pipelinable blocks
CTR_2_NO_PIPELINE:
	xorq	%r12, %r12
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	shrq	$0x3, %rax
	je	CTR_2_REMAINDER_8

CTR_2_LOOP_8:
	movdqu	(%rdi), %xmm1
	pinsrw	$0x7, %r11d, %xmm1
	incq	%r11
	movdqu	14(%rdi), %xmm2
	pinsrw	$0x7, %r11d, %xmm2
	incq	%r11
	movdqu	28(%rdi), %xmm3
	pinsrw	$0x7, %r11d, %xmm3
	incq	%r11
	movdqu	42(%rdi), %xmm4
	pinsrw	$0x7, %r11d, %xmm4
	incq	%r11
	movdqu	56(%rdi), %xmm5
	pinsrw	$0x7, %r11d, %xmm5
	incq	%r11
	movdqu	70(%rdi), %xmm6
	pinsrw	$0x7, %r11d, %xmm6
	incq	%r11
	movdqu	84(%rdi), %xmm7
	pinsrw	$0x7, %r11d, %xmm7
	incq	%r11
	movdqu	98(%rdi), %xmm8
	pinsrw	$0x7, %r11d, %xmm8
	incq	%r11

	addq	$8, %r12

	movdqa	(%rcx), %xmm9
	movdqa	16(%rcx), %xmm10
	movdqa	32(%rcx), %xmm11
	movdqa	48(%rcx), %xmm12

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

	movdqa	64(%rcx), %xmm9
	movdqa	80(%rcx), %xmm10
	movdqa	96(%rcx), %xmm11
	movdqa	112(%rcx), %xmm12

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

	movdqa	128(%rcx), %xmm9
	movdqa	144(%rcx), %xmm10
	movdqa	160(%rcx), %xmm11

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

CTR_2_LAST_8:
	addq		$112, %rdi

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

	decq		%rax
	jne		CTR_2_LOOP_8

CTR_2_REMAINDER_8:
	shlq	$61, %r10
	shrq	$61, %r10
	testq	%rdx, %rdx
	je	CTR_2_RESIDUALS
	incq	%r10
CTR_2_RESIDUALS:
	decq	%r10
	je	FINAL_ENC
	
CTR_2_LOOP_8_2:
	movdqu	(%rdi), %xmm1
	pinsrw	$0x7, %r11d, %xmm1
	incq	%r11

	incq	%r12

	addq	$14, %rdi

	pxor	(%rcx), %xmm1

	movdqu	160(%rcx), %xmm2

	aesenc	16(%rcx), %xmm1
	aesenc	32(%rcx), %xmm1
	aesenc	48(%rcx), %xmm1
	aesenc	64(%rcx), %xmm1
	aesenc	80(%rcx), %xmm1
	aesenc	96(%rcx), %xmm1
	aesenc	112(%rcx), %xmm1
	aesenc	128(%rcx), %xmm1
	aesenc	144(%rcx), %xmm1
	
CTR_2_LAST_8_2:
	aesenclast	%xmm2, %xmm1

	pxor		%xmm1, %xmm0

	decq		%r10
	jne		CTR_2_LOOP_8_2
	jmp		FINAL_ENC

# computing number of pipelinable blocks
CTR_1_NO_PIPELINE:
	xorq	%r12, %r12
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	shrq	$0x3, %rax
	je	CTR_1_REMAINDER_8

CTR_1_LOOP_8:
	movdqu	(%rdi), %xmm1
	pinsrb	$0xf, %r11d, %xmm1
	incq	%r11
	movdqu	15(%rdi), %xmm2
	pinsrb	$0xf, %r11d, %xmm2
	incq	%r11
	movdqu	30(%rdi), %xmm3
	pinsrb	$0xf, %r11d, %xmm3
	incq	%r11
	movdqu	45(%rdi), %xmm4
	pinsrb	$0xf, %r11d, %xmm4
	incq	%r11
	movdqu	60(%rdi), %xmm5
	pinsrb	$0xf, %r11d, %xmm5
	incq	%r11
	movdqu	75(%rdi), %xmm6
	pinsrb	$0xf, %r11d, %xmm6
	incq	%r11
	movdqu	90(%rdi), %xmm7
	pinsrb	$0xf, %r11d, %xmm7
	incq	%r11
	movdqu	105(%rdi), %xmm8
	pinsrb	$0xf, %r11d, %xmm8
	incq	%r11

	addq	$8, %r12

	movdqa	(%rcx), %xmm9
	movdqa	16(%rcx), %xmm10
	movdqa	32(%rcx), %xmm11
	movdqa	48(%rcx), %xmm12

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

	movdqa	64(%rcx), %xmm9
	movdqa	80(%rcx), %xmm10
	movdqa	96(%rcx), %xmm11
	movdqa	112(%rcx), %xmm12

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

	movdqa	128(%rcx), %xmm9
	movdqa	144(%rcx), %xmm10
	movdqa	160(%rcx), %xmm11

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

CTR_1_LAST_8:
	addq		$120, %rdi

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

	decq		%rax
	jne		CTR_1_LOOP_8

CTR_1_REMAINDER_8:
	shlq	$61, %r10
	shrq	$61, %r10
	testq	%rdx, %rdx
	je	CTR_1_RESIDUALS
	incq	%r10
CTR_1_RESIDUALS:
	decq	%r10
	je	FINAL_ENC
	
CTR_1_LOOP_8_2:
	movdqu	(%rdi), %xmm1
	pinsrb	$0xf, %r11d, %xmm1
	incq	%r11

	incq	%r12

	addq	$15, %rdi

	pxor	(%rcx), %xmm1

	movdqu	160(%rcx), %xmm2

	aesenc	16(%rcx), %xmm1
	aesenc	32(%rcx), %xmm1
	aesenc	48(%rcx), %xmm1
	aesenc	64(%rcx), %xmm1
	aesenc	80(%rcx), %xmm1
	aesenc	96(%rcx), %xmm1
	aesenc	112(%rcx), %xmm1
	aesenc	128(%rcx), %xmm1
	aesenc	144(%rcx), %xmm1
	
CTR_1_LAST_8_2:
	aesenclast	%xmm2, %xmm1

	pxor		%xmm1, %xmm0

	decq		%r10
	jne		CTR_1_LOOP_8_2

FINAL_ENC:
	movdqu	(%rdi), %xmm1
	pxor	%xmm1, %xmm0

	pxor	(%r8), %xmm0

	movdqu	160(%r8), %xmm2

	aesenc		16(%r8), %xmm0
	aesenc		32(%r8), %xmm0
	aesenc		48(%r8), %xmm0
	aesenc		64(%r8), %xmm0
	aesenc		80(%r8), %xmm0
	aesenc		96(%r8), %xmm0
	aesenc		112(%r8), %xmm0
	aesenc		128(%r8), %xmm0
	aesenc		144(%r8), %xmm0
	aesenclast	%xmm2, %xmm0

	movdqu		%xmm0, (%rsi)
	movq		%r12, total_calls

	ret
