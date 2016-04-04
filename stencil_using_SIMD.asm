
stencil_using_SIMD:     file format elf32-littlemips


Disassembly of section .startup:

00000000 <_start>:
   0:	00000000 	nop
   4:	00000821 	move	$1,$0
   8:	00001021 	move	$2,$0
   c:	00001821 	move	$3,$0
  10:	00002021 	move	$4,$0
  14:	00002821 	move	$5,$0
  18:	00003021 	move	$6,$0
  1c:	00003821 	move	$7,$0
  20:	00004021 	move	$8,$0
  24:	00004821 	move	$9,$0
  28:	00005021 	move	$10,$0
  2c:	00005821 	move	$11,$0
  30:	00006021 	move	$12,$0
  34:	00006821 	move	$13,$0
  38:	00007021 	move	$14,$0
  3c:	00007821 	move	$15,$0
  40:	00008021 	move	$16,$0
  44:	00008821 	move	$17,$0
  48:	00009021 	move	$18,$0
  4c:	00009821 	move	$19,$0
  50:	0000a021 	move	$20,$0
  54:	0000a821 	move	$21,$0
  58:	0000b021 	move	$22,$0
  5c:	0000b821 	move	$23,$0
  60:	0000c021 	move	$24,$0
  64:	0000c821 	move	$25,$0
  68:	0000d021 	move	$26,$0
  6c:	0000d821 	move	$27,$0
  70:	0000f021 	move	$30,$0
  74:	0000f821 	move	$31,$0
  78:	3c1c0005 	lui	$28,0x5
  7c:	279c7ff0 	addiu	$28,$28,32752
  80:	3c1d7fff 	lui	$29,0x7fff
  84:	37bdff00 	ori	$29,$29,0xff00
  88:	080001ab 	j	6ac <main>
  8c:	00000000 	nop

Disassembly of section .text:

00000200 <output_buffer_put>:
     200:	8f828410 	lw	$2,-31728($28)
     204:	3c070005 	lui	$7,0x5
     208:	24e70000 	addiu	$7,$7,0
     20c:	24430001 	addiu	$3,$2,1
     210:	28650400 	slti	$5,$3,1024
     214:	00471021 	addu	$2,$2,$7
     218:	af838410 	sw	$3,-31728($28)
     21c:	14a00008 	bnez	$5,240 <output_buffer_put+0x40>
     220:	a0440000 	sb	$4,0($2)
     224:	24040001 	li	$4,1
     228:	00e02821 	move	$5,$7
     22c:	00603021 	move	$6,$3
     230:	24020fa4 	li	$2,4004
     234:	0000000c 	syscall
     238:	00401821 	move	$3,$2
     23c:	af808410 	sw	$0,-31728($28)
     240:	03e00008 	jr	$31
     244:	00000000 	nop

00000248 <mylib_wait>:
     248:	27bdfff8 	addiu	$29,$29,-8
     24c:	00001021 	move	$2,$0
     250:	afa00000 	sw	$0,0($29)
     254:	24040028 	li	$4,40
     258:	8fa30000 	lw	$3,0($29)
     25c:	00000000 	nop
     260:	00621821 	addu	$3,$3,$2
     264:	24420001 	addiu	$2,$2,1
     268:	1444fffb 	bne	$2,$4,258 <mylib_wait+0x10>
     26c:	afa30000 	sw	$3,0($29)
     270:	03e00008 	jr	$31
     274:	27bd0008 	addiu	$29,$29,8

