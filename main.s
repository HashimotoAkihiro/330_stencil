	.file	1 "main.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 3
	.text
	.align	2
	.set	nomips16
	.ent	output_buffer_put
	.type	output_buffer_put, @function
output_buffer_put:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,%gp_rel(output_buffer_size)($28)
	lui	$7,%hi(output_buffer)
	addiu	$7,$7,%lo(output_buffer)
	addiu	$3,$2,1
	slt	$5,$3,1024
	addu	$2,$2,$7
	sw	$3,%gp_rel(output_buffer_size)($28)
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L4
	sb	$4,0($2)
	.set	macro
	.set	reorder

 #APP
 # 42 "././lib.c" 1
	li	$4,1
	move	$5,$7
	move	$6,$3
	li	$2,4004
	syscall
	move	$3,$2
	
 # 0 "" 2
 #NO_APP
	sw	$0,%gp_rel(output_buffer_size)($28)
$L4:
	j	$31
	.end	output_buffer_put
	.size	output_buffer_put, .-output_buffer_put
	.align	2
	.globl	mylib_wait
	.set	nomips16
	.ent	mylib_wait
	.type	mylib_wait, @function
mylib_wait:
	.frame	$sp,8,$31		# vars= 8, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addiu	$sp,$sp,-8
	move	$2,$0
	sw	$0,0($sp)
	li	$4,40			# 0x28
$L7:
	lw	$3,0($sp)
	#nop
	addu	$3,$3,$2
	addiu	$2,$2,1
	sw	$3,0($sp)
	bne	$2,$4,$L7
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,8
	.set	macro
	.set	reorder

	.end	mylib_wait
	.size	mylib_wait, .-mylib_wait
	.align	2
	.globl	mylib_display_dec
	.set	nomips16
	.ent	mylib_display_dec
	.type	mylib_display_dec, @function
