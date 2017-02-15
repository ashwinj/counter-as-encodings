//	void KHAIFA (const unsigned char *in,
//			      unsigned char *hash,
//			      unsigned long length)

.extern total_calls

.globl KHAIFA
KHAIFA:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx

# setting up
	pxor	%xmm0, %xmm0
	xorq	%r11, %r11
	xorq	%r8, %r8

# computing counter size
	movq	$0x01, %r9
	cmpq	$0xf00, %rdx
	jl	CTR_1_NO_BLOCKS
	movq	$0x02, %r9
	cmpq	$0xe0000, %rdx
	jl	CTR_2_NO_BLOCKS
	movq	$0x04, %r9
	movq	$0xc00000000, %r12
	cmpq	%r12, %rdx
	jl	CTR_4_NO_BLOCKS
	movq	$0x08, %r9			

# counter size in		%r9
# no. of blocks in		%r10
# counter in			%r11

# computing number of blocks
CTR_8_NO_BLOCKS:
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	testq	%rdx, %rdx
	je	CTR_8_CREATE_BLOCK
	incq	%r10

CTR_8_CREATE_BLOCK:
	movdqu	(%rdi), %xmm1
	decq	%r10
	je	CTR_8_RESIDUAL
	pinsrq	$0x1, %r11, %xmm1
	incq	%r11
	jmp	CTR_8_PROCESS_BLOCK


CTR_8_PROCESS_BLOCK:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0

	addq			$8, %rdi

	incq			%r8

	jmp			CTR_8_CREATE_BLOCK

CTR_8_RESIDUAL:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0

	incq			%r8

	movdqu			%xmm0, (%rsi)
	movq			%r8, total_calls

	ret

# computing number of blocks
CTR_4_NO_BLOCKS:
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	testq	%rdx, %rdx
	je	CTR_4_CREATE_BLOCK
	incq	%r10

CTR_4_CREATE_BLOCK:
	movdqu	(%rdi), %xmm1
	decq	%r10
	je	CTR_4_RESIDUAL
	pinsrd	$0x3, %r11d, %xmm1
	incq	%r11
	jmp	CTR_4_PROCESS_BLOCK

CTR_4_PROCESS_BLOCK:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0

	addq			$12, %rdi
	incq			%r8

	jmp			CTR_4_CREATE_BLOCK

CTR_4_RESIDUAL:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0
	incq			%r8

	movdqu			%xmm0, (%rsi)
	movq			%r8, total_calls

	ret

# computing number of blocks
CTR_2_NO_BLOCKS:
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	testq	%rdx, %rdx
	je	CTR_2_CREATE_BLOCK
	incq	%r10

CTR_2_CREATE_BLOCK:
	movdqu	(%rdi), %xmm1
	decq	%r10
	je	CTR_2_RESIDUAL
	pinsrw	$0x7, %r11d, %xmm1
	incq	%r11
	jmp	CTR_2_PROCESS_BLOCK

CTR_2_PROCESS_BLOCK:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0

	addq			$14, %rdi
	incq			%r8

	jmp			CTR_2_CREATE_BLOCK

CTR_2_RESIDUAL:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0
	incq			%r8

	movdqu			%xmm0, (%rsi)
	movq			%r8, total_calls

	ret

# computing number of blocks
CTR_1_NO_BLOCKS:
	movq	$0x10, %r10
	subq	%r9, %r10
	movq	%rdx, %rax
	xorq	%rdx, %rdx
	divq	%r10
	movq	%rax, %r10
	testq	%rdx, %rdx
	je	CTR_1_CREATE_BLOCK
	incq	%r10

CTR_1_CREATE_BLOCK:
	movdqu	(%rdi), %xmm1
	decq	%r10
	je	CTR_1_RESIDUAL
	pinsrb	$0xf, %r11d, %xmm1
	incq	%r11
	jmp	CTR_1_PROCESS_BLOCK


CTR_1_PROCESS_BLOCK:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0

	addq			$15, %rdi
	incq			%r8

	jmp			CTR_1_CREATE_BLOCK

CTR_1_RESIDUAL:
	movdqa			%xmm0, %xmm4
	pxor			%xmm1, %xmm0
	
	aeskeygenassist 	$1, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0

	aeskeygenassist 	$2, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$4, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$8, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$16, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$32, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$64, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x80, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x1b, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenc			%xmm1, %xmm0
	
	aeskeygenassist 	$0x36, %xmm1, %xmm2
	pshufd 			$255, %xmm2, %xmm2
	movdqa 			%xmm1, %xmm3
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pslldq 			$4, %xmm3
	pxor 			%xmm3, %xmm1
	pxor 			%xmm2, %xmm1
	aesenclast		%xmm1, %xmm0
	
	pxor			%xmm4, %xmm0
	incq			%r8

	movdqu			%xmm0, (%rsi)
	movq			%r8, total_calls

	ret