00000278 <mylib_display_dec>:
     278:	27bdfbe0 	addiu	$29,$29,-1056
     27c:	afbf041c 	sw	$31,1052($29)
     280:	afb20418 	sw	$18,1048($29)
     284:	afb10414 	sw	$17,1044($29)
     288:	04800018 	bltz	$4,2ec <mylib_display_dec+0x74>
     28c:	afb00410 	sw	$16,1040($29)
     290:	14800068 	bnez	$4,434 <mylib_display_dec+0x1bc>
     294:	24020030 	li	$2,48
     298:	afa20010 	sw	$2,16($29)
     29c:	24040030 	li	$4,48
     2a0:	00008021 	move	$16,$0
     2a4:	27a90010 	addiu	$9,$29,16
     2a8:	2610ffff 	addiu	$16,$16,-1
     2ac:	00108880 	sll	$17,$16,0x2
     2b0:	01318821 	addu	$17,$9,$17
     2b4:	080000b1 	j	2c4 <mylib_display_dec+0x4c>
     2b8:	2412ffff 	li	$18,-1
     2bc:	8e240000 	lw	$4,0($17)
     2c0:	2631fffc 	addiu	$17,$17,-4
     2c4:	0c000080 	jal	200 <output_buffer_put>
     2c8:	00000000 	nop
     2cc:	1612fffb 	bne	$16,$18,2bc <mylib_display_dec+0x44>
     2d0:	2610ffff 	addiu	$16,$16,-1
     2d4:	8fbf041c 	lw	$31,1052($29)
     2d8:	8fb20418 	lw	$18,1048($29)
     2dc:	8fb10414 	lw	$17,1044($29)
     2e0:	8fb00410 	lw	$16,1040($29)
     2e4:	03e00008 	jr	$31
     2e8:	27bd0420 	addiu	$29,$29,1056
     2ec:	00042023 	negu	$4,$4
     2f0:	240b0001 	li	$11,1
     2f4:	3c066666 	lui	$6,0x6666
     2f8:	24c66667 	addiu	$6,$6,26215
     2fc:	00860018 	mult	$4,$6
     300:	00042fc3 	sra	$5,$4,0x1f
     304:	27a90010 	addiu	$9,$29,16
     308:	01201821 	move	$3,$9
     30c:	00004021 	move	$8,$0
     310:	240a0001 	li	$10,1
     314:	240c0002 	li	$12,2
     318:	240d0003 	li	$13,3
     31c:	240e0004 	li	$14,4
     320:	240f0005 	li	$15,5
     324:	24110006 	li	$17,6
     328:	00001010 	mfhi	$2
     32c:	00021083 	sra	$2,$2,0x2
     330:	00451023 	subu	$2,$2,$5
     334:	00023840 	sll	$7,$2,0x1
     338:	000210c0 	sll	$2,$2,0x3
     33c:	00e21021 	addu	$2,$7,$2
     340:	00821023 	subu	$2,$4,$2
     344:	10400031 	beqz	$2,40c <mylib_display_dec+0x194>
     348:	24120007 	li	$18,7
     34c:	104a0031 	beq	$2,$10,414 <mylib_display_dec+0x19c>
     350:	00000000 	nop
     354:	104c0031 	beq	$2,$12,41c <mylib_display_dec+0x1a4>
     358:	00000000 	nop
     35c:	104d0031 	beq	$2,$13,424 <mylib_display_dec+0x1ac>
     360:	00000000 	nop
     364:	104e0031 	beq	$2,$14,42c <mylib_display_dec+0x1b4>
     368:	00000000 	nop
     36c:	104f0033 	beq	$2,$15,43c <mylib_display_dec+0x1c4>
     370:	00000000 	nop
     374:	10510033 	beq	$2,$17,444 <mylib_display_dec+0x1cc>
     378:	00000000 	nop
     37c:	10520033 	beq	$2,$18,44c <mylib_display_dec+0x1d4>
     380:	00000000 	nop
     384:	38420008 	xori	$2,$2,0x8
     388:	0002102b 	sltu	$2,$0,$2
     38c:	24420038 	addiu	$2,$2,56
     390:	00860018 	mult	$4,$6
     394:	ac620000 	sw	$2,0($3)
     398:	25100001 	addiu	$16,$8,1
     39c:	00002010 	mfhi	$4
     3a0:	00042083 	sra	$4,$4,0x2
     3a4:	00852023 	subu	$4,$4,$5
     3a8:	1480000d 	bnez	$4,3e0 <mylib_display_dec+0x168>
     3ac:	24630004 	addiu	$3,$3,4
     3b0:	11600005 	beqz	$11,3c8 <mylib_display_dec+0x150>
     3b4:	00101080 	sll	$2,$16,0x2
     3b8:	01221021 	addu	$2,$9,$2
     3bc:	2403002d 	li	$3,45
     3c0:	ac430000 	sw	$3,0($2)
     3c4:	25100002 	addiu	$16,$8,2
     3c8:	2610ffff 	addiu	$16,$16,-1
     3cc:	00101080 	sll	$2,$16,0x2
     3d0:	01221021 	addu	$2,$9,$2
     3d4:	8c440000 	lw	$4,0($2)
     3d8:	080000ab 	j	2ac <mylib_display_dec+0x34>
     3dc:	2610ffff 	addiu	$16,$16,-1
     3e0:	00860018 	mult	$4,$6
     3e4:	00042fc3 	sra	$5,$4,0x1f
     3e8:	00001010 	mfhi	$2
     3ec:	00021083 	sra	$2,$2,0x2
     3f0:	00451023 	subu	$2,$2,$5
     3f4:	00023840 	sll	$7,$2,0x1
     3f8:	000210c0 	sll	$2,$2,0x3
     3fc:	00e21021 	addu	$2,$7,$2
     400:	00821023 	subu	$2,$4,$2
     404:	1440ffd1 	bnez	$2,34c <mylib_display_dec+0xd4>
     408:	02004021 	move	$8,$16
     40c:	080000e4 	j	390 <mylib_display_dec+0x118>
     410:	24020030 	li	$2,48
     414:	080000e4 	j	390 <mylib_display_dec+0x118>
     418:	24020031 	li	$2,49
     41c:	080000e4 	j	390 <mylib_display_dec+0x118>
     420:	24020032 	li	$2,50
     424:	080000e4 	j	390 <mylib_display_dec+0x118>
     428:	24020033 	li	$2,51
     42c:	080000e4 	j	390 <mylib_display_dec+0x118>
     430:	24020034 	li	$2,52
     434:	080000bd 	j	2f4 <mylib_display_dec+0x7c>
     438:	00005821 	move	$11,$0
     43c:	080000e4 	j	390 <mylib_display_dec+0x118>
     440:	24020035 	li	$2,53
     444:	080000e4 	j	390 <mylib_display_dec+0x118>
     448:	24020036 	li	$2,54
     44c:	080000e4 	j	390 <mylib_display_dec+0x118>
     450:	24020037 	li	$2,55

00000454 <mylib_display_hex>:
     454:	27bdffc0 	addiu	$29,$29,-64
     458:	27a20010 	addiu	$2,$29,16
     45c:	afb10038 	sw	$17,56($29)
     460:	afb00034 	sw	$16,52($29)
     464:	afbf003c 	sw	$31,60($29)
     468:	00408821 	move	$17,$2
     46c:	27a50030 	addiu	$5,$29,48
     470:	24060001 	li	$6,1
     474:	24070002 	li	$7,2
     478:	24080003 	li	$8,3
     47c:	24090004 	li	$9,4
     480:	240a0005 	li	$10,5
     484:	240b0006 	li	$11,6
     488:	240c0007 	li	$12,7
     48c:	240d0008 	li	$13,8
     490:	240e0009 	li	$14,9
     494:	240f000a 	li	$15,10
     498:	2410000b 	li	$16,11
     49c:	2418000c 	li	$24,12
     4a0:	2419000d 	li	$25,13
     4a4:	3083000f 	andi	$3,$4,0xf
     4a8:	1060001f 	beqz	$3,528 <mylib_display_hex+0xd4>
     4ac:	00000000 	nop
     4b0:	1066002e 	beq	$3,$6,56c <mylib_display_hex+0x118>
     4b4:	00000000 	nop
     4b8:	1067002e 	beq	$3,$7,574 <mylib_display_hex+0x120>
     4bc:	00000000 	nop
     4c0:	1068002e 	beq	$3,$8,57c <mylib_display_hex+0x128>
     4c4:	00000000 	nop
     4c8:	1069002e 	beq	$3,$9,584 <mylib_display_hex+0x130>
     4cc:	00000000 	nop
     4d0:	106a002e 	beq	$3,$10,58c <mylib_display_hex+0x138>
     4d4:	00000000 	nop
     4d8:	106b002e 	beq	$3,$11,594 <mylib_display_hex+0x140>
     4dc:	00000000 	nop
     4e0:	106c002e 	beq	$3,$12,59c <mylib_display_hex+0x148>
     4e4:	00000000 	nop
     4e8:	106d0030 	beq	$3,$13,5ac <mylib_display_hex+0x158>
     4ec:	00000000 	nop
     4f0:	106e0030 	beq	$3,$14,5b4 <mylib_display_hex+0x160>
     4f4:	00000000 	nop
     4f8:	106f002a 	beq	$3,$15,5a4 <mylib_display_hex+0x150>
     4fc:	00000000 	nop
     500:	1070002e 	beq	$3,$16,5bc <mylib_display_hex+0x168>
     504:	00000000 	nop
     508:	1078002e 	beq	$3,$24,5c4 <mylib_display_hex+0x170>
     50c:	00000000 	nop
     510:	1079002e 	beq	$3,$25,5cc <mylib_display_hex+0x178>
     514:	00000000 	nop
     518:	3863000e 	xori	$3,$3,0xe
     51c:	0003182b 	sltu	$3,$0,$3
     520:	0800014b 	j	52c <mylib_display_hex+0xd8>
     524:	24630065 	addiu	$3,$3,101
     528:	24030030 	li	$3,48
     52c:	ac430000 	sw	$3,0($2)
     530:	24420004 	addiu	$2,$2,4
     534:	1445ffdb 	bne	$2,$5,4a4 <mylib_display_hex+0x50>
     538:	00042103 	sra	$4,$4,0x4
     53c:	27b0002c 	addiu	$16,$29,44
     540:	2631fffc 	addiu	$17,$17,-4
     544:	8e040000 	lw	$4,0($16)
     548:	0c000080 	jal	200 <output_buffer_put>
     54c:	2610fffc 	addiu	$16,$16,-4
     550:	1611fffc 	bne	$16,$17,544 <mylib_display_hex+0xf0>
     554:	00000000 	nop
     558:	8fbf003c 	lw	$31,60($29)
     55c:	8fb10038 	lw	$17,56($29)
     560:	8fb00034 	lw	$16,52($29)
     564:	03e00008 	jr	$31
     568:	27bd0040 	addiu	$29,$29,64
     56c:	0800014b 	j	52c <mylib_display_hex+0xd8>
     570:	24030031 	li	$3,49
     574:	0800014b 	j	52c <mylib_display_hex+0xd8>
     578:	24030032 	li	$3,50
     57c:	0800014b 	j	52c <mylib_display_hex+0xd8>
     580:	24030033 	li	$3,51
     584:	0800014b 	j	52c <mylib_display_hex+0xd8>
     588:	24030034 	li	$3,52
     58c:	0800014b 	j	52c <mylib_display_hex+0xd8>
     590:	24030035 	li	$3,53
     594:	0800014b 	j	52c <mylib_display_hex+0xd8>
     598:	24030036 	li	$3,54
     59c:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5a0:	24030037 	li	$3,55
     5a4:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5a8:	24030061 	li	$3,97
     5ac:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5b0:	24030038 	li	$3,56
     5b4:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5b8:	24030039 	li	$3,57
     5bc:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5c0:	24030062 	li	$3,98
     5c4:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5c8:	24030063 	li	$3,99
     5cc:	0800014b 	j	52c <mylib_display_hex+0xd8>
     5d0:	24030064 	li	$3,100

