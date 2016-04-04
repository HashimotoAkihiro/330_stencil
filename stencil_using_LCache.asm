
stencil_using_LCache:     file format elf32-littlemips


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
     7c0:	00003812 	mflo	$7
     7c4:	18e00263 	blez	$7,1154 <main+0xaa8>
     7c8:	3c10005d 	lui	$16,0x5d
     7cc:	8f888420 	lw	$8,-31712($28)
     7d0:	26100420 	addiu	$16,$16,1056
     7d4:	02001021 	move	$2,$16
     7d8:	00002821 	move	$5,$0
     7dc:	00001821 	move	$3,$0
     7e0:	00052080 	sll	$4,$5,0x2
     7e4:	01042021 	addu	$4,$8,$4
     7e8:	78810000 	lq	$1,0($4)
     7ec:	78820010 	lq	$2,16($4)
     7f0:	bc4d0000 	cache	0xd,0($2)
     7f4:	bc4d0010 	cache	0xd,16($2)
     7f8:	7c410000 	sq	$1,0($2)
     7fc:	7c420010 	sq	$2,16($2)
     800:	24630008 	addiu	$3,$3,8
     804:	24a50008 	addiu	$5,$5,8
     808:	0067202a 	slt	$4,$3,$7
     80c:	30a5ffff 	andi	$5,$5,0xffff
     810:	1480fff3 	bnez	$4,7e0 <main+0x134>
     814:	24420020 	addiu	$2,$2,32
     818:	001217c2 	srl	$2,$18,0x1f
     81c:	00529021 	addu	$18,$2,$18
     820:	00129043 	sra	$18,$18,0x1
     824:	1a4001d6 	blez	$18,f80 <main+0x8d4>
     828:	afb20024 	sw	$18,36($29)
     82c:	26220001 	addiu	$2,$17,1
     830:	00021080 	sll	$2,$2,0x2
     834:	afa20034 	sw	$2,52($29)
     838:	02021021 	addu	$2,$16,$2
     83c:	afa20028 	sw	$2,40($29)
     840:	00111040 	sll	$2,$17,0x1
     844:	8fa40034 	lw	$4,52($29)
     848:	afa20014 	sw	$2,20($29)
     84c:	2622ffff 	addiu	$2,$17,-1
     850:	afa20010 	sw	$2,16($29)
     854:	8fa20034 	lw	$2,52($29)
     858:	2634fff7 	addiu	$20,$17,-9
     85c:	3c0e0005 	lui	$14,0x5
     860:	25ce0420 	addiu	$14,$14,1056
     864:	0014a082 	srl	$20,$20,0x2
     868:	2627fffc 	addiu	$7,$17,-4
     86c:	2499fffc 	addiu	$25,$4,-4
     870:	2a240003 	slti	$4,$17,3
     874:	26940002 	addiu	$20,$20,2
     878:	afa4002c 	sw	$4,44($29)
     87c:	3c0638e3 	lui	$6,0x38e3
     880:	28e40005 	slti	$4,$7,5
     884:	01c21021 	addu	$2,$14,$2
     888:	0011b8c0 	sll	$23,$17,0x3
     88c:	0014a080 	sll	$20,$20,0x2
     890:	afa0001c 	sw	$0,28($29)
     894:	afa40018 	sw	$4,24($29)
     898:	34c68e39 	ori	$6,$6,0x8e39
     89c:	01c01821 	move	$3,$14
     8a0:	afa20030 	sw	$2,48($29)
     8a4:	8fa4002c 	lw	$4,44($29)
     8a8:	00000000 	nop
     8ac:	14800222 	bnez	$4,1138 <main+0xa8c>
     8b0:	0200c021 	move	$24,$16
     8b4:	0220a821 	move	$21,$17
     8b8:	03209021 	move	$18,$25
     8bc:	24130004 	li	$19,4
     8c0:	24160001 	li	$22,1
     8c4:	7b020010 	lq	$2,16($24)
     8c8:	7b010000 	lq	$1,0($24)
     8cc:	00000000 	nop
     8d0:	7040083d 	pextw	$1,$2,0x0
     8d4:	70201838 	psllww	$3,$1,$0
     8d8:	00000000 	nop
     8dc:	7021203a 	psrlww	$4,$1,$1
     8e0:	70236808 	paddw	$13,$1,$3
	...
     8ec:	71a46808 	paddw	$13,$13,$4
     8f0:	02121021 	addu	$2,$16,$18
     8f4:	78460010 	lq	$6,16($2)
     8f8:	78450000 	lq	$5,0($2)
     8fc:	00000000 	nop
     900:	70c0083d 	pextw	$1,$6,0x0
     904:	70a03838 	psllww	$7,$5,$0
     908:	00000000 	nop
     90c:	70a1403a 	psrlww	$8,$5,$1
     910:	70a77008 	paddw	$14,$5,$7
	...
     91c:	71c87008 	paddw	$14,$14,$8
     920:	26d60001 	addiu	$22,$22,1
     924:	0317c021 	addu	$24,$24,$23
     928:	7b0a0010 	lq	$10,16($24)
     92c:	7b090000 	lq	$9,0($24)
     930:	00000000 	nop
     934:	7140083d 	pextw	$1,$10,0x0
     938:	71205838 	psllww	$11,$9,$0
     93c:	00000000 	nop
     940:	7121603a 	psrlww	$12,$9,$1
     944:	712b7808 	paddw	$15,$9,$11
	...
     950:	71ec7808 	paddw	$15,$15,$12
     954:	71ae8008 	paddw	$16,$13,$14
     958:	00c00821 	move	$1,$6
     95c:	00000000 	nop
     960:	720f8008 	paddw	$16,$16,$15
	...
     96c:	72010609 	pmultsw	$16,$1
     970:	70008209 	pmfhi	$16
	...
     97c:	7010807f 	psraw	$16,$16,0x1
     980:	01d21021 	addu	$2,$14,$18
     984:	8c440000 	lw	$4,0($2)
	...
     990:	72048035 	pinsw	$16,$16,$4,0x0
     994:	bc4d0000 	cache	0xd,0($2)
	...
     9a0:	7c500000 	sq	$16,0($2)
     9a4:	8fa40018 	lw	$4,24($29)
     9a8:	00000000 	nop
     9ac:	148001dd 	bnez	$4,1124 <main+0xa78>
     9b0:	240b0004 	li	$11,4
     9b4:	8fa40014 	lw	$4,20($29)
     9b8:	00117823 	negu	$15,$17
     9bc:	000f7880 	sll	$15,$15,0x2
     9c0:	0093f821 	addu	$31,$4,$19
     9c4:	02b1f021 	addu	$30,$21,$17
     9c8:	00116880 	sll	$13,$17,0x2
     9cc:	26420020 	addiu	$2,$18,32
     9d0:	24040004 	li	$4,4
     9d4:	702048fd 	pextw	$9,$1,0x3
     9d8:	70a040fd 	pextw	$8,$5,0x3
     9dc:	712028fd 	pextw	$5,$9,0x3
     9e0:	004f5021 	addu	$10,$2,$15
     9e4:	004d6021 	addu	$12,$2,$13
     9e8:	020a5021 	addu	$10,$16,$10
     9ec:	02025821 	addu	$11,$16,$2
     9f0:	020c6021 	addu	$12,$16,$12
     9f4:	70400808 	paddw	$1,$2,$0
     9f8:	79420000 	lq	$2,0($10)
     9fc:	70c02808 	paddw	$5,$6,$0
     a00:	79660000 	lq	$6,0($11)
     a04:	71404808 	paddw	$9,$10,$0
     a08:	798a0000 	lq	$10,0($12)
     a0c:	7040083d 	pextw	$1,$2,0x0
     a10:	70291838 	psllww	$3,$1,$9
     a14:	00000000 	nop
     a18:	7021203a 	psrlww	$4,$1,$1
     a1c:	70236808 	paddw	$13,$1,$3
	...
     a28:	71a46808 	paddw	$13,$13,$4
     a2c:	70c0083d 	pextw	$1,$6,0x0
     a30:	70a83838 	psllww	$7,$5,$8
     a34:	00000000 	nop
     a38:	70a1403a 	psrlww	$8,$5,$1
     a3c:	70a77008 	paddw	$14,$5,$7
	...
     a48:	71c87008 	paddw	$14,$14,$8
     a4c:	7140083d 	pextw	$1,$10,0x0
     a50:	71255838 	psllww	$11,$9,$5
     a54:	00000000 	nop
     a58:	7121603a 	psrlww	$12,$9,$1
     a5c:	712b7808 	paddw	$15,$9,$11
	...
     a68:	71ec7808 	paddw	$15,$15,$12
     a6c:	71ae8008 	paddw	$16,$13,$14
     a70:	00c00821 	move	$1,$6
     a74:	00000000 	nop
     a78:	720f8008 	paddw	$16,$16,$15
	...
     a84:	72010609 	pmultsw	$16,$1
     a88:	70008209 	pmfhi	$16
	...
     a94:	7010807f 	psraw	$16,$16,0x1
     a98:	2445fff0 	addiu	$5,$2,-16
     a9c:	01c52821 	addu	$5,$14,$5
     aa0:	bcad0000 	cache	0xd,0($5)
	...
     aac:	7cb00000 	sq	$16,0($5)
     ab0:	24840004 	addiu	$4,$4,4
     ab4:	0087282a 	slt	$5,$4,$7
     ab8:	14a0ffc6 	bnez	$5,9d4 <main+0x328>
     abc:	24420010 	addiu	$2,$2,16
     ac0:	02801021 	move	$2,$20
     ac4:	02805821 	move	$11,$20
     ac8:	702048fd 	pextw	$9,$1,0x3
     acc:	70a040fd 	pextw	$8,$5,0x3
     ad0:	712028fd 	pextw	$5,$9,0x3
     ad4:	02a22021 	addu	$4,$21,$2
     ad8:	02625021 	addu	$10,$19,$2
     adc:	24840004 	addiu	$4,$4,4
     ae0:	005f1021 	addu	$2,$2,$31
     ae4:	00042080 	sll	$4,$4,0x2
     ae8:	000a5080 	sll	$10,$10,0x2
     aec:	00021080 	sll	$2,$2,0x2
     af0:	020a5021 	addu	$10,$16,$10
     af4:	02046021 	addu	$12,$16,$4
     af8:	02021021 	addu	$2,$16,$2
     afc:	70400808 	paddw	$1,$2,$0
     b00:	79420000 	lq	$2,0($10)
     b04:	70c02808 	paddw	$5,$6,$0
     b08:	79860000 	lq	$6,0($12)
     b0c:	71404808 	paddw	$9,$10,$0
     b10:	784a0000 	lq	$10,0($2)
     b14:	7040083d 	pextw	$1,$2,0x0
     b18:	70291838 	psllww	$3,$1,$9
     b1c:	00000000 	nop
     b20:	7021203a 	psrlww	$4,$1,$1
     b24:	70236808 	paddw	$13,$1,$3
	...
     b30:	71a46808 	paddw	$13,$13,$4
     b34:	70c0083d 	pextw	$1,$6,0x0
     b38:	70a83838 	psllww	$7,$5,$8
     b3c:	00000000 	nop
     b40:	70a1403a 	psrlww	$8,$5,$1
     b44:	70a77008 	paddw	$14,$5,$7
	...
     b50:	71c87008 	paddw	$14,$14,$8
     b54:	7140083d 	pextw	$1,$10,0x0
     b58:	71255838 	psllww	$11,$9,$5
     b5c:	00000000 	nop
     b60:	7121603a 	psrlww	$12,$9,$1
     b64:	712b7808 	paddw	$15,$9,$11
	...
     b70:	71ec7808 	paddw	$15,$15,$12
     b74:	71ae8008 	paddw	$16,$13,$14
     b78:	00c00821 	move	$1,$6
     b7c:	00000000 	nop
     b80:	720f8008 	paddw	$16,$16,$15
	...
     b8c:	72010609 	pmultsw	$16,$1
     b90:	70008209 	pmfhi	$16
	...
     b9c:	7010807f 	psraw	$16,$16,0x1
     ba0:	02aba821 	addu	$21,$21,$11
     ba4:	26b50003 	addiu	$21,$21,3
     ba8:	0015a880 	sll	$21,$21,0x2
     bac:	01d57021 	addu	$14,$14,$21
     bb0:	8dc20000 	lw	$2,0($14)
	...
     bbc:	720280f5 	pinsw	$16,$16,$2,0x3
     bc0:	2482fff0 	addiu	$2,$4,-16
     bc4:	3c040005 	lui	$4,0x5
     bc8:	24840420 	addiu	$4,$4,1056
     bcc:	00607021 	move	$14,$3
     bd0:	00821021 	addu	$2,$4,$2
     bd4:	bc4d0000 	cache	0xd,0($2)
	...
     be0:	7c500000 	sq	$16,0($2)
     be4:	8fa20010 	lw	$2,16($29)
     be8:	0319c023 	subu	$24,$24,$25
     bec:	02599021 	addu	$18,$18,$25
     bf0:	02719821 	addu	$19,$19,$17
     bf4:	16c2ff33 	bne	$22,$2,8c4 <main+0x218>
     bf8:	03c0a821 	move	$21,$30
     bfc:	8fa40030 	lw	$4,48($29)
     c00:	3c020999 	lui	$2,0x999
     c04:	8fbf0018 	lw	$31,24($29)
     c08:	34429999 	ori	$2,$2,0x9999
     c0c:	ac820000 	sw	$2,0($4)
     c10:	0220a821 	move	$21,$17
     c14:	03209021 	move	$18,$25
     c18:	24130004 	li	$19,4
     c1c:	24160001 	li	$22,1
     c20:	00607821 	move	$15,$3
     c24:	afa30020 	sw	$3,32($29)
     c28:	79e20010 	lq	$2,16($15)
     c2c:	79e10000 	lq	$1,0($15)
     c30:	00000000 	nop
     c34:	7040083d 	pextw	$1,$2,0x0
     c38:	70201838 	psllww	$3,$1,$0
     c3c:	00000000 	nop
     c40:	7021203a 	psrlww	$4,$1,$1
     c44:	70236808 	paddw	$13,$1,$3
	...
     c50:	71a46808 	paddw	$13,$13,$4
     c54:	00721021 	addu	$2,$3,$18
     c58:	78460010 	lq	$6,16($2)
     c5c:	78450000 	lq	$5,0($2)
     c60:	00000000 	nop
     c64:	70c0083d 	pextw	$1,$6,0x0
     c68:	70a03838 	psllww	$7,$5,$0
     c6c:	00000000 	nop
     c70:	70a1403a 	psrlww	$8,$5,$1
     c74:	70a77008 	paddw	$14,$5,$7
	...
     c80:	71c87008 	paddw	$14,$14,$8
     c84:	26d60001 	addiu	$22,$22,1
     c88:	01f77821 	addu	$15,$15,$23
     c8c:	79ea0010 	lq	$10,16($15)
     c90:	79e90000 	lq	$9,0($15)
     c94:	00000000 	nop
     c98:	7140083d 	pextw	$1,$10,0x0
     c9c:	71205838 	psllww	$11,$9,$0
     ca0:	00000000 	nop
     ca4:	7121603a 	psrlww	$12,$9,$1
     ca8:	712b7808 	paddw	$15,$9,$11
	...
     cb4:	71ec7808 	paddw	$15,$15,$12
     cb8:	71ae8008 	paddw	$16,$13,$14
     cbc:	00c00821 	move	$1,$6
     cc0:	00000000 	nop
     cc4:	720f8008 	paddw	$16,$16,$15
	...
     cd0:	72010609 	pmultsw	$16,$1
     cd4:	70008209 	pmfhi	$16
	...
     ce0:	7010807f 	psraw	$16,$16,0x1
     ce4:	02121021 	addu	$2,$16,$18
     ce8:	8c440000 	lw	$4,0($2)
	...
     cf4:	72048035 	pinsw	$16,$16,$4,0x0
     cf8:	bc4d0000 	cache	0xd,0($2)
	...
     d04:	7c500000 	sq	$16,0($2)
     d08:	17e00100 	bnez	$31,110c <main+0xa60>
     d0c:	24040004 	li	$4,4
     d10:	8fa20014 	lw	$2,20($29)
     d14:	00117023 	negu	$14,$17
     d18:	000e7080 	sll	$14,$14,0x2
     d1c:	0053c021 	addu	$24,$2,$19
     d20:	02b1f021 	addu	$30,$21,$17
     d24:	00116880 	sll	$13,$17,0x2
     d28:	26420020 	addiu	$2,$18,32
     d2c:	702048fd 	pextw	$9,$1,0x3
     d30:	70a040fd 	pextw	$8,$5,0x3
     d34:	712028fd 	pextw	$5,$9,0x3
     d38:	004e5021 	addu	$10,$2,$14
     d3c:	004d6021 	addu	$12,$2,$13
     d40:	006a5021 	addu	$10,$3,$10
     d44:	00625821 	addu	$11,$3,$2
     d48:	006c6021 	addu	$12,$3,$12
     d4c:	70400808 	paddw	$1,$2,$0
     d50:	79420000 	lq	$2,0($10)
     d54:	70c02808 	paddw	$5,$6,$0
     d58:	79660000 	lq	$6,0($11)
     d5c:	71404808 	paddw	$9,$10,$0
     d60:	798a0000 	lq	$10,0($12)
     d64:	7040083d 	pextw	$1,$2,0x0
     d68:	70291838 	psllww	$3,$1,$9
     d6c:	00000000 	nop
     d70:	7021203a 	psrlww	$4,$1,$1
     d74:	70236808 	paddw	$13,$1,$3
	...
     d80:	71a46808 	paddw	$13,$13,$4
     d84:	70c0083d 	pextw	$1,$6,0x0
     d88:	70a83838 	psllww	$7,$5,$8
     d8c:	00000000 	nop
     d90:	70a1403a 	psrlww	$8,$5,$1
     d94:	70a77008 	paddw	$14,$5,$7
	...
     da0:	71c87008 	paddw	$14,$14,$8
     da4:	7140083d 	pextw	$1,$10,0x0
     da8:	71255838 	psllww	$11,$9,$5
     dac:	00000000 	nop
     db0:	7121603a 	psrlww	$12,$9,$1
     db4:	712b7808 	paddw	$15,$9,$11
	...
     dc0:	71ec7808 	paddw	$15,$15,$12
     dc4:	71ae8008 	paddw	$16,$13,$14
     dc8:	00c00821 	move	$1,$6
     dcc:	00000000 	nop
     dd0:	720f8008 	paddw	$16,$16,$15
	...
     ddc:	72010609 	pmultsw	$16,$1
     de0:	70008209 	pmfhi	$16
	...
     dec:	7010807f 	psraw	$16,$16,0x1
     df0:	2445fff0 	addiu	$5,$2,-16
     df4:	02052821 	addu	$5,$16,$5
     df8:	bcad0000 	cache	0xd,0($5)
	...
     e04:	7cb00000 	sq	$16,0($5)
     e08:	24840004 	addiu	$4,$4,4
     e0c:	0087282a 	slt	$5,$4,$7
     e10:	14a0ffc6 	bnez	$5,d2c <main+0x680>
     e14:	24420010 	addiu	$2,$2,16
     e18:	02801021 	move	$2,$20
     e1c:	02805821 	move	$11,$20
     e20:	702048fd 	pextw	$9,$1,0x3
     e24:	70a040fd 	pextw	$8,$5,0x3
     e28:	712028fd 	pextw	$5,$9,0x3
     e2c:	02a22021 	addu	$4,$21,$2
     e30:	02625021 	addu	$10,$19,$2
     e34:	24840004 	addiu	$4,$4,4
     e38:	00581021 	addu	$2,$2,$24
     e3c:	00042080 	sll	$4,$4,0x2
     e40:	000a5080 	sll	$10,$10,0x2
     e44:	00021080 	sll	$2,$2,0x2
     e48:	006a5021 	addu	$10,$3,$10
     e4c:	00646021 	addu	$12,$3,$4
     e50:	00621021 	addu	$2,$3,$2
     e54:	70400808 	paddw	$1,$2,$0
     e58:	79420000 	lq	$2,0($10)
     e5c:	70c02808 	paddw	$5,$6,$0
     e60:	79860000 	lq	$6,0($12)
     e64:	71404808 	paddw	$9,$10,$0
     e68:	784a0000 	lq	$10,0($2)
     e6c:	7040083d 	pextw	$1,$2,0x0
     e70:	70291838 	psllww	$3,$1,$9
     e74:	00000000 	nop
     e78:	7021203a 	psrlww	$4,$1,$1
     e7c:	70236808 	paddw	$13,$1,$3
	...
     e88:	71a46808 	paddw	$13,$13,$4
     e8c:	70c0083d 	pextw	$1,$6,0x0
     e90:	70a83838 	psllww	$7,$5,$8
     e94:	00000000 	nop
     e98:	70a1403a 	psrlww	$8,$5,$1
     e9c:	70a77008 	paddw	$14,$5,$7
	...
     ea8:	71c87008 	paddw	$14,$14,$8
     eac:	7140083d 	pextw	$1,$10,0x0
     eb0:	71255838 	psllww	$11,$9,$5
     eb4:	00000000 	nop
     eb8:	7121603a 	psrlww	$12,$9,$1
     ebc:	712b7808 	paddw	$15,$9,$11
	...
     ec8:	71ec7808 	paddw	$15,$15,$12
     ecc:	71ae8008 	paddw	$16,$13,$14
     ed0:	00c00821 	move	$1,$6
     ed4:	00000000 	nop
     ed8:	720f8008 	paddw	$16,$16,$15
	...
     ee4:	72010609 	pmultsw	$16,$1
     ee8:	70008209 	pmfhi	$16
	...
     ef4:	7010807f 	psraw	$16,$16,0x1
     ef8:	02aba821 	addu	$21,$21,$11
     efc:	26b50003 	addiu	$21,$21,3
     f00:	0015a880 	sll	$21,$21,0x2
     f04:	02158021 	addu	$16,$16,$21
     f08:	8e020000 	lw	$2,0($16)
	...
     f14:	720280f5 	pinsw	$16,$16,$2,0x3
     f18:	3c10005d 	lui	$16,0x5d
     f1c:	26100420 	addiu	$16,$16,1056
     f20:	2484fff0 	addiu	$4,$4,-16
     f24:	02042021 	addu	$4,$16,$4
	...
     f30:	7c900000 	sq	$16,0($4)
     f34:	8fa40010 	lw	$4,16($29)
     f38:	01f97823 	subu	$15,$15,$25
     f3c:	02599021 	addu	$18,$18,$25
     f40:	02719821 	addu	$19,$19,$17
     f44:	16c4ff38 	bne	$22,$4,c28 <main+0x57c>
     f48:	03c0a821 	move	$21,$30
     f4c:	8fae0020 	lw	$14,32($29)
     f50:	8fa2001c 	lw	$2,28($29)
     f54:	8fa40028 	lw	$4,40($29)
     f58:	24420001 	addiu	$2,$2,1
     f5c:	afa2001c 	sw	$2,28($29)
     f60:	3c020999 	lui	$2,0x999
     f64:	34429999 	ori	$2,$2,0x9999
     f68:	ac820000 	sw	$2,0($4)
     f6c:	8fa4001c 	lw	$4,28($29)
     f70:	8fa20024 	lw	$2,36($29)
     f74:	00000000 	nop
     f78:	1482fe4a 	bne	$4,$2,8a4 <main+0x1f8>
     f7c:	00000000 	nop
     f80:	0c000080 	jal	200 <output_buffer_put>
     f84:	2404000a 	li	$4,10
     f88:	0c000080 	jal	200 <output_buffer_put>
     f8c:	2404000d 	li	$4,13
     f90:	00111080 	sll	$2,$17,0x2
     f94:	afa20010 	sw	$2,16($29)
     f98:	0200a021 	move	$20,$16
     f9c:	24120010 	li	$18,16
     fa0:	afb10014 	sw	$17,20($29)
     fa4:	afb00018 	sw	$16,24($29)
     fa8:	7a810000 	lq	$1,0($20)
     fac:	7a820010 	lq	$2,16($20)
     fb0:	00000000 	nop
     fb4:	7020203d 	pextw	$4,$1,0x0
     fb8:	7020f07d 	pextw	$30,$1,0x1
     fbc:	702088bd 	pextw	$17,$1,0x2
     fc0:	702080fd 	pextw	$16,$1,0x3
     fc4:	7040b83d 	pextw	$23,$2,0x0
     fc8:	7040b07d 	pextw	$22,$2,0x1
     fcc:	7040a8bd 	pextw	$21,$2,0x2
     fd0:	704098fd 	pextw	$19,$2,0x3
     fd4:	0c000115 	jal	454 <mylib_display_hex>
     fd8:	2652ffff 	addiu	$18,$18,-1
     fdc:	0c000080 	jal	200 <output_buffer_put>
     fe0:	24040020 	li	$4,32
     fe4:	0c000115 	jal	454 <mylib_display_hex>
     fe8:	03c02021 	move	$4,$30
     fec:	0c000080 	jal	200 <output_buffer_put>
     ff0:	24040020 	li	$4,32
     ff4:	0c000115 	jal	454 <mylib_display_hex>
     ff8:	02202021 	move	$4,$17
     ffc:	0c000080 	jal	200 <output_buffer_put>
    1000:	24040020 	li	$4,32
    1004:	0c000115 	jal	454 <mylib_display_hex>
    1008:	02002021 	move	$4,$16
    100c:	0c000080 	jal	200 <output_buffer_put>
    1010:	24040020 	li	$4,32
    1014:	0c000115 	jal	454 <mylib_display_hex>
    1018:	02e02021 	move	$4,$23
    101c:	0c000080 	jal	200 <output_buffer_put>
    1020:	24040020 	li	$4,32
    1024:	0c000115 	jal	454 <mylib_display_hex>
    1028:	02c02021 	move	$4,$22
    102c:	0c000080 	jal	200 <output_buffer_put>
    1030:	24040020 	li	$4,32
    1034:	0c000115 	jal	454 <mylib_display_hex>
    1038:	02a02021 	move	$4,$21
    103c:	0c000080 	jal	200 <output_buffer_put>
    1040:	24040020 	li	$4,32
    1044:	0c000115 	jal	454 <mylib_display_hex>
    1048:	02602021 	move	$4,$19
    104c:	0c000080 	jal	200 <output_buffer_put>
    1050:	24040020 	li	$4,32
    1054:	0c000080 	jal	200 <output_buffer_put>
    1058:	2404000a 	li	$4,10
    105c:	0c000080 	jal	200 <output_buffer_put>
    1060:	2404000d 	li	$4,13
    1064:	8fa20010 	lw	$2,16($29)
    1068:	1640ffcf 	bnez	$18,fa8 <main+0x8fc>
    106c:	0282a021 	addu	$20,$20,$2
    1070:	8fb10014 	lw	$17,20($29)
    1074:	8fb00018 	lw	$16,24($29)
    1078:	1a200038 	blez	$17,115c <main+0xab0>
    107c:	00003821 	move	$7,$0
    1080:	00003021 	move	$6,$0
    1084:	00002021 	move	$4,$0
    1088:	00404021 	move	$8,$2
    108c:	00e01821 	move	$3,$7
    1090:	00001021 	move	$2,$0
    1094:	02032821 	addu	$5,$16,$3
    1098:	8ca50000 	lw	$5,0($5)
    109c:	24420001 	addiu	$2,$2,1
    10a0:	24630004 	addiu	$3,$3,4
    10a4:	1451fffb 	bne	$2,$17,1094 <main+0x9e8>
    10a8:	00852021 	addu	$4,$4,$5
    10ac:	24c60001 	addiu	$6,$6,1
    10b0:	14d1fff6 	bne	$6,$17,108c <main+0x9e0>
    10b4:	00e83821 	addu	$7,$7,$8
    10b8:	0c000115 	jal	454 <mylib_display_hex>
    10bc:	00000000 	nop
    10c0:	0c000080 	jal	200 <output_buffer_put>
    10c4:	2404000a 	li	$4,10
    10c8:	0c000080 	jal	200 <output_buffer_put>
    10cc:	2404000d 	li	$4,13
    10d0:	0c00018a 	jal	628 <mylib_finalize>
    10d4:	00000000 	nop
    10d8:	8fbf005c 	lw	$31,92($29)
    10dc:	8fbe0058 	lw	$30,88($29)
    10e0:	8fb70054 	lw	$23,84($29)
    10e4:	8fb60050 	lw	$22,80($29)
    10e8:	8fb5004c 	lw	$21,76($29)
    10ec:	8fb40048 	lw	$20,72($29)
    10f0:	8fb30044 	lw	$19,68($29)
    10f4:	8fb20040 	lw	$18,64($29)
    10f8:	8fb1003c 	lw	$17,60($29)
    10fc:	8fb00038 	lw	$16,56($29)
    1100:	00001021 	move	$2,$0
    1104:	03e00008 	jr	$31
    1108:	27bd0060 	addiu	$29,$29,96
    110c:	8fa40014 	lw	$4,20($29)
    1110:	24020004 	li	$2,4
    1114:	240b0004 	li	$11,4
    1118:	0093c021 	addu	$24,$4,$19
    111c:	08000388 	j	e20 <main+0x774>
    1120:	02b1f021 	addu	$30,$21,$17
    1124:	8fa20014 	lw	$2,20($29)
    1128:	02b1f021 	addu	$30,$21,$17
    112c:	0262f821 	addu	$31,$19,$2
    1130:	080002b2 	j	ac8 <main+0x41c>
    1134:	24020004 	li	$2,4
    1138:	8fa40034 	lw	$4,52($29)
    113c:	00000000 	nop
    1140:	01c41021 	addu	$2,$14,$4
    1144:	3c040999 	lui	$4,0x999
    1148:	34849999 	ori	$4,$4,0x9999
    114c:	080003d4 	j	f50 <main+0x8a4>
    1150:	ac440000 	sw	$4,0($2)
    1154:	08000206 	j	818 <main+0x16c>
    1158:	26100420 	addiu	$16,$16,1056
    115c:	0800042e 	j	10b8 <main+0xa0c>
    1160:	00002021 	move	$4,$0
