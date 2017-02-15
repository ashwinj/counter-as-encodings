//	void DHAIFA (const unsigned char *in,
//			      unsigned char *hash)

.extern total_calls

.globl DHAIFA
DHAIFA:
# parameter 1: %rdi
# parameter 2: %rsi

# setting up
	pxor	%xmm0, %xmm0
	pxor	%xmm13, %xmm13
	xorq	%r8, %r8
	xorq	%r11, %r11
	addq	$-15, %rdi
	movq	$1, %r9
	movq	$0x007f000000000000, %r10
	pinsrq	$0x1, %r10, %xmm13

CREATE_INPUT_BLOCK:
	cmpq	$1, %r9
	je	CTR_1_INPUT_BLOCK
	cmpq	$2, %r9
	je	CTR_2_INPUT_BLOCK	
	cmpq	$4, %r9
	je	CTR_4_INPUT_BLOCK

CTR_8_INPUT_BLOCK:
	addq	$8, %rdi
	# add some check for max message length

CTR_8_VALID:
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL
	pinsrq	$0x1, %r8, %xmm1
	incq	%r8
	jmp	PROCESS_BLOCK

CTR_4_INPUT_BLOCK:
	addq	$12, %rdi
	cmpq	$0x30000000, %r8
	jne	CTR_4_VALID	
	shlq	$32, %r8
	shlq	$1, %r9
	pxor	%xmm13, %xmm13
	movq	$0x7f00000000000000, %r10
	pinsrq	$0x0, %r10, %xmm13
	jmp	CTR_8_VALID

CTR_4_VALID:
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL
	pinsrd	$0x3, %r8d, %xmm1
	incq	%r8
	jmp	PROCESS_BLOCK

CTR_2_INPUT_BLOCK:
	addq	$14, %rdi
	cmpq	$0x2000, %r8
	jne	CTR_2_VALID	
	shlq	$16, %r8
	shlq	$1, %r9
	movq	$0x000000007f000000, %r10
	pinsrq	$0x1, %r10, %xmm13
	jmp	CTR_4_VALID

CTR_2_VALID:
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL
	pinsrw	$0x7, %r8d, %xmm1
	incq	%r8
	jmp	PROCESS_BLOCK

CTR_1_INPUT_BLOCK:
	addq	$15, %rdi
	cmpq	$0x10, %r8
	jne	CTR_1_VALID	
	shlq	$8, %r8
	shlq	$1, %r9
	movq	$0x00007f0000000000, %r10
	pinsrq	$0x1, %r10, %xmm13
	jmp	CTR_2_VALID

CTR_1_VALID:
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL
	pinsrb	$0xf, %r8d, %xmm1
	incq	%r8
	jmp	PROCESS_BLOCK

PROCESS_BLOCK:
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

	incq			%r11

	jmp			CREATE_INPUT_BLOCK

RESIDUAL:
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

	incq			%r11

	movdqu			%xmm0, (%rsi)

	movq			%r11, total_calls

	ret