000005d4 <mylib_display_char>:
     5d4:	08000080 	j	200 <output_buffer_put>
     5d8:	00000000 	nop

000005dc <mylib_display_newline>:
     5dc:	27bdffe8 	addiu	$29,$29,-24
     5e0:	afbf0014 	sw	$31,20($29)
     5e4:	0c000080 	jal	200 <output_buffer_put>
     5e8:	2404000a 	li	$4,10
     5ec:	8fbf0014 	lw	$31,20($29)
     5f0:	2404000d 	li	$4,13
     5f4:	08000080 	j	200 <output_buffer_put>
     5f8:	27bd0018 	addiu	$29,$29,24

000005fc <mylib_flush>:
     5fc:	3c030005 	lui	$3,0x5
     600:	8f878410 	lw	$7,-31728($28)
     604:	24630000 	addiu	$3,$3,0
     608:	24040001 	li	$4,1
     60c:	00602821 	move	$5,$3
     610:	00e03021 	move	$6,$7
     614:	24020fa4 	li	$2,4004
     618:	0000000c 	syscall
     61c:	00401821 	move	$3,$2
     620:	03e00008 	jr	$31
     624:	af808410 	sw	$0,-31728($28)

00000628 <mylib_finalize>:
     628:	27bdffe8 	addiu	$29,$29,-24
     62c:	afbf0014 	sw	$31,20($29)
     630:	0c000080 	jal	200 <output_buffer_put>
     634:	2404000a 	li	$4,10
     638:	0c000080 	jal	200 <output_buffer_put>
     63c:	2404000d 	li	$4,13
     640:	0c000080 	jal	200 <output_buffer_put>
     644:	24040045 	li	$4,69
     648:	0c000080 	jal	200 <output_buffer_put>
     64c:	2404004e 	li	$4,78
     650:	0c000080 	jal	200 <output_buffer_put>
     654:	24040044 	li	$4,68
     658:	0c000080 	jal	200 <output_buffer_put>
     65c:	2404000a 	li	$4,10
     660:	0c000080 	jal	200 <output_buffer_put>
     664:	2404000d 	li	$4,13
     668:	3c030005 	lui	$3,0x5
     66c:	8f878410 	lw	$7,-31728($28)
     670:	24630000 	addiu	$3,$3,0
     674:	24040001 	li	$4,1
     678:	00602821 	move	$5,$3
     67c:	00e03021 	move	$6,$7
     680:	24020fa4 	li	$2,4004
     684:	0000000c 	syscall
     688:	00401821 	move	$3,$2
     68c:	af808410 	sw	$0,-31728($28)
     690:	24040000 	li	$4,0
     694:	24020fa1 	li	$2,4001
     698:	0000000c 	syscall
     69c:	8fbf0014 	lw	$31,20($29)
     6a0:	00000000 	nop
     6a4:	03e00008 	jr	$31
     6a8:	27bd0018 	addiu	$29,$29,24