mylib_display_dec:
	.frame	$sp,1056,$31		# vars= 1024, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-1056
	sw	$31,1052($sp)
	sw	$18,1048($sp)
	sw	$17,1044($sp)
	.set	noreorder
	.set	nomacro
	bltz	$4,$L34
	sw	$16,1040($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L35
	li	$2,48			# 0x30
	.set	macro
	.set	reorder

	sw	$2,16($sp)
	li	$4,48			# 0x30
	move	$16,$0
	addiu	$9,$sp,16
	addiu	$16,$16,-1
$L37:
	sll	$17,$16,2
	addu	$17,$9,$17
	.set	noreorder
	.set	nomacro
	j	$L14
	li	$18,-1			# 0xffffffffffffffff
	.set	macro
	.set	reorder

$L18:
	lw	$4,0($17)
	addiu	$17,$17,-4
$L14:
	jal	output_buffer_put
	.set	noreorder
	.set	nomacro
	bne	$16,$18,$L18
	addiu	$16,$16,-1
	.set	macro
	.set	reorder

	lw	$31,1052($sp)
	lw	$18,1048($sp)
	lw	$17,1044($sp)
	lw	$16,1040($sp)
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,1056
	.set	macro
	.set	reorder

$L34:
	subu	$4,$0,$4
	li	$11,1			# 0x1
$L11:
	li	$6,1717960704			# 0x66660000
	addiu	$6,$6,26215
	mult	$4,$6
	sra	$5,$4,31
	addiu	$9,$sp,16
	move	$3,$9
	move	$8,$0
	li	$10,1			# 0x1
	li	$12,2			# 0x2
	li	$13,3			# 0x3
	li	$14,4			# 0x4
	li	$15,5			# 0x5
	li	$17,6			# 0x6
	mfhi	$2
	sra	$2,$2,2
	subu	$2,$2,$5
	sll	$7,$2,1
	sll	$2,$2,3
	addu	$2,$7,$2
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L20
	li	$18,7			# 0x7
	.set	macro
	.set	reorder

$L36:
	beq	$2,$10,$L21
	beq	$2,$12,$L22
	beq	$2,$13,$L23
	beq	$2,$14,$L24
	beq	$2,$15,$L25
	beq	$2,$17,$L26
	beq	$2,$18,$L27
	xori	$2,$2,0x8
	sltu	$2,$0,$2
	addiu	$2,$2,56
$L15:
	mult	$4,$6
	sw	$2,0($3)
	addiu	$16,$8,1
	mfhi	$4
	sra	$4,$4,2
	subu	$4,$4,$5
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L16
	addiu	$3,$3,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$11,$0,$L17
	sll	$2,$16,2
	.set	macro
	.set	reorder

	addu	$2,$9,$2
	li	$3,45			# 0x2d
	sw	$3,0($2)
	addiu	$16,$8,2
$L17:
	addiu	$16,$16,-1
	sll	$2,$16,2
	addu	$2,$9,$2
	lw	$4,0($2)
	.set	noreorder
	.set	nomacro
	j	$L37
	addiu	$16,$16,-1
	.set	macro
	.set	reorder

$L16:
	mult	$4,$6
	sra	$5,$4,31
	mfhi	$2
	sra	$2,$2,2
	subu	$2,$2,$5
	sll	$7,$2,1
	sll	$2,$2,3
	addu	$2,$7,$2
	subu	$2,$4,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L36
	move	$8,$16
	.set	macro
	.set	reorder

$L20:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,48			# 0x30
	.set	macro
	.set	reorder

$L21:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,49			# 0x31
	.set	macro
	.set	reorder

$L22:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,50			# 0x32
	.set	macro
	.set	reorder

$L23:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,51			# 0x33
	.set	macro
	.set	reorder

$L24:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,52			# 0x34
	.set	macro
	.set	reorder

$L35:
	.set	noreorder
	.set	nomacro
	j	$L11
	move	$11,$0
	.set	macro
	.set	reorder

$L25:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,53			# 0x35
	.set	macro
	.set	reorder

$L26:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,54			# 0x36
	.set	macro
	.set	reorder

$L27:
	.set	noreorder
	.set	nomacro
	j	$L15
	li	$2,55			# 0x37
	.set	macro
	.set	reorder

	.end	mylib_display_dec
	.size	mylib_display_dec, .-mylib_display_dec
	.align	2
	.globl	mylib_display_hex
	.set	nomips16
	.ent	mylib_display_hex
	.type	mylib_display_hex, @function
mylib_display_hex:
	.frame	$sp,64,$31		# vars= 32, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-64
	addiu	$2,$sp,16
	sw	$17,56($sp)
	sw	$16,52($sp)
	sw	$31,60($sp)
	move	$17,$2
	addiu	$5,$sp,48
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	li	$8,3			# 0x3
	li	$9,4			# 0x4
	li	$10,5			# 0x5
	li	$11,6			# 0x6
	li	$12,7			# 0x7
	li	$13,8			# 0x8
	li	$14,9			# 0x9
	li	$15,10			# 0xa
	li	$16,11			# 0xb
	li	$24,12			# 0xc
	li	$25,13			# 0xd
$L41:
	andi	$3,$4,0xf
	beq	$3,$0,$L44
	beq	$3,$6,$L45
	beq	$3,$7,$L46
	beq	$3,$8,$L47
	beq	$3,$9,$L48
	beq	$3,$10,$L49
	beq	$3,$11,$L50
	beq	$3,$12,$L51
	beq	$3,$13,$L52
	beq	$3,$14,$L53
	beq	$3,$15,$L54
	beq	$3,$16,$L55
	beq	$3,$24,$L56
	beq	$3,$25,$L57
	xori	$3,$3,0xe
	sltu	$3,$0,$3
	.set	noreorder
	.set	nomacro
	j	$L39
	addiu	$3,$3,101
	.set	macro
	.set	reorder

$L44:
	li	$3,48			# 0x30
$L39:
	sw	$3,0($2)
	addiu	$2,$2,4
	.set	noreorder
	.set	nomacro
	bne	$2,$5,$L41
	sra	$4,$4,4
	.set	macro
	.set	reorder

	addiu	$16,$sp,44
	addiu	$17,$17,-4
$L43:
	lw	$4,0($16)
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	addiu	$16,$16,-4
	.set	macro
	.set	reorder

	bne	$16,$17,$L43
	lw	$31,60($sp)
	lw	$17,56($sp)
	lw	$16,52($sp)
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,64
	.set	macro
	.set	reorder

$L45:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,49			# 0x31
	.set	macro
	.set	reorder

$L46:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,50			# 0x32
	.set	macro
	.set	reorder

$L47:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,51			# 0x33
	.set	macro
	.set	reorder

$L48:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,52			# 0x34
	.set	macro
	.set	reorder

$L49:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,53			# 0x35
	.set	macro
	.set	reorder

$L50:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,54			# 0x36
	.set	macro
	.set	reorder

$L51:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,55			# 0x37
	.set	macro
	.set	reorder

$L54:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,97			# 0x61
	.set	macro
	.set	reorder

$L52:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,56			# 0x38
	.set	macro
	.set	reorder

$L53:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,57			# 0x39
	.set	macro
	.set	reorder

$L55:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,98			# 0x62
	.set	macro
	.set	reorder

$L56:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,99			# 0x63
	.set	macro
	.set	reorder

$L57:
	.set	noreorder
	.set	nomacro
	j	$L39
	li	$3,100			# 0x64
	.set	macro
	.set	reorder

	.end	mylib_display_hex
	.size	mylib_display_hex, .-mylib_display_hex
	.align	2
	.globl	mylib_display_char
	.set	nomips16
	.ent	mylib_display_char
	.type	mylib_display_char, @function
mylib_display_char:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	j	output_buffer_put
	.end	mylib_display_char
	.size	mylib_display_char, .-mylib_display_char
	.align	2
	.globl	mylib_display_newline
	.set	nomips16
	.ent	mylib_display_newline
	.type	mylib_display_newline, @function
mylib_display_newline:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	lw	$31,20($sp)
	li	$4,13			# 0xd
	.set	noreorder
	.set	nomacro
	j	output_buffer_put
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	mylib_display_newline
	.size	mylib_display_newline, .-mylib_display_newline
	.align	2
	.globl	mylib_flush
	.set	nomips16
	.ent	mylib_flush
	.type	mylib_flush, @function
mylib_flush:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$3,%hi(output_buffer)
	lw	$7,%gp_rel(output_buffer_size)($28)
	addiu	$3,$3,%lo(output_buffer)
 #APP
 # 42 "././lib.c" 1
	li	$4,1
	move	$5,$3
	move	$6,$7
	li	$2,4004
	syscall
	move	$3,$2
	
 # 0 "" 2
 #NO_APP
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$0,%gp_rel(output_buffer_size)($28)
	.set	macro
	.set	reorder

	.end	mylib_flush
	.size	mylib_flush, .-mylib_flush
	.align	2
	.globl	mylib_finalize
	.set	nomips16
	.ent	mylib_finalize
	.type	mylib_finalize, @function
mylib_finalize:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,69			# 0x45
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,78			# 0x4e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,68			# 0x44
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	lui	$3,%hi(output_buffer)
	lw	$7,%gp_rel(output_buffer_size)($28)
	addiu	$3,$3,%lo(output_buffer)
 #APP
 # 42 "././lib.c" 1
	li	$4,1
	move	$5,$3
	move	$6,$7
	li	$2,4004
	syscall
	move	$3,$2
	
 # 0 "" 2
 #NO_APP
	sw	$0,%gp_rel(output_buffer_size)($28)
 #APP
 # 200 "././lib.c" 1
	li	$4,0
	li	$2,4001
	syscall
	
 # 0 "" 2
 #NO_APP
	lw	$31,20($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	mylib_finalize
	.size	mylib_finalize, .-mylib_finalize
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.set	nomips16
	.ent	main
	.type	main, @function
main:
	.frame	$sp,96,$31		# vars= 40, regs= 10/0, args= 16, gp= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	lui	$3,%hi(_binary_330stencil_dat_start)
	addiu	$3,$3,%lo(_binary_330stencil_dat_start)
	li	$2,262144			# 0x40000
	addu	$2,$2,$3
	sw	$3,%gp_rel(init_data)($28)
	lui	$3,%hi(_binary_330stencil_dat_start+262136)
	addiu	$3,$3,%lo(_binary_330stencil_dat_start+262136)
	sw	$3,%gp_rel(init_n)($28)
	lui	$3,%hi(_binary_330stencil_dat_start+262140)
	addiu	$sp,$sp,-96
	addiu	$3,$3,%lo(_binary_330stencil_dat_start+262140)
	li	$4,115			# 0x73
	sw	$31,92($sp)
	sw	$3,%gp_rel(init_iter)($28)
	sw	$18,64($sp)
	sw	$17,60($sp)
	lw	$18,-4($2)
	lw	$17,-8($2)
	sw	$fp,88($sp)
	sw	$23,84($sp)
	sw	$22,80($sp)
	sw	$21,76($sp)
	sw	$20,72($sp)
	sw	$19,68($sp)
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	sw	$16,56($sp)
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,116			# 0x74
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,101			# 0x65
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,110			# 0x6e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,99			# 0x63
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,105			# 0x69
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,108			# 0x6c
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,110			# 0x6e
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,61			# 0x3d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_dec
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,105			# 0x69
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,61			# 0x3d
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_dec
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

 #APP
 # 263 "./main.c" 1
	.set   noat
	pinsw  $0,$0,$0,0
	nop
	nop
	pinsw  $0,$0,$0,1
	nop
	nop
	pinsw  $0,$0,$0,2
	nop
	nop
	pinsw  $0,$0,$0,3
	.set   at
 # 0 "" 2
 #NO_APP
	mult	$17,$17
	mflo	$7
	.set	noreorder
	.set	nomacro
	blez	$7,$L100
	lui	$16,%hi(buf)
	.set	macro
	.set	reorder

	lw	$8,%gp_rel(init_data)($28)
	addiu	$16,$16,%lo(buf)
	move	$2,$16
	move	$5,$0
	move	$3,$0
$L68:
	sll	$4,$5,2
	addu	$4,$8,$4
 #APP
 # 288 "./main.c" 1
	.set    noat
	lq      $1,($4)
	lq      $2,16($4)
	.set    at
	
 # 0 "" 2
 # 295 "./main.c" 1
	.set   noat
	cache  0x0d,($2)
	cache  0x0d,16($2)
	.set   at
	
 # 0 "" 2
 # 301 "./main.c" 1
	.set   noat
	sq      $1,($2)
	sq      $2,16($2)
	.set    at

 # 0 "" 2
 #NO_APP
	addiu	$3,$3,8
	addiu	$5,$5,8
	slt	$4,$3,$7
	andi	$5,$5,0xffff
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L68
	addiu	$2,$2,32
	.set	macro
	.set	reorder

$L67:
	srl	$2,$18,31
	addu	$18,$2,$18
	sra	$18,$18,1
	.set	noreorder
	.set	nomacro
	blez	$18,$L69
	sw	$18,36($sp)
	.set	macro
	.set	reorder

	addiu	$2,$17,1
	sll	$2,$2,2
	sw	$2,52($sp)
	addu	$2,$16,$2
	sw	$2,40($sp)
	sll	$2,$17,1
	lw	$4,52($sp)
	sw	$2,20($sp)
	addiu	$2,$17,-1
	sw	$2,16($sp)
	lw	$2,52($sp)
	addiu	$20,$17,-9
	lui	$14,%hi(dummy_mem)
	addiu	$14,$14,%lo(dummy_mem)
	srl	$20,$20,2
	addiu	$7,$17,-4
	addiu	$25,$4,-4
	slt	$4,$17,3
	addiu	$20,$20,2
	sw	$4,44($sp)
	li	$6,954400768			# 0x38e30000
	slt	$4,$7,5
	addu	$2,$14,$2
	sll	$23,$17,3
	sll	$20,$20,2
	sw	$0,28($sp)
	sw	$4,24($sp)
	ori	$6,$6,0x8e39
	move	$3,$14
	sw	$2,48($sp)
$L70:
	lw	$4,44($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L80
	move	$24,$16
	.set	macro
	.set	reorder

	move	$21,$17
	move	$18,$25
	li	$19,4			# 0x4
	li	$22,1			# 0x1
$L81:
 #APP
 # 1182 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1198 "./main.c" 1
	lq      $2,16($24)
	lq      $1,($24)
	nop
	pextw   $1,$2,0
	psllww  $3,$1,$0
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 #NO_APP
	addu	$2,$16,$18
 #APP
 # 1212 "./main.c" 1
	lq      $6,16($2)
	lq      $5,($2)
	nop
	pextw   $1,$6,0
	psllww  $7,$5,$0
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 #NO_APP
	addiu	$22,$22,1
	addu	$24,$24,$23
 #APP
 # 1226 "./main.c" 1
	lq      $10,16($24)
	lq      $9,($24)
	nop
	pextw   $1,$10,0
	psllww  $11,$9,$0
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1240 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addu	$2,$14,$18
	lw	$4,0($2)
	#nop
 #APP
 # 1254 "./main.c" 1
	nop
	nop
	pinsw   $16,$16,$4,0
	
 # 0 "" 2
 # 1261 "./main.c" 1
	.set   noat
	cache  0x0d,($2)
	.set   at
	
 # 0 "" 2
 # 1265 "./main.c" 1
	nop
	nop
	sq      $16,($2)
	
 # 0 "" 2
 # 1270 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	lw	$4,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L101
	li	$11,4			# 0x4
	.set	macro
	.set	reorder

	lw	$4,20($sp)
	subu	$15,$0,$17
	sll	$15,$15,2
	addu	$31,$4,$19
	addu	$fp,$21,$17
	sll	$13,$17,2
	addiu	$2,$18,32
	li	$4,4			# 0x4
$L73:
 #APP
 # 1274 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1279 "./main.c" 1
	pextw   $9,$1,3
	pextw   $8,$5,3
	pextw   $5,$9,3
	
 # 0 "" 2
 #NO_APP
	addu	$10,$2,$15
	addu	$12,$2,$13
	addu	$10,$16,$10
	addu	$11,$16,$2
	addu	$12,$16,$12
 #APP
 # 1314 "./main.c" 1
	paddw   $1,$2,$0
	lq      $2,($10)
	paddw   $5,$6,$0
	lq      $6,($11)
	paddw   $9,$10,$0
	lq      $10,($12)
	
 # 0 "" 2
 # 1327 "./main.c" 1
	pextw   $1,$2,0
	psllww  $3,$1,$9
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 # 1338 "./main.c" 1
	pextw   $1,$6,0
	psllww  $7,$5,$8
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 # 1349 "./main.c" 1
	pextw   $1,$10,0
	psllww  $11,$9,$5
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1360 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addiu	$5,$2,-16
	addu	$5,$14,$5
 #APP
 # 1374 "./main.c" 1
	cache 0x0d,($5)
	nop
	nop
	sq      $16,($5)
	
 # 0 "" 2
 # 1380 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	addiu	$4,$4,4
	slt	$5,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L73
	addiu	$2,$2,16
	.set	macro
	.set	reorder

	move	$2,$20
	move	$11,$20
$L72:
 #APP
 # 1383 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1386 "./main.c" 1
	pextw   $9,$1,3
	pextw   $8,$5,3
	pextw   $5,$9,3
	
 # 0 "" 2
 #NO_APP
	addu	$4,$21,$2
	addu	$10,$19,$2
	addiu	$4,$4,4
	addu	$2,$2,$31
	sll	$4,$4,2
	sll	$10,$10,2
	sll	$2,$2,2
	addu	$10,$16,$10
	addu	$12,$16,$4
	addu	$2,$16,$2
 #APP
 # 1408 "./main.c" 1
	paddw   $1,$2,$0
	lq      $2,($10)
	paddw   $5,$6,$0
	lq      $6,($12)
	paddw   $9,$10,$0
	lq      $10,($2)
	
 # 0 "" 2
 # 1421 "./main.c" 1
	pextw   $1,$2,0
	psllww  $3,$1,$9
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 # 1432 "./main.c" 1
	pextw   $1,$6,0
	psllww  $7,$5,$8
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 # 1443 "./main.c" 1
	pextw   $1,$10,0
	psllww  $11,$9,$5
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1454 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addu	$21,$21,$11
	addiu	$21,$21,3
	sll	$21,$21,2
	addu	$14,$14,$21
	lw	$2,0($14)
	#nop
 #APP
 # 1468 "./main.c" 1
	nop
	nop
	pinsw   $16,$16,$2,3
	
 # 0 "" 2
 #NO_APP
	addiu	$2,$4,-16
	lui	$4,%hi(dummy_mem)
	addiu	$4,$4,%lo(dummy_mem)
	move	$14,$3
	addu	$2,$4,$2
 #APP
 # 1474 "./main.c" 1
	.set   noat
	cache  0x0d,($2)
	.set   at
	
 # 0 "" 2
 # 1479 "./main.c" 1
	nop
	nop
	sq      $16,($2)
	
 # 0 "" 2
 # 1484 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	lw	$2,16($sp)
	subu	$24,$24,$25
	addu	$18,$18,$25
	addu	$19,$19,$17
	.set	noreorder
	.set	nomacro
	bne	$22,$2,$L81
	move	$21,$fp
	.set	macro
	.set	reorder

	lw	$4,48($sp)
	li	$2,161021952			# 0x9990000
	lw	$31,24($sp)
	ori	$2,$2,0x9999
	sw	$2,0($4)
	move	$21,$17
	move	$18,$25
	li	$19,4			# 0x4
	li	$22,1			# 0x1
	move	$15,$3
	sw	$3,32($sp)
$L88:
 #APP
 # 1517 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1520 "./main.c" 1
	lq      $2,16($15)
	lq      $1,($15)
	nop
	pextw   $1,$2,0
	psllww  $3,$1,$0
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 #NO_APP
	addu	$2,$3,$18
 #APP
 # 1534 "./main.c" 1
	lq      $6,16($2)
	lq      $5,($2)
	nop
	pextw   $1,$6,0
	psllww  $7,$5,$0
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 #NO_APP
	addiu	$22,$22,1
	addu	$15,$15,$23
 #APP
 # 1548 "./main.c" 1
	lq      $10,16($15)
	lq      $9,($15)
	nop
	pextw   $1,$10,0
	psllww  $11,$9,$0
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1562 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addu	$2,$16,$18
	lw	$4,0($2)
	#nop
 #APP
 # 1576 "./main.c" 1
	nop
	nop
	pinsw   $16,$16,$4,0
	
 # 0 "" 2
 # 1588 "./main.c" 1
	cache   0x0d,($2)
	nop
	nop
	sq      $16,($2)
	
 # 0 "" 2
 # 1594 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	.set	noreorder
	.set	nomacro
	bne	$31,$0,$L102
	li	$4,4			# 0x4
	.set	macro
	.set	reorder

	lw	$2,20($sp)
	subu	$14,$0,$17
	sll	$14,$14,2
	addu	$24,$2,$19
	addu	$fp,$21,$17
	sll	$13,$17,2
	addiu	$2,$18,32
$L78:
 #APP
 # 1598 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1601 "./main.c" 1
	pextw   $9,$1,3
	pextw   $8,$5,3
	pextw   $5,$9,3
	
 # 0 "" 2
 #NO_APP
	addu	$10,$2,$14
	addu	$12,$2,$13
	addu	$10,$3,$10
	addu	$11,$3,$2
	addu	$12,$3,$12
 #APP
 # 1639 "./main.c" 1
	paddw   $1,$2,$0
	lq      $2,($10)
	paddw   $5,$6,$0
	lq      $6,($11)
	paddw   $9,$10,$0
	lq      $10,($12)
	
 # 0 "" 2
 # 1652 "./main.c" 1
	pextw   $1,$2,0
	psllww  $3,$1,$9
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 # 1663 "./main.c" 1
	pextw   $1,$6,0
	psllww  $7,$5,$8
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 # 1674 "./main.c" 1
	pextw   $1,$10,0
	psllww  $11,$9,$5
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1685 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addiu	$5,$2,-16
	addu	$5,$16,$5
 #APP
 # 1698 "./main.c" 1
	cache  0x0d,($5)
	nop
	nop
	sq      $16,($5)
	
 # 0 "" 2
 # 1704 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	addiu	$4,$4,4
	slt	$5,$4,$7
	.set	noreorder
	.set	nomacro
	bne	$5,$0,$L78
	addiu	$2,$2,16
	.set	macro
	.set	reorder

	move	$2,$20
	move	$11,$20
$L77:
 #APP
 # 1707 "./main.c" 1
	.set    noat
	
 # 0 "" 2
 # 1710 "./main.c" 1
	pextw   $9,$1,3
	pextw   $8,$5,3
	pextw   $5,$9,3
	
 # 0 "" 2
 #NO_APP
	addu	$4,$21,$2
	addu	$10,$19,$2
	addiu	$4,$4,4
	addu	$2,$2,$24
	sll	$4,$4,2
	sll	$10,$10,2
	sll	$2,$2,2
	addu	$10,$3,$10
	addu	$12,$3,$4
	addu	$2,$3,$2
 #APP
 # 1733 "./main.c" 1
	paddw   $1,$2,$0
	lq      $2,($10)
	paddw   $5,$6,$0
	lq      $6,($12)
	paddw   $9,$10,$0
	lq      $10,($2)
	
 # 0 "" 2
 # 1746 "./main.c" 1
	pextw   $1,$2,0
	psllww  $3,$1,$9
	nop
	psrlww  $4,$1,$1
	paddw   $13,$1,$3
	nop
	nop
	paddw   $13,$13,$4
	
 # 0 "" 2
 # 1757 "./main.c" 1
	pextw   $1,$6,0
	psllww  $7,$5,$8
	nop
	psrlww  $8,$5,$1
	paddw   $14,$5,$7
	nop
	nop
	paddw   $14,$14,$8
	
 # 0 "" 2
 # 1768 "./main.c" 1
	pextw   $1,$10,0
	psllww  $11,$9,$5
	nop
	psrlww  $12,$9,$1
	paddw   $15,$9,$11
	nop
	nop
	paddw   $15,$15,$12
	
 # 0 "" 2
 # 1779 "./main.c" 1
	paddw   $16,$13,$14
	move    $1,$6
	nop
	paddw   $16,$16,$15
	nop
	nop
	pmultsw $16,$1
	pmfhi   $16
	nop
	nop
	psraw   $16,$16,1
	
 # 0 "" 2
 #NO_APP
	addu	$21,$21,$11
	addiu	$21,$21,3
	sll	$21,$21,2
	addu	$16,$16,$21
	lw	$2,0($16)
	#nop
 #APP
 # 1793 "./main.c" 1
	nop
	nop
	pinsw   $16,$16,$2,3
	
 # 0 "" 2
 #NO_APP
	lui	$16,%hi(buf)
	addiu	$16,$16,%lo(buf)
	addiu	$4,$4,-16
	addu	$4,$16,$4
 #APP
 # 1798 "./main.c" 1
	nop
	nop
	sq      $16,($4)
	
 # 0 "" 2
 # 1803 "./main.c" 1
	.set    at
	
 # 0 "" 2
 #NO_APP
	lw	$4,16($sp)
	subu	$15,$15,$25
	addu	$18,$18,$25
	addu	$19,$19,$17
	.set	noreorder
	.set	nomacro
	bne	$22,$4,$L88
	move	$21,$fp
	.set	macro
	.set	reorder

	lw	$14,32($sp)
$L89:
	lw	$2,28($sp)
	lw	$4,40($sp)
	addiu	$2,$2,1
	sw	$2,28($sp)
	li	$2,161021952			# 0x9990000
	ori	$2,$2,0x9999
	sw	$2,0($4)
	lw	$4,28($sp)
	lw	$2,36($sp)
	#nop
	bne	$4,$2,$L70
$L69:
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	sll	$2,$17,2
	sw	$2,16($sp)
	move	$20,$16
	li	$18,16			# 0x10
	sw	$17,20($sp)
	sw	$16,24($sp)
$L83:
 #APP
 # 1883 "./main.c" 1
	.set    noat
	lq      $1,($20)
	lq      $2,16($20)
	.set    at

 # 0 "" 2
 # 1889 "./main.c" 1
	.set    noat
	nop
	pextw   $4,$1,0
	pextw   $fp,$1,1
	pextw   $17,$1,2
	pextw   $16,$1,3
	pextw   $23,$2,0
	pextw   $22,$2,1
	pextw   $21,$2,2
	pextw   $19,$2,3
	.set    at
	
 # 0 "" 2
 #NO_APP
	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	addiu	$18,$18,-1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$fp
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$16
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$23
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$22
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$21
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	mylib_display_hex
	move	$4,$19
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,32			# 0x20
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	lw	$2,16($sp)
	.set	noreorder
	.set	nomacro
	bne	$18,$0,$L83
	addu	$20,$20,$2
	.set	macro
	.set	reorder

	lw	$17,20($sp)
	lw	$16,24($sp)
	.set	noreorder
	.set	nomacro
	blez	$17,$L92
	move	$7,$0
	.set	macro
	.set	reorder

	move	$6,$0
	move	$4,$0
	move	$8,$2
$L85:
	move	$3,$7
	move	$2,$0
$L87:
	addu	$5,$16,$3
	lw	$5,0($5)
	addiu	$2,$2,1
	addiu	$3,$3,4
	.set	noreorder
	.set	nomacro
	bne	$2,$17,$L87
	addu	$4,$4,$5
	.set	macro
	.set	reorder

	addiu	$6,$6,1
	.set	noreorder
	.set	nomacro
	bne	$6,$17,$L85
	addu	$7,$7,$8
	.set	macro
	.set	reorder

$L84:
	jal	mylib_display_hex
	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,10			# 0xa
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	output_buffer_put
	li	$4,13			# 0xd
	.set	macro
	.set	reorder

	jal	mylib_finalize
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$23,84($sp)
	lw	$22,80($sp)
	lw	$21,76($sp)
	lw	$20,72($sp)
	lw	$19,68($sp)
	lw	$18,64($sp)
	lw	$17,60($sp)
	lw	$16,56($sp)
	move	$2,$0
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,96
	.set	macro
	.set	reorder

$L102:
	lw	$4,20($sp)
	li	$2,4			# 0x4
	li	$11,4			# 0x4
	addu	$24,$4,$19
	.set	noreorder
	.set	nomacro
	j	$L77
	addu	$fp,$21,$17
	.set	macro
	.set	reorder

$L101:
	lw	$2,20($sp)
	addu	$fp,$21,$17
	addu	$31,$19,$2
	.set	noreorder
	.set	nomacro
	j	$L72
	li	$2,4			# 0x4
	.set	macro
	.set	reorder

$L80:
	lw	$4,52($sp)
	#nop
	addu	$2,$14,$4
	li	$4,161021952			# 0x9990000
	ori	$4,$4,0x9999
	.set	noreorder
	.set	nomacro
	j	$L89
	sw	$4,0($2)
	.set	macro
	.set	reorder

$L100:
	.set	noreorder
	.set	nomacro
	j	$L67
	addiu	$16,$16,%lo(buf)
	.set	macro
	.set	reorder

$L92:
	.set	noreorder
	.set	nomacro
	j	$L84
	move	$4,$0
	.set	macro
	.set	reorder

	.end	main
	.size	main, .-main
	.globl	buf
	.section	.dummy_space2,"aw",@progbits
	.align	4
	.type	buf, @object
	.size	buf, 2097152
buf:
	.space	2097152

	.comm	init_iter,4,4

	.comm	init_n,4,4

	.comm	init_data,4,16
	.globl	dummy_mem
	.section	.dummy_space,"aw",@progbits
	.align	4
	.type	dummy_mem, @object
	.size	dummy_mem, 5767168
dummy_mem:
	.space	5767168
	.local	output_buffer_size
	.comm	output_buffer_size,4,4
	.local	output_buffer
	.comm	output_buffer,1024,4
	.ident	"GCC: (GNU) 4.8.3"
