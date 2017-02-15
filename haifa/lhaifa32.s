//	void LHAIFA (const unsigned char *in,
//			      unsigned char *hash)

.extern total_calls

.globl LHAIFA
LHAIFA:
# parameter 1: %rdi
# parameter 2: %rsi

# setting up
	pxor	%xmm0, %xmm0
	pxor	%xmm13, %xmm13
	xorq	%r8, %r8
	xorq	%r9, %r9
	movq	$0x000000007f000000, %r10
	pinsrq	$0x1, %r10, %xmm13
	addq	$-12, %rdi

# add some check for maximum message length

CREATE_INPUT_BLOCK:
	addq	$12, %rdi
	movdqu	(%rdi), %xmm1
	ptest	%xmm1, %xmm13
	je	RESIDUAL
	pinsrd	$0x3, %r8d, %xmm1
	incq	%r8

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
	incq			%r9

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
	incq			%r9

	movdqu			%xmm0, (%rsi)
	movq			%r9, total_calls

	ret