000006ac <main>:
     6ac:	3c030001 	lui	$3,0x1
     6b0:	24630000 	addiu	$3,$3,0
     6b4:	3c020004 	lui	$2,0x4
     6b8:	00431021 	addu	$2,$2,$3
     6bc:	af838420 	sw	$3,-31712($28)
     6c0:	3c030005 	lui	$3,0x5
     6c4:	2463fff8 	addiu	$3,$3,-8
     6c8:	af838428 	sw	$3,-31704($28)
     6cc:	3c030005 	lui	$3,0x5
     6d0:	27bdffa0 	addiu	$29,$29,-96
     6d4:	2463fffc 	addiu	$3,$3,-4
     6d8:	24040073 	li	$4,115
     6dc:	afbf005c 	sw	$31,92($29)
     6e0:	af838424 	sw	$3,-31708($28)
     6e4:	afb20040 	sw	$18,64($29)
     6e8:	afb1003c 	sw	$17,60($29)
     6ec:	8c52fffc 	lw	$18,-4($2)
     6f0:	8c51fff8 	lw	$17,-8($2)
     6f4:	afbe0058 	sw	$30,88($29)
     6f8:	afb70054 	sw	$23,84($29)
     6fc:	afb60050 	sw	$22,80($29)
     700:	afb5004c 	sw	$21,76($29)
     704:	afb40048 	sw	$20,72($29)
     708:	afb30044 	sw	$19,68($29)
     70c:	0c000080 	jal	200 <output_buffer_put>
     710:	afb00038 	sw	$16,56($29)
     714:	0c000080 	jal	200 <output_buffer_put>
     718:	24040074 	li	$4,116
     71c:	0c000080 	jal	200 <output_buffer_put>
     720:	24040065 	li	$4,101
     724:	0c000080 	jal	200 <output_buffer_put>
     728:	2404006e 	li	$4,110
     72c:	0c000080 	jal	200 <output_buffer_put>
     730:	24040063 	li	$4,99
     734:	0c000080 	jal	200 <output_buffer_put>
     738:	24040069 	li	$4,105
     73c:	0c000080 	jal	200 <output_buffer_put>
     740:	2404006c 	li	$4,108
     744:	0c000080 	jal	200 <output_buffer_put>
     748:	24040020 	li	$4,32
     74c:	0c000080 	jal	200 <output_buffer_put>
     750:	2404006e 	li	$4,110
     754:	0c000080 	jal	200 <output_buffer_put>
     758:	2404003d 	li	$4,61
     75c:	0c00009e 	jal	278 <mylib_display_dec>
     760:	02202021 	move	$4,$17
     764:	0c000080 	jal	200 <output_buffer_put>
     768:	24040020 	li	$4,32
     76c:	0c000080 	jal	200 <output_buffer_put>
     770:	24040069 	li	$4,105
     774:	0c000080 	jal	200 <output_buffer_put>
     778:	2404003d 	li	$4,61
     77c:	0c00009e 	jal	278 <mylib_display_dec>
     780:	02402021 	move	$4,$18
     784:	0c000080 	jal	200 <output_buffer_put>
     788:	2404000a 	li	$4,10
     78c:	0c000080 	jal	200 <output_buffer_put>
     790:	2404000d 	li	$4,13
     794:	70000035 	pinsw	$0,$0,$0,0x0
	...
     7a0:	70000075 	pinsw	$0,$0,$0,0x1
	...
     7ac:	700000b5 	pinsw	$0,$0,$0,0x2
	...
     7b8:	700000f5 	pinsw	$0,$0,$0,0x3
     7bc:	02310018 	mult	$17,$17
     7c0:	00001012 	mflo	$2
     7c4:	18400263 	blez	$2,1154 <main+0xaa8>
     7c8:	2442ffff 	addiu	$2,$2,-1
     7cc:	000240c2 	srl	$8,$2,0x3
     7d0:	8f898420 	lw	$9,-31712($28)
     7d4:	25080001 	addiu	$8,$8,1
     7d8:	3c10005d 	lui	$16,0x5d
     7dc:	3c0e0005 	lui	$14,0x5
     7e0:	00084140 	sll	$8,$8,0x5
     7e4:	00001021 	move	$2,$0
     7e8:	00001821 	move	$3,$0
     7ec:	26100420 	addiu	$16,$16,1056
     7f0:	25ce0420 	addiu	$14,$14,1056
     7f4:	00032080 	sll	$4,$3,0x2
     7f8:	01242021 	addu	$4,$9,$4
     7fc:	02022821 	addu	$5,$16,$2
     800:	01c23021 	addu	$6,$14,$2
     804:	78810000 	lq	$1,0($4)
     808:	78820010 	lq	$2,16($4)
     80c:	7cc00000 	sq	$0,0($6)
     810:	7cc00010 	sq	$0,16($6)
     814:	7ca10000 	sq	$1,0($5)
     818:	7ca20010 	sq	$2,16($5)
     81c:	24630008 	addiu	$3,$3,8
     820:	24420020 	addiu	$2,$2,32
     824:	1448fff3 	bne	$2,$8,7f4 <main+0x148>
     828:	3063ffff 	andi	$3,$3,0xffff
     82c:	001217c2 	srl	$2,$18,0x1f
     830:	00529021 	addu	$18,$2,$18
     834:	00129043 	sra	$18,$18,0x1
     838:	1a4001d2 	blez	$18,f84 <main+0x8d8>
     83c:	afb20024 	sw	$18,36($29)
     840:	26220001 	addiu	$2,$17,1
     844:	00021080 	sll	$2,$2,0x2
     848:	afa20034 	sw	$2,52($29)
     84c:	02021021 	addu	$2,$16,$2
     850:	afa20028 	sw	$2,40($29)
     854:	00111040 	sll	$2,$17,0x1
     858:	8fa40034 	lw	$4,52($29)
     85c:	afa20014 	sw	$2,20($29)
     860:	2622ffff 	addiu	$2,$17,-1
     864:	afa20010 	sw	$2,16($29)
     868:	8fa20034 	lw	$2,52($29)
     86c:	2634fff7 	addiu	$20,$17,-9
     870:	3c0e0005 	lui	$14,0x5
     874:	25ce0420 	addiu	$14,$14,1056
     878:	0014a082 	srl	$20,$20,0x2
     87c:	2627fffc 	addiu	$7,$17,-4
     880:	2499fffc 	addiu	$25,$4,-4
     884:	2a240003 	slti	$4,$17,3
     888:	26940002 	addiu	$20,$20,2
     88c:	afa4002c 	sw	$4,44($29)
     890:	3c0638e3 	lui	$6,0x38e3
     894:	28e40005 	slti	$4,$7,5
     898:	01c21021 	addu	$2,$14,$2
     89c:	0011b8c0 	sll	$23,$17,0x3
     8a0:	0014a080 	sll	$20,$20,0x2
     8a4:	afa0001c 	sw	$0,28($29)
     8a8:	afa40018 	sw	$4,24($29)
     8ac:	34c68e39 	ori	$6,$6,0x8e39
     8b0:	01c01821 	move	$3,$14
     8b4:	afa20030 	sw	$2,48($29)
     8b8:	8fa4002c 	lw	$4,44($29)
     8bc:	00000000 	nop
     8c0:	1480021d 	bnez	$4,1138 <main+0xa8c>
     8c4:	0200c021 	move	$24,$16
     8c8:	0220a821 	move	$21,$17
     8cc:	03209021 	move	$18,$25
     8d0:	24130004 	li	$19,4
     8d4:	24160001 	li	$22,1
     8d8:	7b020010 	lq	$2,16($24)
     8dc:	7b010000 	lq	$1,0($24)
     8e0:	00000000 	nop
     8e4:	7040083d 	pextw	$1,$2,0x0
     8e8:	70201838 	psllww	$3,$1,$0
     8ec:	00000000 	nop
     8f0:	7021203a 	psrlww	$4,$1,$1
     8f4:	70236808 	paddw	$13,$1,$3
	...
     900:	71a46808 	paddw	$13,$13,$4
     904:	02121021 	addu	$2,$16,$18
     908:	78460010 	lq	$6,16($2)
     90c:	78450000 	lq	$5,0($2)
     910:	00000000 	nop
     914:	70c0083d 	pextw	$1,$6,0x0
     918:	70a03838 	psllww	$7,$5,$0
     91c:	00000000 	nop
     920:	70a1403a 	psrlww	$8,$5,$1
     924:	70a77008 	paddw	$14,$5,$7
	...
     930:	71c87008 	paddw	$14,$14,$8
     934:	26d60001 	addiu	$22,$22,1
     938:	0317c021 	addu	$24,$24,$23
     93c:	7b0a0010 	lq	$10,16($24)
     940:	7b090000 	lq	$9,0($24)
     944:	00000000 	nop
     948:	7140083d 	pextw	$1,$10,0x0
     94c:	71205838 	psllww	$11,$9,$0
     950:	00000000 	nop
     954:	7121603a 	psrlww	$12,$9,$1
     958:	712b7808 	paddw	$15,$9,$11
	...
     964:	71ec7808 	paddw	$15,$15,$12
     968:	71ae8008 	paddw	$16,$13,$14
     96c:	00c00821 	move	$1,$6
     970:	00000000 	nop
     974:	720f8008 	paddw	$16,$16,$15
	...
     980:	72010609 	pmultsw	$16,$1
     984:	70008209 	pmfhi	$16
	...
     990:	7010807f 	psraw	$16,$16,0x1
     994:	01d21021 	addu	$2,$14,$18
     998:	8c440000 	lw	$4,0($2)
	...
     9a4:	72048035 	pinsw	$16,$16,$4,0x0
	...
     9b0:	7c500000 	sq	$16,0($2)
     9b4:	8fa40018 	lw	$4,24($29)
     9b8:	00000000 	nop
     9bc:	148001d9 	bnez	$4,1124 <main+0xa78>
     9c0:	240b0004 	li	$11,4
     9c4:	8fa40014 	lw	$4,20($29)
     9c8:	00117823 	negu	$15,$17
     9cc:	000f7880 	sll	$15,$15,0x2
     9d0:	0093f821 	addu	$31,$4,$19
     9d4:	02b1f021 	addu	$30,$21,$17
     9d8:	00116880 	sll	$13,$17,0x2
     9dc:	26420020 	addiu	$2,$18,32
     9e0:	24040004 	li	$4,4
     9e4:	702048fd 	pextw	$9,$1,0x3
     9e8:	70a040fd 	pextw	$8,$5,0x3
     9ec:	712028fd 	pextw	$5,$9,0x3
     9f0:	004f5021 	addu	$10,$2,$15
     9f4:	004d6021 	addu	$12,$2,$13
     9f8:	020a5021 	addu	$10,$16,$10
     9fc:	02025821 	addu	$11,$16,$2
     a00:	020c6021 	addu	$12,$16,$12
     a04:	70400808 	paddw	$1,$2,$0
     a08:	79420000 	lq	$2,0($10)
     a0c:	70c02808 	paddw	$5,$6,$0
     a10:	79660000 	lq	$6,0($11)
     a14:	71404808 	paddw	$9,$10,$0
     a18:	798a0000 	lq	$10,0($12)
     a1c:	7040083d 	pextw	$1,$2,0x0
     a20:	70291838 	psllww	$3,$1,$9
     a24:	00000000 	nop
     a28:	7021203a 	psrlww	$4,$1,$1
     a2c:	70236808 	paddw	$13,$1,$3
	...
     a38:	71a46808 	paddw	$13,$13,$4
     a3c:	70c0083d 	pextw	$1,$6,0x0
     a40:	70a83838 	psllww	$7,$5,$8
     a44:	00000000 	nop
     a48:	70a1403a 	psrlww	$8,$5,$1
     a4c:	70a77008 	paddw	$14,$5,$7
	...
     a58:	71c87008 	paddw	$14,$14,$8
     a5c:	7140083d 	pextw	$1,$10,0x0
     a60:	71255838 	psllww	$11,$9,$5
     a64:	00000000 	nop
     a68:	7121603a 	psrlww	$12,$9,$1
     a6c:	712b7808 	paddw	$15,$9,$11
	...
     a78:	71ec7808 	paddw	$15,$15,$12
     a7c:	2445fff0 	addiu	$5,$2,-16
     a80:	01c52821 	addu	$5,$14,$5
     a84:	71ae8008 	paddw	$16,$13,$14
     a88:	00c00821 	move	$1,$6
     a8c:	00000000 	nop
     a90:	720f8008 	paddw	$16,$16,$15
	...
     a9c:	72010609 	pmultsw	$16,$1
     aa0:	70008209 	pmfhi	$16
	...
     aac:	7010807f 	psraw	$16,$16,0x1
	...
     ab8:	7cb00000 	sq	$16,0($5)
     abc:	24840004 	addiu	$4,$4,4
     ac0:	0087282a 	slt	$5,$4,$7
     ac4:	14a0ffc7 	bnez	$5,9e4 <main+0x338>
     ac8:	24420010 	addiu	$2,$2,16
     acc:	02801021 	move	$2,$20
     ad0:	02805821 	move	$11,$20
     ad4:	702048fd 	pextw	$9,$1,0x3
     ad8:	70a040fd 	pextw	$8,$5,0x3
     adc:	712028fd 	pextw	$5,$9,0x3
     ae0:	02a22021 	addu	$4,$21,$2
     ae4:	02625021 	addu	$10,$19,$2
     ae8:	24840004 	addiu	$4,$4,4
     aec:	005f1021 	addu	$2,$2,$31
     af0:	00042080 	sll	$4,$4,0x2
     af4:	000a5080 	sll	$10,$10,0x2
     af8:	00021080 	sll	$2,$2,0x2
     afc:	020a5021 	addu	$10,$16,$10
     b00:	02046021 	addu	$12,$16,$4
     b04:	02021021 	addu	$2,$16,$2
     b08:	70400808 	paddw	$1,$2,$0
     b0c:	79420000 	lq	$2,0($10)
     b10:	70c02808 	paddw	$5,$6,$0
     b14:	79860000 	lq	$6,0($12)
     b18:	71404808 	paddw	$9,$10,$0
     b1c:	784a0000 	lq	$10,0($2)
     b20:	7040083d 	pextw	$1,$2,0x0
     b24:	70291838 	psllww	$3,$1,$9
     b28:	00000000 	nop
     b2c:	7021203a 	psrlww	$4,$1,$1
     b30:	70236808 	paddw	$13,$1,$3
	...
     b3c:	71a46808 	paddw	$13,$13,$4
     b40:	70c0083d 	pextw	$1,$6,0x0
     b44:	70a83838 	psllww	$7,$5,$8
     b48:	00000000 	nop
     b4c:	70a1403a 	psrlww	$8,$5,$1
     b50:	70a77008 	paddw	$14,$5,$7
	...
     b5c:	71c87008 	paddw	$14,$14,$8
     b60:	7140083d 	pextw	$1,$10,0x0
     b64:	71255838 	psllww	$11,$9,$5
     b68:	00000000 	nop
     b6c:	7121603a 	psrlww	$12,$9,$1
     b70:	712b7808 	paddw	$15,$9,$11
	...
     b7c:	71ec7808 	paddw	$15,$15,$12
     b80:	71ae8008 	paddw	$16,$13,$14
     b84:	00c00821 	move	$1,$6
     b88:	00000000 	nop
     b8c:	720f8008 	paddw	$16,$16,$15
	...
     b98:	72010609 	pmultsw	$16,$1
     b9c:	70008209 	pmfhi	$16
	...
     ba8:	7010807f 	psraw	$16,$16,0x1
     bac:	02aba821 	addu	$21,$21,$11
     bb0:	26b50003 	addiu	$21,$21,3
     bb4:	0015a880 	sll	$21,$21,0x2
     bb8:	01d57021 	addu	$14,$14,$21
     bbc:	8dc20000 	lw	$2,0($14)
	...
     bc8:	720280f5 	pinsw	$16,$16,$2,0x3
     bcc:	3c020005 	lui	$2,0x5
     bd0:	24420420 	addiu	$2,$2,1056
     bd4:	2484fff0 	addiu	$4,$4,-16
     bd8:	00607021 	move	$14,$3
     bdc:	00442021 	addu	$4,$2,$4
	...
     be8:	7c900000 	sq	$16,0($4)
     bec:	8fa40010 	lw	$4,16($29)
     bf0:	0319c023 	subu	$24,$24,$25
     bf4:	02599021 	addu	$18,$18,$25
     bf8:	02719821 	addu	$19,$19,$17
     bfc:	16c4ff36 	bne	$22,$4,8d8 <main+0x22c>
     c00:	03c0a821 	move	$21,$30
     c04:	8fa40030 	lw	$4,48($29)
     c08:	3c020999 	lui	$2,0x999
     c0c:	8fbf0018 	lw	$31,24($29)
     c10:	34429999 	ori	$2,$2,0x9999
     c14:	ac820000 	sw	$2,0($4)
     c18:	0220a821 	move	$21,$17
     c1c:	03209021 	move	$18,$25
     c20:	24130004 	li	$19,4
     c24:	24160001 	li	$22,1
     c28:	00607821 	move	$15,$3
     c2c:	afa30020 	sw	$3,32($29)
     c30:	79e20010 	lq	$2,16($15)
     c34:	79e10000 	lq	$1,0($15)
     c38:	00000000 	nop
     c3c:	7040083d 	pextw	$1,$2,0x0
     c40:	70201838 	psllww	$3,$1,$0
     c44:	00000000 	nop
     c48:	7021203a 	psrlww	$4,$1,$1
     c4c:	70236808 	paddw	$13,$1,$3
	...
     c58:	71a46808 	paddw	$13,$13,$4
     c5c:	00721021 	addu	$2,$3,$18
     c60:	78460010 	lq	$6,16($2)
     c64:	78450000 	lq	$5,0($2)
     c68:	00000000 	nop
     c6c:	70c0083d 	pextw	$1,$6,0x0
     c70:	70a03838 	psllww	$7,$5,$0
     c74:	00000000 	nop
     c78:	70a1403a 	psrlww	$8,$5,$1
     c7c:	70a77008 	paddw	$14,$5,$7
	...
     c88:	71c87008 	paddw	$14,$14,$8
     c8c:	26d60001 	addiu	$22,$22,1
     c90:	01f77821 	addu	$15,$15,$23
     c94:	79ea0010 	lq	$10,16($15)
     c98:	79e90000 	lq	$9,0($15)
     c9c:	00000000 	nop
     ca0:	7140083d 	pextw	$1,$10,0x0
     ca4:	71205838 	psllww	$11,$9,$0
     ca8:	00000000 	nop
     cac:	7121603a 	psrlww	$12,$9,$1
     cb0:	712b7808 	paddw	$15,$9,$11
	...
     cbc:	71ec7808 	paddw	$15,$15,$12
     cc0:	71ae8008 	paddw	$16,$13,$14
     cc4:	00c00821 	move	$1,$6
     cc8:	00000000 	nop
     ccc:	720f8008 	paddw	$16,$16,$15
	...
     cd8:	72010609 	pmultsw	$16,$1
     cdc:	70008209 	pmfhi	$16
	...
     ce8:	7010807f 	psraw	$16,$16,0x1
     cec:	02121021 	addu	$2,$16,$18
     cf0:	8c440000 	lw	$4,0($2)
	...
     cfc:	72048035 	pinsw	$16,$16,$4,0x0
	...
     d08:	7c500000 	sq	$16,0($2)
     d0c:	17e00100 	bnez	$31,1110 <main+0xa64>
     d10:	240b0004 	li	$11,4
     d14:	8fa40014 	lw	$4,20($29)
     d18:	00117023 	negu	$14,$17
     d1c:	000e7080 	sll	$14,$14,0x2
     d20:	0093c021 	addu	$24,$4,$19
     d24:	02b1f021 	addu	$30,$21,$17
     d28:	00116880 	sll	$13,$17,0x2
     d2c:	26420020 	addiu	$2,$18,32
     d30:	24040004 	li	$4,4
     d34:	702048fd 	pextw	$9,$1,0x3
     d38:	70a040fd 	pextw	$8,$5,0x3
     d3c:	712028fd 	pextw	$5,$9,0x3
     d40:	004e5021 	addu	$10,$2,$14
     d44:	004d6021 	addu	$12,$2,$13
     d48:	006a5021 	addu	$10,$3,$10
     d4c:	00625821 	addu	$11,$3,$2
     d50:	006c6021 	addu	$12,$3,$12
     d54:	70400808 	paddw	$1,$2,$0
     d58:	79420000 	lq	$2,0($10)
     d5c:	70c02808 	paddw	$5,$6,$0
     d60:	79660000 	lq	$6,0($11)
     d64:	71404808 	paddw	$9,$10,$0
     d68:	798a0000 	lq	$10,0($12)
     d6c:	7040083d 	pextw	$1,$2,0x0
     d70:	70291838 	psllww	$3,$1,$9
     d74:	00000000 	nop
     d78:	7021203a 	psrlww	$4,$1,$1
     d7c:	70236808 	paddw	$13,$1,$3
	...
     d88:	71a46808 	paddw	$13,$13,$4
     d8c:	70c0083d 	pextw	$1,$6,0x0
     d90:	70a83838 	psllww	$7,$5,$8
     d94:	00000000 	nop
     d98:	70a1403a 	psrlww	$8,$5,$1
     d9c:	70a77008 	paddw	$14,$5,$7
	...
     da8:	71c87008 	paddw	$14,$14,$8
     dac:	7140083d 	pextw	$1,$10,0x0
     db0:	71255838 	psllww	$11,$9,$5
     db4:	00000000 	nop
     db8:	7121603a 	psrlww	$12,$9,$1
     dbc:	712b7808 	paddw	$15,$9,$11
	...
     dc8:	71ec7808 	paddw	$15,$15,$12
     dcc:	2445fff0 	addiu	$5,$2,-16
     dd0:	02052821 	addu	$5,$16,$5
     dd4:	71ae8008 	paddw	$16,$13,$14
     dd8:	00c00821 	move	$1,$6
     ddc:	00000000 	nop
     de0:	720f8008 	paddw	$16,$16,$15
	...
     dec:	72010609 	pmultsw	$16,$1
     df0:	70008209 	pmfhi	$16
	...
     dfc:	7010807f 	psraw	$16,$16,0x1
	...
     e08:	7cb00000 	sq	$16,0($5)
     e0c:	24840004 	addiu	$4,$4,4
     e10:	0087282a 	slt	$5,$4,$7
     e14:	14a0ffc7 	bnez	$5,d34 <main+0x688>
     e18:	24420010 	addiu	$2,$2,16
     e1c:	02801021 	move	$2,$20
     e20:	02805821 	move	$11,$20
     e24:	702048fd 	pextw	$9,$1,0x3
     e28:	70a040fd 	pextw	$8,$5,0x3
     e2c:	712028fd 	pextw	$5,$9,0x3
     e30:	02a22021 	addu	$4,$21,$2
     e34:	02625021 	addu	$10,$19,$2
     e38:	24840004 	addiu	$4,$4,4
     e3c:	00581021 	addu	$2,$2,$24
     e40:	00042080 	sll	$4,$4,0x2
     e44:	000a5080 	sll	$10,$10,0x2
     e48:	00021080 	sll	$2,$2,0x2
     e4c:	006a5021 	addu	$10,$3,$10
     e50:	00646021 	addu	$12,$3,$4
     e54:	00621021 	addu	$2,$3,$2
     e58:	70400808 	paddw	$1,$2,$0
     e5c:	79420000 	lq	$2,0($10)
     e60:	70c02808 	paddw	$5,$6,$0
     e64:	79860000 	lq	$6,0($12)
     e68:	71404808 	paddw	$9,$10,$0
     e6c:	784a0000 	lq	$10,0($2)
     e70:	7040083d 	pextw	$1,$2,0x0
     e74:	70291838 	psllww	$3,$1,$9
     e78:	00000000 	nop
     e7c:	7021203a 	psrlww	$4,$1,$1
     e80:	70236808 	paddw	$13,$1,$3
	...
     e8c:	71a46808 	paddw	$13,$13,$4
     e90:	70c0083d 	pextw	$1,$6,0x0
     e94:	70a83838 	psllww	$7,$5,$8
     e98:	00000000 	nop
     e9c:	70a1403a 	psrlww	$8,$5,$1
     ea0:	70a77008 	paddw	$14,$5,$7
	...
     eac:	71c87008 	paddw	$14,$14,$8
     eb0:	7140083d 	pextw	$1,$10,0x0
     eb4:	71255838 	psllww	$11,$9,$5
     eb8:	00000000 	nop
     ebc:	7121603a 	psrlww	$12,$9,$1
     ec0:	712b7808 	paddw	$15,$9,$11
	...
     ecc:	71ec7808 	paddw	$15,$15,$12
     ed0:	71ae8008 	paddw	$16,$13,$14
     ed4:	00c00821 	move	$1,$6
     ed8:	00000000 	nop
     edc:	720f8008 	paddw	$16,$16,$15
	...
     ee8:	72010609 	pmultsw	$16,$1
     eec:	70008209 	pmfhi	$16
	...
     ef8:	7010807f 	psraw	$16,$16,0x1
     efc:	02aba821 	addu	$21,$21,$11
     f00:	26b50003 	addiu	$21,$21,3
     f04:	0015a880 	sll	$21,$21,0x2
     f08:	02158021 	addu	$16,$16,$21
     f0c:	8e020000 	lw	$2,0($16)
	...
     f18:	720280f5 	pinsw	$16,$16,$2,0x3
     f1c:	3c10005d 	lui	$16,0x5d
     f20:	26100420 	addiu	$16,$16,1056
     f24:	2484fff0 	addiu	$4,$4,-16
     f28:	02042021 	addu	$4,$16,$4
	...
     f34:	7c900000 	sq	$16,0($4)
     f38:	8fa40010 	lw	$4,16($29)
     f3c:	01f97823 	subu	$15,$15,$25
     f40:	02599021 	addu	$18,$18,$25
     f44:	02719821 	addu	$19,$19,$17
     f48:	16c4ff39 	bne	$22,$4,c30 <main+0x584>
     f4c:	03c0a821 	move	$21,$30
     f50:	8fae0020 	lw	$14,32($29)
     f54:	8fa2001c 	lw	$2,28($29)
     f58:	8fa40028 	lw	$4,40($29)
     f5c:	24420001 	addiu	$2,$2,1
     f60:	afa2001c 	sw	$2,28($29)
     f64:	3c020999 	lui	$2,0x999
     f68:	34429999 	ori	$2,$2,0x9999
     f6c:	ac820000 	sw	$2,0($4)
     f70:	8fa4001c 	lw	$4,28($29)
     f74:	8fa20024 	lw	$2,36($29)
     f78:	00000000 	nop
     f7c:	1482fe4e 	bne	$4,$2,8b8 <main+0x20c>
     f80:	00000000 	nop
     f84:	0c000080 	jal	200 <output_buffer_put>
     f88:	2404000a 	li	$4,10
     f8c:	0c000080 	jal	200 <output_buffer_put>
     f90:	2404000d 	li	$4,13
     f94:	00111080 	sll	$2,$17,0x2
     f98:	afa20010 	sw	$2,16($29)
     f9c:	0200a021 	move	$20,$16
     fa0:	24120010 	li	$18,16
     fa4:	afb10014 	sw	$17,20($29)
     fa8:	afb00018 	sw	$16,24($29)
     fac:	7a810000 	lq	$1,0($20)
     fb0:	7a820010 	lq	$2,16($20)
     fb4:	00000000 	nop
     fb8:	7020203d 	pextw	$4,$1,0x0
     fbc:	7020f07d 	pextw	$30,$1,0x1
     fc0:	702088bd 	pextw	$17,$1,0x2
     fc4:	702080fd 	pextw	$16,$1,0x3
     fc8:	7040b83d 	pextw	$23,$2,0x0
     fcc:	7040b07d 	pextw	$22,$2,0x1
     fd0:	7040a8bd 	pextw	$21,$2,0x2
     fd4:	704098fd 	pextw	$19,$2,0x3
     fd8:	0c000115 	jal	454 <mylib_display_hex>
     fdc:	2652ffff 	addiu	$18,$18,-1
     fe0:	0c000080 	jal	200 <output_buffer_put>
     fe4:	24040020 	li	$4,32
     fe8:	0c000115 	jal	454 <mylib_display_hex>
     fec:	03c02021 	move	$4,$30
     ff0:	0c000080 	jal	200 <output_buffer_put>
     ff4:	24040020 	li	$4,32
     ff8:	0c000115 	jal	454 <mylib_display_hex>
     ffc:	02202021 	move	$4,$17
    1000:	0c000080 	jal	200 <output_buffer_put>
    1004:	24040020 	li	$4,32
    1008:	0c000115 	jal	454 <mylib_display_hex>
    100c:	02002021 	move	$4,$16
    1010:	0c000080 	jal	200 <output_buffer_put>
    1014:	24040020 	li	$4,32
    1018:	0c000115 	jal	454 <mylib_display_hex>
    101c:	02e02021 	move	$4,$23
    1020:	0c000080 	jal	200 <output_buffer_put>
    1024:	24040020 	li	$4,32
    1028:	0c000115 	jal	454 <mylib_display_hex>
    102c:	02c02021 	move	$4,$22
    1030:	0c000080 	jal	200 <output_buffer_put>
    1034:	24040020 	li	$4,32
    1038:	0c000115 	jal	454 <mylib_display_hex>
    103c:	02a02021 	move	$4,$21
    1040:	0c000080 	jal	200 <output_buffer_put>
    1044:	24040020 	li	$4,32
    1048:	0c000115 	jal	454 <mylib_display_hex>
    104c:	02602021 	move	$4,$19
    1050:	0c000080 	jal	200 <output_buffer_put>
    1054:	24040020 	li	$4,32
    1058:	0c000080 	jal	200 <output_buffer_put>
    105c:	2404000a 	li	$4,10
    1060:	0c000080 	jal	200 <output_buffer_put>
    1064:	2404000d 	li	$4,13
    1068:	8fa20010 	lw	$2,16($29)
    106c:	1640ffcf 	bnez	$18,fac <main+0x900>
    1070:	0282a021 	addu	$20,$20,$2
    1074:	8fb10014 	lw	$17,20($29)
    1078:	8fb00018 	lw	$16,24($29)
    107c:	1a200038 	blez	$17,1160 <main+0xab4>
    1080:	00003821 	move	$7,$0
    1084:	00003021 	move	$6,$0
    1088:	00002021 	move	$4,$0
    108c:	00404021 	move	$8,$2
    1090:	00e01821 	move	$3,$7
    1094:	00001021 	move	$2,$0
    1098:	02032821 	addu	$5,$16,$3
    109c:	8ca50000 	lw	$5,0($5)
    10a0:	24420001 	addiu	$2,$2,1
    10a4:	24630004 	addiu	$3,$3,4
    10a8:	1451fffb 	bne	$2,$17,1098 <main+0x9ec>
    10ac:	00852021 	addu	$4,$4,$5
    10b0:	24c60001 	addiu	$6,$6,1
    10b4:	14d1fff6 	bne	$6,$17,1090 <main+0x9e4>
    10b8:	00e83821 	addu	$7,$7,$8
    10bc:	0c000115 	jal	454 <mylib_display_hex>
    10c0:	00000000 	nop
    10c4:	0c000080 	jal	200 <output_buffer_put>
    10c8:	2404000a 	li	$4,10
    10cc:	0c000080 	jal	200 <output_buffer_put>
    10d0:	2404000d 	li	$4,13
    10d4:	0c00018a 	jal	628 <mylib_finalize>
    10d8:	00000000 	nop
    10dc:	8fbf005c 	lw	$31,92($29)
    10e0:	8fbe0058 	lw	$30,88($29)
    10e4:	8fb70054 	lw	$23,84($29)
    10e8:	8fb60050 	lw	$22,80($29)
    10ec:	8fb5004c 	lw	$21,76($29)
    10f0:	8fb40048 	lw	$20,72($29)
    10f4:	8fb30044 	lw	$19,68($29)
    10f8:	8fb20040 	lw	$18,64($29)
    10fc:	8fb1003c 	lw	$17,60($29)
    1100:	8fb00038 	lw	$16,56($29)
    1104:	00001021 	move	$2,$0
    1108:	03e00008 	jr	$31
    110c:	27bd0060 	addiu	$29,$29,96
    1110:	8fa20014 	lw	$2,20($29)
    1114:	02b1f021 	addu	$30,$21,$17
    1118:	0053c021 	addu	$24,$2,$19
    111c:	08000389 	j	e24 <main+0x778>
    1120:	24020004 	li	$2,4
    1124:	8fa20014 	lw	$2,20($29)
    1128:	02b1f021 	addu	$30,$21,$17
    112c:	0262f821 	addu	$31,$19,$2
    1130:	080002b5 	j	ad4 <main+0x428>
    1134:	24020004 	li	$2,4
    1138:	8fa40034 	lw	$4,52($29)
    113c:	00000000 	nop
    1140:	01c41021 	addu	$2,$14,$4
    1144:	3c040999 	lui	$4,0x999
    1148:	34849999 	ori	$4,$4,0x9999
    114c:	080003d5 	j	f54 <main+0x8a8>
    1150:	ac440000 	sw	$4,0($2)
    1154:	3c10005d 	lui	$16,0x5d
    1158:	0800020b 	j	82c <main+0x180>
    115c:	26100420 	addiu	$16,$16,1056
    1160:	0800042f 	j	10bc <main+0xa10>
    1164:	00002021 	move	$4,$0
