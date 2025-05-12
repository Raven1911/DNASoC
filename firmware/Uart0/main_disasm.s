
main.elf:     file format elf32-littleriscv


Disassembly of section .text:

01000000 <main>:
 1000000:	fd010113          	addi	sp,sp,-48
 1000004:	02112623          	sw	ra,44(sp)
 1000008:	02812423          	sw	s0,40(sp)
 100000c:	03010413          	addi	s0,sp,48
 1000010:	fdc40793          	addi	a5,s0,-36
 1000014:	020025b7          	lui	a1,0x2002
 1000018:	00078513          	mv	a0,a5
 100001c:	4b1000ef          	jal	1000ccc <_ZN4UartC1Em>
 1000020:	fc042c23          	sw	zero,-40(s0)
 1000024:	fc042a23          	sw	zero,-44(s0)
 1000028:	fdc40793          	addi	a5,s0,-36
 100002c:	00078513          	mv	a0,a5
 1000030:	0c0000ef          	jal	10000f0 <_Z17init_trans_receivR4Uart>
 1000034:	fdc40793          	addi	a5,s0,-36
 1000038:	00200693          	li	a3,2
 100003c:	00100613          	li	a2,1
 1000040:	00200593          	li	a1,2
 1000044:	00078513          	mv	a0,a5
 1000048:	0e8000ef          	jal	1000130 <_Z8DNA_initR4Uarthhh>
 100004c:	00050793          	mv	a5,a0
 1000050:	fef42623          	sw	a5,-20(s0)
 1000054:	fe042423          	sw	zero,-24(s0)
 1000058:	fe042223          	sw	zero,-28(s0)
 100005c:	fe042023          	sw	zero,-32(s0)
 1000060:	00100613          	li	a2,1
 1000064:	00000593          	li	a1,0
 1000068:	02004537          	lui	a0,0x2004
 100006c:	2c0000ef          	jal	100032c <_Z13write_axi_regmmm>
 1000070:	00000613          	li	a2,0
 1000074:	00000593          	li	a1,0
 1000078:	02004537          	lui	a0,0x2004
 100007c:	2b0000ef          	jal	100032c <_Z13write_axi_regmmm>
 1000080:	00200593          	li	a1,2
 1000084:	02004537          	lui	a0,0x2004
 1000088:	25c000ef          	jal	10002e4 <_Z12read_axi_regmm>
 100008c:	fea42423          	sw	a0,-24(s0)
 1000090:	fe842783          	lw	a5,-24(s0)
 1000094:	0017d793          	srli	a5,a5,0x1
 1000098:	0017f793          	andi	a5,a5,1
 100009c:	fef42023          	sw	a5,-32(s0)
 10000a0:	fe842783          	lw	a5,-24(s0)
 10000a4:	0027d793          	srli	a5,a5,0x2
 10000a8:	0017f793          	andi	a5,a5,1
 10000ac:	fef42223          	sw	a5,-28(s0)
 10000b0:	fe442703          	lw	a4,-28(s0)
 10000b4:	00100793          	li	a5,1
 10000b8:	02f71063          	bne	a4,a5,10000d8 <main+0xd8>
 10000bc:	fd440693          	addi	a3,s0,-44
 10000c0:	fd840713          	addi	a4,s0,-40
 10000c4:	fdc40793          	addi	a5,s0,-36
 10000c8:	00070613          	mv	a2,a4
 10000cc:	fec42583          	lw	a1,-20(s0)
 10000d0:	00078513          	mv	a0,a5
 10000d4:	7cc000ef          	jal	10008a0 <_Z30receive_and_send_output_matrixR4UartmPmS1_>
 10000d8:	00000793          	li	a5,0
 10000dc:	00078513          	mv	a0,a5
 10000e0:	02c12083          	lw	ra,44(sp)
 10000e4:	02812403          	lw	s0,40(sp)
 10000e8:	03010113          	addi	sp,sp,48
 10000ec:	00008067          	ret

010000f0 <_Z17init_trans_receivR4Uart>:
 10000f0:	fe010113          	addi	sp,sp,-32
 10000f4:	00112e23          	sw	ra,28(sp)
 10000f8:	00812c23          	sw	s0,24(sp)
 10000fc:	02010413          	addi	s0,sp,32
 1000100:	fea42623          	sw	a0,-20(s0)
 1000104:	000027b7          	lui	a5,0x2
 1000108:	58078613          	addi	a2,a5,1408 # 2580 <_ebss+0x2580>
 100010c:	047877b7          	lui	a5,0x4787
 1000110:	8c078593          	addi	a1,a5,-1856 # 47868c0 <_etext+0x3785918>
 1000114:	fec42503          	lw	a0,-20(s0)
 1000118:	47d000ef          	jal	1000d94 <_ZN4Uart4initEmm>
 100011c:	00000013          	nop
 1000120:	01c12083          	lw	ra,28(sp)
 1000124:	01812403          	lw	s0,24(sp)
 1000128:	02010113          	addi	sp,sp,32
 100012c:	00008067          	ret

01000130 <_Z8DNA_initR4Uarthhh>:
 1000130:	fc010113          	addi	sp,sp,-64
 1000134:	02112e23          	sw	ra,60(sp)
 1000138:	02812c23          	sw	s0,56(sp)
 100013c:	04010413          	addi	s0,sp,64
 1000140:	fca42623          	sw	a0,-52(s0)
 1000144:	00058793          	mv	a5,a1
 1000148:	00068713          	mv	a4,a3
 100014c:	fcf405a3          	sb	a5,-53(s0)
 1000150:	00060793          	mv	a5,a2
 1000154:	fcf40523          	sb	a5,-54(s0)
 1000158:	00070793          	mv	a5,a4
 100015c:	fcf404a3          	sb	a5,-55(s0)
 1000160:	fc042c23          	sw	zero,-40(s0)
 1000164:	0100006f          	j	1000174 <_Z8DNA_initR4Uarthhh+0x44>
 1000168:	fd842783          	lw	a5,-40(s0)
 100016c:	00178793          	addi	a5,a5,1
 1000170:	fcf42c23          	sw	a5,-40(s0)
 1000174:	fd842703          	lw	a4,-40(s0)
 1000178:	000107b7          	lui	a5,0x10
 100017c:	fff78793          	addi	a5,a5,-1 # ffff <_ebss+0xffff>
 1000180:	00f727b3          	slt	a5,a4,a5
 1000184:	0ff7f793          	zext.b	a5,a5
 1000188:	fe0790e3          	bnez	a5,1000168 <_Z8DNA_initR4Uarthhh+0x38>
 100018c:	01000593          	li	a1,16
 1000190:	fcc42503          	lw	a0,-52(s0)
 1000194:	461000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 1000198:	00000613          	li	a2,0
 100019c:	00000593          	li	a1,0
 10001a0:	02004537          	lui	a0,0x2004
 10001a4:	188000ef          	jal	100032c <_Z13write_axi_regmmm>
 10001a8:	fcc42503          	lw	a0,-52(s0)
 10001ac:	64c000ef          	jal	10007f8 <_Z27receive_and_store_read_dataR4Uart>
 10001b0:	00050793          	mv	a5,a0
 10001b4:	fef42223          	sw	a5,-28(s0)
 10001b8:	fcc42503          	lw	a0,-52(s0)
 10001bc:	594000ef          	jal	1000750 <_Z26receive_and_store_ref_dataR4Uart>
 10001c0:	00050793          	mv	a5,a0
 10001c4:	fef42023          	sw	a5,-32(s0)
 10001c8:	fc042e23          	sw	zero,-36(s0)
 10001cc:	fe442783          	lw	a5,-28(s0)
 10001d0:	fef42623          	sw	a5,-20(s0)
 10001d4:	fec42783          	lw	a5,-20(s0)
 10001d8:	00078863          	beqz	a5,10001e8 <_Z8DNA_initR4Uarthhh+0xb8>
 10001dc:	fec42703          	lw	a4,-20(s0)
 10001e0:	00100793          	li	a5,1
 10001e4:	00f71663          	bne	a4,a5,10001f0 <_Z8DNA_initR4Uarthhh+0xc0>
 10001e8:	fe042623          	sw	zero,-20(s0)
 10001ec:	0380006f          	j	1000224 <_Z8DNA_initR4Uarthhh+0xf4>
 10001f0:	fe042423          	sw	zero,-24(s0)
 10001f4:	01c0006f          	j	1000210 <_Z8DNA_initR4Uarthhh+0xe0>
 10001f8:	fec42783          	lw	a5,-20(s0)
 10001fc:	0017d793          	srli	a5,a5,0x1
 1000200:	fef42623          	sw	a5,-20(s0)
 1000204:	fe842783          	lw	a5,-24(s0)
 1000208:	00178793          	addi	a5,a5,1
 100020c:	fef42423          	sw	a5,-24(s0)
 1000210:	fec42703          	lw	a4,-20(s0)
 1000214:	00100793          	li	a5,1
 1000218:	fee7e0e3          	bltu	a5,a4,10001f8 <_Z8DNA_initR4Uarthhh+0xc8>
 100021c:	fe842783          	lw	a5,-24(s0)
 1000220:	fef42623          	sw	a5,-20(s0)
 1000224:	fec42783          	lw	a5,-20(s0)
 1000228:	07f7f793          	andi	a5,a5,127
 100022c:	fdc42703          	lw	a4,-36(s0)
 1000230:	00f767b3          	or	a5,a4,a5
 1000234:	fcf42e23          	sw	a5,-36(s0)
 1000238:	fcb44783          	lbu	a5,-53(s0)
 100023c:	00779793          	slli	a5,a5,0x7
 1000240:	3807f793          	andi	a5,a5,896
 1000244:	fdc42703          	lw	a4,-36(s0)
 1000248:	00f767b3          	or	a5,a4,a5
 100024c:	fcf42e23          	sw	a5,-36(s0)
 1000250:	fca44783          	lbu	a5,-54(s0)
 1000254:	00a79713          	slli	a4,a5,0xa
 1000258:	000027b7          	lui	a5,0x2
 100025c:	c0078793          	addi	a5,a5,-1024 # 1c00 <_ebss+0x1c00>
 1000260:	00f777b3          	and	a5,a4,a5
 1000264:	fdc42703          	lw	a4,-36(s0)
 1000268:	00f767b3          	or	a5,a4,a5
 100026c:	fcf42e23          	sw	a5,-36(s0)
 1000270:	fc944783          	lbu	a5,-55(s0)
 1000274:	00d79793          	slli	a5,a5,0xd
 1000278:	01079793          	slli	a5,a5,0x10
 100027c:	0107d793          	srli	a5,a5,0x10
 1000280:	fdc42703          	lw	a4,-36(s0)
 1000284:	00f767b3          	or	a5,a4,a5
 1000288:	fcf42e23          	sw	a5,-36(s0)
 100028c:	fdc42603          	lw	a2,-36(s0)
 1000290:	00100593          	li	a1,1
 1000294:	02004537          	lui	a0,0x2004
 1000298:	094000ef          	jal	100032c <_Z13write_axi_regmmm>
 100029c:	00000613          	li	a2,0
 10002a0:	fe042583          	lw	a1,-32(s0)
 10002a4:	40000513          	li	a0,1024
 10002a8:	7d4000ef          	jal	1000a7c <_Z14mem_write_wordmmm>
 10002ac:	00200613          	li	a2,2
 10002b0:	00000593          	li	a1,0
 10002b4:	02004537          	lui	a0,0x2004
 10002b8:	074000ef          	jal	100032c <_Z13write_axi_regmmm>
 10002bc:	00000613          	li	a2,0
 10002c0:	00000593          	li	a1,0
 10002c4:	02004537          	lui	a0,0x2004
 10002c8:	064000ef          	jal	100032c <_Z13write_axi_regmmm>
 10002cc:	fec42783          	lw	a5,-20(s0)
 10002d0:	00078513          	mv	a0,a5
 10002d4:	03c12083          	lw	ra,60(sp)
 10002d8:	03812403          	lw	s0,56(sp)
 10002dc:	04010113          	addi	sp,sp,64
 10002e0:	00008067          	ret

010002e4 <_Z12read_axi_regmm>:
 10002e4:	fd010113          	addi	sp,sp,-48
 10002e8:	02112623          	sw	ra,44(sp)
 10002ec:	02812423          	sw	s0,40(sp)
 10002f0:	03010413          	addi	s0,sp,48
 10002f4:	fca42e23          	sw	a0,-36(s0)
 10002f8:	fcb42c23          	sw	a1,-40(s0)
 10002fc:	fdc42783          	lw	a5,-36(s0)
 1000300:	fef42623          	sw	a5,-20(s0)
 1000304:	fd842783          	lw	a5,-40(s0)
 1000308:	00279793          	slli	a5,a5,0x2
 100030c:	fec42703          	lw	a4,-20(s0)
 1000310:	00f707b3          	add	a5,a4,a5
 1000314:	0007a783          	lw	a5,0(a5)
 1000318:	00078513          	mv	a0,a5
 100031c:	02c12083          	lw	ra,44(sp)
 1000320:	02812403          	lw	s0,40(sp)
 1000324:	03010113          	addi	sp,sp,48
 1000328:	00008067          	ret

0100032c <_Z13write_axi_regmmm>:
 100032c:	fd010113          	addi	sp,sp,-48
 1000330:	02112623          	sw	ra,44(sp)
 1000334:	02812423          	sw	s0,40(sp)
 1000338:	03010413          	addi	s0,sp,48
 100033c:	fca42e23          	sw	a0,-36(s0)
 1000340:	fcb42c23          	sw	a1,-40(s0)
 1000344:	fcc42a23          	sw	a2,-44(s0)
 1000348:	fdc42783          	lw	a5,-36(s0)
 100034c:	fef42623          	sw	a5,-20(s0)
 1000350:	fd842783          	lw	a5,-40(s0)
 1000354:	00279793          	slli	a5,a5,0x2
 1000358:	fec42703          	lw	a4,-20(s0)
 100035c:	00f707b3          	add	a5,a4,a5
 1000360:	fd442703          	lw	a4,-44(s0)
 1000364:	00e7a023          	sw	a4,0(a5)
 1000368:	00000013          	nop
 100036c:	02c12083          	lw	ra,44(sp)
 1000370:	02812403          	lw	s0,40(sp)
 1000374:	03010113          	addi	sp,sp,48
 1000378:	00008067          	ret

0100037c <_Z9send_wordR4Uartm>:
 100037c:	fd010113          	addi	sp,sp,-48
 1000380:	02112623          	sw	ra,44(sp)
 1000384:	02812423          	sw	s0,40(sp)
 1000388:	03010413          	addi	s0,sp,48
 100038c:	fca42e23          	sw	a0,-36(s0)
 1000390:	fcb42c23          	sw	a1,-40(s0)
 1000394:	fe042623          	sw	zero,-20(s0)
 1000398:	0100006f          	j	10003a8 <_Z9send_wordR4Uartm+0x2c>
 100039c:	fec42783          	lw	a5,-20(s0)
 10003a0:	00178793          	addi	a5,a5,1
 10003a4:	fef42623          	sw	a5,-20(s0)
 10003a8:	fec42703          	lw	a4,-20(s0)
 10003ac:	000107b7          	lui	a5,0x10
 10003b0:	fff78793          	addi	a5,a5,-1 # ffff <_ebss+0xffff>
 10003b4:	00f727b3          	slt	a5,a4,a5
 10003b8:	0ff7f793          	zext.b	a5,a5
 10003bc:	fe0790e3          	bnez	a5,100039c <_Z9send_wordR4Uartm+0x20>
 10003c0:	fd842783          	lw	a5,-40(s0)
 10003c4:	0ff7f793          	zext.b	a5,a5
 10003c8:	00078593          	mv	a1,a5
 10003cc:	fdc42503          	lw	a0,-36(s0)
 10003d0:	225000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 10003d4:	fd842783          	lw	a5,-40(s0)
 10003d8:	0087d793          	srli	a5,a5,0x8
 10003dc:	0ff7f793          	zext.b	a5,a5
 10003e0:	00078593          	mv	a1,a5
 10003e4:	fdc42503          	lw	a0,-36(s0)
 10003e8:	20d000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 10003ec:	fd842783          	lw	a5,-40(s0)
 10003f0:	0107d793          	srli	a5,a5,0x10
 10003f4:	0ff7f793          	zext.b	a5,a5
 10003f8:	00078593          	mv	a1,a5
 10003fc:	fdc42503          	lw	a0,-36(s0)
 1000400:	1f5000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 1000404:	fd842783          	lw	a5,-40(s0)
 1000408:	0187d793          	srli	a5,a5,0x18
 100040c:	0ff7f793          	zext.b	a5,a5
 1000410:	00078593          	mv	a1,a5
 1000414:	fdc42503          	lw	a0,-36(s0)
 1000418:	1dd000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 100041c:	00000013          	nop
 1000420:	02c12083          	lw	ra,44(sp)
 1000424:	02812403          	lw	s0,40(sp)
 1000428:	03010113          	addi	sp,sp,48
 100042c:	00008067          	ret

01000430 <_Z9checkreadR4Uart>:
 1000430:	fd010113          	addi	sp,sp,-48
 1000434:	02112623          	sw	ra,44(sp)
 1000438:	02812423          	sw	s0,40(sp)
 100043c:	03010413          	addi	s0,sp,48
 1000440:	fca42e23          	sw	a0,-36(s0)
 1000444:	fe042023          	sw	zero,-32(s0)
 1000448:	0100006f          	j	1000458 <_Z9checkreadR4Uart+0x28>
 100044c:	fe042783          	lw	a5,-32(s0)
 1000450:	00178793          	addi	a5,a5,1
 1000454:	fef42023          	sw	a5,-32(s0)
 1000458:	fe042703          	lw	a4,-32(s0)
 100045c:	000027b7          	lui	a5,0x2
 1000460:	71078793          	addi	a5,a5,1808 # 2710 <_ebss+0x2710>
 1000464:	00f727b3          	slt	a5,a4,a5
 1000468:	0ff7f793          	zext.b	a5,a5
 100046c:	fe0790e3          	bnez	a5,100044c <_Z9checkreadR4Uart+0x1c>
 1000470:	02b00593          	li	a1,43
 1000474:	fdc42503          	lw	a0,-36(s0)
 1000478:	17d000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 100047c:	fe042623          	sw	zero,-20(s0)
 1000480:	fe042423          	sw	zero,-24(s0)
 1000484:	0500006f          	j	10004d4 <_Z9checkreadR4Uart+0xa4>
 1000488:	fdc42503          	lw	a0,-36(s0)
 100048c:	1d1000ef          	jal	1000e5c <_ZN4Uart4readEv>
 1000490:	00050793          	mv	a5,a0
 1000494:	fef41323          	sh	a5,-26(s0)
 1000498:	fe641703          	lh	a4,-26(s0)
 100049c:	fff00793          	li	a5,-1
 10004a0:	fef704e3          	beq	a4,a5,1000488 <_Z9checkreadR4Uart+0x58>
 10004a4:	fe645783          	lhu	a5,-26(s0)
 10004a8:	0ff7f713          	zext.b	a4,a5
 10004ac:	fe842783          	lw	a5,-24(s0)
 10004b0:	00379793          	slli	a5,a5,0x3
 10004b4:	00f717b3          	sll	a5,a4,a5
 10004b8:	00078713          	mv	a4,a5
 10004bc:	fec42783          	lw	a5,-20(s0)
 10004c0:	00e7e7b3          	or	a5,a5,a4
 10004c4:	fef42623          	sw	a5,-20(s0)
 10004c8:	fe842783          	lw	a5,-24(s0)
 10004cc:	00178793          	addi	a5,a5,1
 10004d0:	fef42423          	sw	a5,-24(s0)
 10004d4:	fe842703          	lw	a4,-24(s0)
 10004d8:	00300793          	li	a5,3
 10004dc:	fae7d6e3          	bge	a5,a4,1000488 <_Z9checkreadR4Uart+0x58>
 10004e0:	fec42783          	lw	a5,-20(s0)
 10004e4:	00078513          	mv	a0,a5
 10004e8:	02c12083          	lw	ra,44(sp)
 10004ec:	02812403          	lw	s0,40(sp)
 10004f0:	03010113          	addi	sp,sp,48
 10004f4:	00008067          	ret

010004f8 <_Z8checkrefR4Uart>:
 10004f8:	fd010113          	addi	sp,sp,-48
 10004fc:	02112623          	sw	ra,44(sp)
 1000500:	02812423          	sw	s0,40(sp)
 1000504:	03010413          	addi	s0,sp,48
 1000508:	fca42e23          	sw	a0,-36(s0)
 100050c:	fe042023          	sw	zero,-32(s0)
 1000510:	0100006f          	j	1000520 <_Z8checkrefR4Uart+0x28>
 1000514:	fe042783          	lw	a5,-32(s0)
 1000518:	00178793          	addi	a5,a5,1
 100051c:	fef42023          	sw	a5,-32(s0)
 1000520:	fe042703          	lw	a4,-32(s0)
 1000524:	000027b7          	lui	a5,0x2
 1000528:	71078793          	addi	a5,a5,1808 # 2710 <_ebss+0x2710>
 100052c:	00f727b3          	slt	a5,a4,a5
 1000530:	0ff7f793          	zext.b	a5,a5
 1000534:	fe0790e3          	bnez	a5,1000514 <_Z8checkrefR4Uart+0x1c>
 1000538:	02a00593          	li	a1,42
 100053c:	fdc42503          	lw	a0,-36(s0)
 1000540:	0b5000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 1000544:	fe042623          	sw	zero,-20(s0)
 1000548:	fe042423          	sw	zero,-24(s0)
 100054c:	0500006f          	j	100059c <_Z8checkrefR4Uart+0xa4>
 1000550:	fdc42503          	lw	a0,-36(s0)
 1000554:	109000ef          	jal	1000e5c <_ZN4Uart4readEv>
 1000558:	00050793          	mv	a5,a0
 100055c:	fef41323          	sh	a5,-26(s0)
 1000560:	fe641703          	lh	a4,-26(s0)
 1000564:	fff00793          	li	a5,-1
 1000568:	fef704e3          	beq	a4,a5,1000550 <_Z8checkrefR4Uart+0x58>
 100056c:	fe645783          	lhu	a5,-26(s0)
 1000570:	0ff7f713          	zext.b	a4,a5
 1000574:	fe842783          	lw	a5,-24(s0)
 1000578:	00379793          	slli	a5,a5,0x3
 100057c:	00f717b3          	sll	a5,a4,a5
 1000580:	00078713          	mv	a4,a5
 1000584:	fec42783          	lw	a5,-20(s0)
 1000588:	00e7e7b3          	or	a5,a5,a4
 100058c:	fef42623          	sw	a5,-20(s0)
 1000590:	fe842783          	lw	a5,-24(s0)
 1000594:	00178793          	addi	a5,a5,1
 1000598:	fef42423          	sw	a5,-24(s0)
 100059c:	fe842703          	lw	a4,-24(s0)
 10005a0:	00300793          	li	a5,3
 10005a4:	fae7d6e3          	bge	a5,a4,1000550 <_Z8checkrefR4Uart+0x58>
 10005a8:	fec42783          	lw	a5,-20(s0)
 10005ac:	00078513          	mv	a0,a5
 10005b0:	02c12083          	lw	ra,44(sp)
 10005b4:	02812403          	lw	s0,40(sp)
 10005b8:	03010113          	addi	sp,sp,48
 10005bc:	00008067          	ret

010005c0 <_Z8readreadR4Uart>:
 10005c0:	fd010113          	addi	sp,sp,-48
 10005c4:	02112623          	sw	ra,44(sp)
 10005c8:	02812423          	sw	s0,40(sp)
 10005cc:	03010413          	addi	s0,sp,48
 10005d0:	fca42e23          	sw	a0,-36(s0)
 10005d4:	fe042023          	sw	zero,-32(s0)
 10005d8:	0100006f          	j	10005e8 <_Z8readreadR4Uart+0x28>
 10005dc:	fe042783          	lw	a5,-32(s0)
 10005e0:	00178793          	addi	a5,a5,1
 10005e4:	fef42023          	sw	a5,-32(s0)
 10005e8:	fe042703          	lw	a4,-32(s0)
 10005ec:	000027b7          	lui	a5,0x2
 10005f0:	71078793          	addi	a5,a5,1808 # 2710 <_ebss+0x2710>
 10005f4:	00f727b3          	slt	a5,a4,a5
 10005f8:	0ff7f793          	zext.b	a5,a5
 10005fc:	fe0790e3          	bnez	a5,10005dc <_Z8readreadR4Uart+0x1c>
 1000600:	02c00593          	li	a1,44
 1000604:	fdc42503          	lw	a0,-36(s0)
 1000608:	7ec000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 100060c:	fe042623          	sw	zero,-20(s0)
 1000610:	fe042423          	sw	zero,-24(s0)
 1000614:	0500006f          	j	1000664 <_Z8readreadR4Uart+0xa4>
 1000618:	fdc42503          	lw	a0,-36(s0)
 100061c:	041000ef          	jal	1000e5c <_ZN4Uart4readEv>
 1000620:	00050793          	mv	a5,a0
 1000624:	fef41323          	sh	a5,-26(s0)
 1000628:	fe641703          	lh	a4,-26(s0)
 100062c:	fff00793          	li	a5,-1
 1000630:	fef704e3          	beq	a4,a5,1000618 <_Z8readreadR4Uart+0x58>
 1000634:	fe645783          	lhu	a5,-26(s0)
 1000638:	0ff7f713          	zext.b	a4,a5
 100063c:	fe842783          	lw	a5,-24(s0)
 1000640:	00379793          	slli	a5,a5,0x3
 1000644:	00f717b3          	sll	a5,a4,a5
 1000648:	00078713          	mv	a4,a5
 100064c:	fec42783          	lw	a5,-20(s0)
 1000650:	00e7e7b3          	or	a5,a5,a4
 1000654:	fef42623          	sw	a5,-20(s0)
 1000658:	fe842783          	lw	a5,-24(s0)
 100065c:	00178793          	addi	a5,a5,1
 1000660:	fef42423          	sw	a5,-24(s0)
 1000664:	fe842703          	lw	a4,-24(s0)
 1000668:	00300793          	li	a5,3
 100066c:	fae7d6e3          	bge	a5,a4,1000618 <_Z8readreadR4Uart+0x58>
 1000670:	fec42783          	lw	a5,-20(s0)
 1000674:	00078513          	mv	a0,a5
 1000678:	02c12083          	lw	ra,44(sp)
 100067c:	02812403          	lw	s0,40(sp)
 1000680:	03010113          	addi	sp,sp,48
 1000684:	00008067          	ret

01000688 <_Z7readrefR4Uart>:
 1000688:	fd010113          	addi	sp,sp,-48
 100068c:	02112623          	sw	ra,44(sp)
 1000690:	02812423          	sw	s0,40(sp)
 1000694:	03010413          	addi	s0,sp,48
 1000698:	fca42e23          	sw	a0,-36(s0)
 100069c:	fe042023          	sw	zero,-32(s0)
 10006a0:	0100006f          	j	10006b0 <_Z7readrefR4Uart+0x28>
 10006a4:	fe042783          	lw	a5,-32(s0)
 10006a8:	00178793          	addi	a5,a5,1
 10006ac:	fef42023          	sw	a5,-32(s0)
 10006b0:	fe042703          	lw	a4,-32(s0)
 10006b4:	000027b7          	lui	a5,0x2
 10006b8:	71078793          	addi	a5,a5,1808 # 2710 <_ebss+0x2710>
 10006bc:	00f727b3          	slt	a5,a4,a5
 10006c0:	0ff7f793          	zext.b	a5,a5
 10006c4:	fe0790e3          	bnez	a5,10006a4 <_Z7readrefR4Uart+0x1c>
 10006c8:	02d00593          	li	a1,45
 10006cc:	fdc42503          	lw	a0,-36(s0)
 10006d0:	724000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 10006d4:	fe042623          	sw	zero,-20(s0)
 10006d8:	fe042423          	sw	zero,-24(s0)
 10006dc:	0500006f          	j	100072c <_Z7readrefR4Uart+0xa4>
 10006e0:	fdc42503          	lw	a0,-36(s0)
 10006e4:	778000ef          	jal	1000e5c <_ZN4Uart4readEv>
 10006e8:	00050793          	mv	a5,a0
 10006ec:	fef41323          	sh	a5,-26(s0)
 10006f0:	fe641703          	lh	a4,-26(s0)
 10006f4:	fff00793          	li	a5,-1
 10006f8:	fef704e3          	beq	a4,a5,10006e0 <_Z7readrefR4Uart+0x58>
 10006fc:	fe645783          	lhu	a5,-26(s0)
 1000700:	0ff7f713          	zext.b	a4,a5
 1000704:	fe842783          	lw	a5,-24(s0)
 1000708:	00379793          	slli	a5,a5,0x3
 100070c:	00f717b3          	sll	a5,a4,a5
 1000710:	00078713          	mv	a4,a5
 1000714:	fec42783          	lw	a5,-20(s0)
 1000718:	00e7e7b3          	or	a5,a5,a4
 100071c:	fef42623          	sw	a5,-20(s0)
 1000720:	fe842783          	lw	a5,-24(s0)
 1000724:	00178793          	addi	a5,a5,1
 1000728:	fef42423          	sw	a5,-24(s0)
 100072c:	fe842703          	lw	a4,-24(s0)
 1000730:	00300793          	li	a5,3
 1000734:	fae7d6e3          	bge	a5,a4,10006e0 <_Z7readrefR4Uart+0x58>
 1000738:	fec42783          	lw	a5,-20(s0)
 100073c:	00078513          	mv	a0,a5
 1000740:	02c12083          	lw	ra,44(sp)
 1000744:	02812403          	lw	s0,40(sp)
 1000748:	03010113          	addi	sp,sp,48
 100074c:	00008067          	ret

01000750 <_Z26receive_and_store_ref_dataR4Uart>:
 1000750:	fd010113          	addi	sp,sp,-48
 1000754:	02112623          	sw	ra,44(sp)
 1000758:	02812423          	sw	s0,40(sp)
 100075c:	03010413          	addi	s0,sp,48
 1000760:	fca42e23          	sw	a0,-36(s0)
 1000764:	fe042623          	sw	zero,-20(s0)
 1000768:	fdc42503          	lw	a0,-36(s0)
 100076c:	d8dff0ef          	jal	10004f8 <_Z8checkrefR4Uart>
 1000770:	00050793          	mv	a5,a0
 1000774:	fef42223          	sw	a5,-28(s0)
 1000778:	fe442783          	lw	a5,-28(s0)
 100077c:	00078863          	beqz	a5,100078c <_Z26receive_and_store_ref_dataR4Uart+0x3c>
 1000780:	fe442703          	lw	a4,-28(s0)
 1000784:	fff00793          	li	a5,-1
 1000788:	00f71663          	bne	a4,a5,1000794 <_Z26receive_and_store_ref_dataR4Uart+0x44>
 100078c:	00000793          	li	a5,0
 1000790:	0540006f          	j	10007e4 <_Z26receive_and_store_ref_dataR4Uart+0x94>
 1000794:	fe042423          	sw	zero,-24(s0)
 1000798:	03c0006f          	j	10007d4 <_Z26receive_and_store_ref_dataR4Uart+0x84>
 100079c:	fdc42503          	lw	a0,-36(s0)
 10007a0:	ee9ff0ef          	jal	1000688 <_Z7readrefR4Uart>
 10007a4:	00050793          	mv	a5,a0
 10007a8:	fef42023          	sw	a5,-32(s0)
 10007ac:	fe042603          	lw	a2,-32(s0)
 10007b0:	fec42583          	lw	a1,-20(s0)
 10007b4:	40000513          	li	a0,1024
 10007b8:	2c4000ef          	jal	1000a7c <_Z14mem_write_wordmmm>
 10007bc:	fec42783          	lw	a5,-20(s0)
 10007c0:	00178793          	addi	a5,a5,1
 10007c4:	fef42623          	sw	a5,-20(s0)
 10007c8:	fe842783          	lw	a5,-24(s0)
 10007cc:	00178793          	addi	a5,a5,1
 10007d0:	fef42423          	sw	a5,-24(s0)
 10007d4:	fe842783          	lw	a5,-24(s0)
 10007d8:	fe442703          	lw	a4,-28(s0)
 10007dc:	fce7e0e3          	bltu	a5,a4,100079c <_Z26receive_and_store_ref_dataR4Uart+0x4c>
 10007e0:	fe442783          	lw	a5,-28(s0)
 10007e4:	00078513          	mv	a0,a5
 10007e8:	02c12083          	lw	ra,44(sp)
 10007ec:	02812403          	lw	s0,40(sp)
 10007f0:	03010113          	addi	sp,sp,48
 10007f4:	00008067          	ret

010007f8 <_Z27receive_and_store_read_dataR4Uart>:
 10007f8:	fd010113          	addi	sp,sp,-48
 10007fc:	02112623          	sw	ra,44(sp)
 1000800:	02812423          	sw	s0,40(sp)
 1000804:	03010413          	addi	s0,sp,48
 1000808:	fca42e23          	sw	a0,-36(s0)
 100080c:	fe042623          	sw	zero,-20(s0)
 1000810:	fdc42503          	lw	a0,-36(s0)
 1000814:	c1dff0ef          	jal	1000430 <_Z9checkreadR4Uart>
 1000818:	00050793          	mv	a5,a0
 100081c:	fef42223          	sw	a5,-28(s0)
 1000820:	fe442783          	lw	a5,-28(s0)
 1000824:	00078863          	beqz	a5,1000834 <_Z27receive_and_store_read_dataR4Uart+0x3c>
 1000828:	fe442703          	lw	a4,-28(s0)
 100082c:	fff00793          	li	a5,-1
 1000830:	00f71663          	bne	a4,a5,100083c <_Z27receive_and_store_read_dataR4Uart+0x44>
 1000834:	00000793          	li	a5,0
 1000838:	0540006f          	j	100088c <_Z27receive_and_store_read_dataR4Uart+0x94>
 100083c:	fe042423          	sw	zero,-24(s0)
 1000840:	03c0006f          	j	100087c <_Z27receive_and_store_read_dataR4Uart+0x84>
 1000844:	fdc42503          	lw	a0,-36(s0)
 1000848:	d79ff0ef          	jal	10005c0 <_Z8readreadR4Uart>
 100084c:	00050793          	mv	a5,a0
 1000850:	fef42023          	sw	a5,-32(s0)
 1000854:	fe042603          	lw	a2,-32(s0)
 1000858:	fec42583          	lw	a1,-20(s0)
 100085c:	00000513          	li	a0,0
 1000860:	21c000ef          	jal	1000a7c <_Z14mem_write_wordmmm>
 1000864:	fec42783          	lw	a5,-20(s0)
 1000868:	00178793          	addi	a5,a5,1
 100086c:	fef42623          	sw	a5,-20(s0)
 1000870:	fe842783          	lw	a5,-24(s0)
 1000874:	00178793          	addi	a5,a5,1
 1000878:	fef42423          	sw	a5,-24(s0)
 100087c:	fe842783          	lw	a5,-24(s0)
 1000880:	fe442703          	lw	a4,-28(s0)
 1000884:	fce7e0e3          	bltu	a5,a4,1000844 <_Z27receive_and_store_read_dataR4Uart+0x4c>
 1000888:	fe442783          	lw	a5,-28(s0)
 100088c:	00078513          	mv	a0,a5
 1000890:	02c12083          	lw	ra,44(sp)
 1000894:	02812403          	lw	s0,40(sp)
 1000898:	03010113          	addi	sp,sp,48
 100089c:	00008067          	ret

010008a0 <_Z30receive_and_send_output_matrixR4UartmPmS1_>:
 10008a0:	fc010113          	addi	sp,sp,-64
 10008a4:	02112e23          	sw	ra,60(sp)
 10008a8:	02812c23          	sw	s0,56(sp)
 10008ac:	04010413          	addi	s0,sp,64
 10008b0:	fca42623          	sw	a0,-52(s0)
 10008b4:	fcb42423          	sw	a1,-56(s0)
 10008b8:	fcc42223          	sw	a2,-60(s0)
 10008bc:	fcd42023          	sw	a3,-64(s0)
 10008c0:	00100793          	li	a5,1
 10008c4:	fef42623          	sw	a5,-20(s0)
 10008c8:	fe042423          	sw	zero,-24(s0)
 10008cc:	01c0006f          	j	10008e8 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x48>
 10008d0:	fec42783          	lw	a5,-20(s0)
 10008d4:	00179793          	slli	a5,a5,0x1
 10008d8:	fef42623          	sw	a5,-20(s0)
 10008dc:	fe842783          	lw	a5,-24(s0)
 10008e0:	00178793          	addi	a5,a5,1
 10008e4:	fef42423          	sw	a5,-24(s0)
 10008e8:	fe842703          	lw	a4,-24(s0)
 10008ec:	fc842783          	lw	a5,-56(s0)
 10008f0:	fef760e3          	bltu	a4,a5,10008d0 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x30>
 10008f4:	fec42783          	lw	a5,-20(s0)
 10008f8:	00479793          	slli	a5,a5,0x4
 10008fc:	fcf42423          	sw	a5,-56(s0)
 1000900:	fe042223          	sw	zero,-28(s0)
 1000904:	1040006f          	j	1000a08 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x168>
 1000908:	fc042a23          	sw	zero,-44(s0)
 100090c:	0100006f          	j	100091c <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x7c>
 1000910:	fd442783          	lw	a5,-44(s0)
 1000914:	00178793          	addi	a5,a5,1
 1000918:	fcf42a23          	sw	a5,-44(s0)
 100091c:	fd442703          	lw	a4,-44(s0)
 1000920:	000187b7          	lui	a5,0x18
 1000924:	6a078793          	addi	a5,a5,1696 # 186a0 <_ebss+0x186a0>
 1000928:	00f727b3          	slt	a5,a4,a5
 100092c:	0ff7f793          	zext.b	a5,a5
 1000930:	fe0790e3          	bnez	a5,1000910 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x70>
 1000934:	02e00593          	li	a1,46
 1000938:	fcc42503          	lw	a0,-52(s0)
 100093c:	4b8000ef          	jal	1000df4 <_ZN4Uart5writeEh>
 1000940:	fc442783          	lw	a5,-60(s0)
 1000944:	0007a783          	lw	a5,0(a5)
 1000948:	00078593          	mv	a1,a5
 100094c:	fcc42503          	lw	a0,-52(s0)
 1000950:	a2dff0ef          	jal	100037c <_Z9send_wordR4Uartm>
 1000954:	fc042783          	lw	a5,-64(s0)
 1000958:	0007a783          	lw	a5,0(a5)
 100095c:	00078593          	mv	a1,a5
 1000960:	fcc42503          	lw	a0,-52(s0)
 1000964:	a19ff0ef          	jal	100037c <_Z9send_wordR4Uartm>
 1000968:	fe042023          	sw	zero,-32(s0)
 100096c:	0400006f          	j	10009ac <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x10c>
 1000970:	fe042783          	lw	a5,-32(s0)
 1000974:	00178793          	addi	a5,a5,1
 1000978:	00e79793          	slli	a5,a5,0xe
 100097c:	fcf42e23          	sw	a5,-36(s0)
 1000980:	fe442783          	lw	a5,-28(s0)
 1000984:	00078593          	mv	a1,a5
 1000988:	fdc42503          	lw	a0,-36(s0)
 100098c:	0a0000ef          	jal	1000a2c <_Z13mem_read_wordmm>
 1000990:	fca42c23          	sw	a0,-40(s0)
 1000994:	fd842583          	lw	a1,-40(s0)
 1000998:	fcc42503          	lw	a0,-52(s0)
 100099c:	9e1ff0ef          	jal	100037c <_Z9send_wordR4Uartm>
 10009a0:	fe042783          	lw	a5,-32(s0)
 10009a4:	00178793          	addi	a5,a5,1
 10009a8:	fef42023          	sw	a5,-32(s0)
 10009ac:	fe042703          	lw	a4,-32(s0)
 10009b0:	00f00793          	li	a5,15
 10009b4:	fae7dee3          	bge	a5,a4,1000970 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0xd0>
 10009b8:	fc042783          	lw	a5,-64(s0)
 10009bc:	0007a783          	lw	a5,0(a5)
 10009c0:	fc842703          	lw	a4,-56(s0)
 10009c4:	02f71263          	bne	a4,a5,10009e8 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x148>
 10009c8:	fc042783          	lw	a5,-64(s0)
 10009cc:	0007a023          	sw	zero,0(a5)
 10009d0:	fc442783          	lw	a5,-60(s0)
 10009d4:	0007a783          	lw	a5,0(a5)
 10009d8:	01078713          	addi	a4,a5,16
 10009dc:	fc442783          	lw	a5,-60(s0)
 10009e0:	00e7a023          	sw	a4,0(a5)
 10009e4:	0180006f          	j	10009fc <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x15c>
 10009e8:	fc042783          	lw	a5,-64(s0)
 10009ec:	0007a783          	lw	a5,0(a5)
 10009f0:	00178713          	addi	a4,a5,1
 10009f4:	fc042783          	lw	a5,-64(s0)
 10009f8:	00e7a023          	sw	a4,0(a5)
 10009fc:	fe442783          	lw	a5,-28(s0)
 1000a00:	00178793          	addi	a5,a5,1
 1000a04:	fef42223          	sw	a5,-28(s0)
 1000a08:	fe442703          	lw	a4,-28(s0)
 1000a0c:	07f00793          	li	a5,127
 1000a10:	eee7dce3          	bge	a5,a4,1000908 <_Z30receive_and_send_output_matrixR4UartmPmS1_+0x68>
 1000a14:	00000013          	nop
 1000a18:	00000013          	nop
 1000a1c:	03c12083          	lw	ra,60(sp)
 1000a20:	03812403          	lw	s0,56(sp)
 1000a24:	04010113          	addi	sp,sp,64
 1000a28:	00008067          	ret

01000a2c <_Z13mem_read_wordmm>:
 1000a2c:	fd010113          	addi	sp,sp,-48
 1000a30:	02112623          	sw	ra,44(sp)
 1000a34:	02812423          	sw	s0,40(sp)
 1000a38:	03010413          	addi	s0,sp,48
 1000a3c:	fca42e23          	sw	a0,-36(s0)
 1000a40:	fcb42c23          	sw	a1,-40(s0)
 1000a44:	fdc42703          	lw	a4,-36(s0)
 1000a48:	fd842783          	lw	a5,-40(s0)
 1000a4c:	00f707b3          	add	a5,a4,a5
 1000a50:	fef42623          	sw	a5,-20(s0)
 1000a54:	fec42703          	lw	a4,-20(s0)
 1000a58:	00c007b7          	lui	a5,0xc00
 1000a5c:	00f707b3          	add	a5,a4,a5
 1000a60:	00279793          	slli	a5,a5,0x2
 1000a64:	0007a783          	lw	a5,0(a5) # c00000 <_ebss+0xc00000>
 1000a68:	00078513          	mv	a0,a5
 1000a6c:	02c12083          	lw	ra,44(sp)
 1000a70:	02812403          	lw	s0,40(sp)
 1000a74:	03010113          	addi	sp,sp,48
 1000a78:	00008067          	ret

01000a7c <_Z14mem_write_wordmmm>:
 1000a7c:	fd010113          	addi	sp,sp,-48
 1000a80:	02112623          	sw	ra,44(sp)
 1000a84:	02812423          	sw	s0,40(sp)
 1000a88:	03010413          	addi	s0,sp,48
 1000a8c:	fca42e23          	sw	a0,-36(s0)
 1000a90:	fcb42c23          	sw	a1,-40(s0)
 1000a94:	fcc42a23          	sw	a2,-44(s0)
 1000a98:	fdc42703          	lw	a4,-36(s0)
 1000a9c:	fd842783          	lw	a5,-40(s0)
 1000aa0:	00f707b3          	add	a5,a4,a5
 1000aa4:	fef42623          	sw	a5,-20(s0)
 1000aa8:	fec42703          	lw	a4,-20(s0)
 1000aac:	00c007b7          	lui	a5,0xc00
 1000ab0:	00f707b3          	add	a5,a4,a5
 1000ab4:	00279793          	slli	a5,a5,0x2
 1000ab8:	fef42423          	sw	a5,-24(s0)
 1000abc:	fe842783          	lw	a5,-24(s0)
 1000ac0:	fd442703          	lw	a4,-44(s0)
 1000ac4:	00e7a023          	sw	a4,0(a5) # c00000 <_ebss+0xc00000>
 1000ac8:	00000013          	nop
 1000acc:	02c12083          	lw	ra,44(sp)
 1000ad0:	02812403          	lw	s0,40(sp)
 1000ad4:	03010113          	addi	sp,sp,48
 1000ad8:	00008067          	ret

01000adc <_Z13mem_read_bitsmmhh>:
 1000adc:	fd010113          	addi	sp,sp,-48
 1000ae0:	02112623          	sw	ra,44(sp)
 1000ae4:	02812423          	sw	s0,40(sp)
 1000ae8:	03010413          	addi	s0,sp,48
 1000aec:	fca42e23          	sw	a0,-36(s0)
 1000af0:	fcb42c23          	sw	a1,-40(s0)
 1000af4:	00060793          	mv	a5,a2
 1000af8:	00068713          	mv	a4,a3
 1000afc:	fcf40ba3          	sb	a5,-41(s0)
 1000b00:	00070793          	mv	a5,a4
 1000b04:	fcf40b23          	sb	a5,-42(s0)
 1000b08:	fd644783          	lbu	a5,-42(s0)
 1000b0c:	02078863          	beqz	a5,1000b3c <_Z13mem_read_bitsmmhh+0x60>
 1000b10:	fd644703          	lbu	a4,-42(s0)
 1000b14:	02000793          	li	a5,32
 1000b18:	02e7e263          	bltu	a5,a4,1000b3c <_Z13mem_read_bitsmmhh+0x60>
 1000b1c:	fd744703          	lbu	a4,-41(s0)
 1000b20:	01f00793          	li	a5,31
 1000b24:	00e7ec63          	bltu	a5,a4,1000b3c <_Z13mem_read_bitsmmhh+0x60>
 1000b28:	fd744703          	lbu	a4,-41(s0)
 1000b2c:	fd644783          	lbu	a5,-42(s0)
 1000b30:	00f70733          	add	a4,a4,a5
 1000b34:	02000793          	li	a5,32
 1000b38:	00e7d663          	bge	a5,a4,1000b44 <_Z13mem_read_bitsmmhh+0x68>
 1000b3c:	00000793          	li	a5,0
 1000b40:	0500006f          	j	1000b90 <_Z13mem_read_bitsmmhh+0xb4>
 1000b44:	fd842583          	lw	a1,-40(s0)
 1000b48:	fdc42503          	lw	a0,-36(s0)
 1000b4c:	ee1ff0ef          	jal	1000a2c <_Z13mem_read_wordmm>
 1000b50:	fea42623          	sw	a0,-20(s0)
 1000b54:	fd644703          	lbu	a4,-42(s0)
 1000b58:	02000793          	li	a5,32
 1000b5c:	00f70c63          	beq	a4,a5,1000b74 <_Z13mem_read_bitsmmhh+0x98>
 1000b60:	fd644783          	lbu	a5,-42(s0)
 1000b64:	00100713          	li	a4,1
 1000b68:	00f717b3          	sll	a5,a4,a5
 1000b6c:	fff78793          	addi	a5,a5,-1
 1000b70:	0080006f          	j	1000b78 <_Z13mem_read_bitsmmhh+0x9c>
 1000b74:	fff00793          	li	a5,-1
 1000b78:	fef42423          	sw	a5,-24(s0)
 1000b7c:	fd744783          	lbu	a5,-41(s0)
 1000b80:	fec42703          	lw	a4,-20(s0)
 1000b84:	00f75733          	srl	a4,a4,a5
 1000b88:	fe842783          	lw	a5,-24(s0)
 1000b8c:	00f777b3          	and	a5,a4,a5
 1000b90:	00078513          	mv	a0,a5
 1000b94:	02c12083          	lw	ra,44(sp)
 1000b98:	02812403          	lw	s0,40(sp)
 1000b9c:	03010113          	addi	sp,sp,48
 1000ba0:	00008067          	ret

01000ba4 <_Z14mem_write_bitsmmmhh>:
 1000ba4:	fc010113          	addi	sp,sp,-64
 1000ba8:	02112e23          	sw	ra,60(sp)
 1000bac:	02812c23          	sw	s0,56(sp)
 1000bb0:	04010413          	addi	s0,sp,64
 1000bb4:	fca42623          	sw	a0,-52(s0)
 1000bb8:	fcb42423          	sw	a1,-56(s0)
 1000bbc:	fcc42223          	sw	a2,-60(s0)
 1000bc0:	00068793          	mv	a5,a3
 1000bc4:	fcf401a3          	sb	a5,-61(s0)
 1000bc8:	00070793          	mv	a5,a4
 1000bcc:	fcf40123          	sb	a5,-62(s0)
 1000bd0:	fc244783          	lbu	a5,-62(s0)
 1000bd4:	0e078263          	beqz	a5,1000cb8 <_Z14mem_write_bitsmmmhh+0x114>
 1000bd8:	fc244703          	lbu	a4,-62(s0)
 1000bdc:	02000793          	li	a5,32
 1000be0:	0ce7ec63          	bltu	a5,a4,1000cb8 <_Z14mem_write_bitsmmmhh+0x114>
 1000be4:	fc344703          	lbu	a4,-61(s0)
 1000be8:	01f00793          	li	a5,31
 1000bec:	0ce7e663          	bltu	a5,a4,1000cb8 <_Z14mem_write_bitsmmmhh+0x114>
 1000bf0:	fc344703          	lbu	a4,-61(s0)
 1000bf4:	fc244783          	lbu	a5,-62(s0)
 1000bf8:	00f70733          	add	a4,a4,a5
 1000bfc:	02000793          	li	a5,32
 1000c00:	0ae7cc63          	blt	a5,a4,1000cb8 <_Z14mem_write_bitsmmmhh+0x114>
 1000c04:	fcc42703          	lw	a4,-52(s0)
 1000c08:	fc842783          	lw	a5,-56(s0)
 1000c0c:	00f707b3          	add	a5,a4,a5
 1000c10:	fef42623          	sw	a5,-20(s0)
 1000c14:	fec42703          	lw	a4,-20(s0)
 1000c18:	00c007b7          	lui	a5,0xc00
 1000c1c:	00f707b3          	add	a5,a4,a5
 1000c20:	00279793          	slli	a5,a5,0x2
 1000c24:	fef42423          	sw	a5,-24(s0)
 1000c28:	fe842783          	lw	a5,-24(s0)
 1000c2c:	0007a783          	lw	a5,0(a5) # c00000 <_ebss+0xc00000>
 1000c30:	fef42223          	sw	a5,-28(s0)
 1000c34:	fc244703          	lbu	a4,-62(s0)
 1000c38:	02000793          	li	a5,32
 1000c3c:	00f70c63          	beq	a4,a5,1000c54 <_Z14mem_write_bitsmmmhh+0xb0>
 1000c40:	fc244783          	lbu	a5,-62(s0)
 1000c44:	00100713          	li	a4,1
 1000c48:	00f717b3          	sll	a5,a4,a5
 1000c4c:	fff78793          	addi	a5,a5,-1
 1000c50:	0080006f          	j	1000c58 <_Z14mem_write_bitsmmmhh+0xb4>
 1000c54:	fff00793          	li	a5,-1
 1000c58:	fef42023          	sw	a5,-32(s0)
 1000c5c:	fc344783          	lbu	a5,-61(s0)
 1000c60:	fe042703          	lw	a4,-32(s0)
 1000c64:	00f717b3          	sll	a5,a4,a5
 1000c68:	fff7c793          	not	a5,a5
 1000c6c:	fcf42e23          	sw	a5,-36(s0)
 1000c70:	fe442703          	lw	a4,-28(s0)
 1000c74:	fdc42783          	lw	a5,-36(s0)
 1000c78:	00f777b3          	and	a5,a4,a5
 1000c7c:	fcf42c23          	sw	a5,-40(s0)
 1000c80:	fc442703          	lw	a4,-60(s0)
 1000c84:	fe042783          	lw	a5,-32(s0)
 1000c88:	00f77733          	and	a4,a4,a5
 1000c8c:	fc344783          	lbu	a5,-61(s0)
 1000c90:	00f717b3          	sll	a5,a4,a5
 1000c94:	fcf42a23          	sw	a5,-44(s0)
 1000c98:	fd842703          	lw	a4,-40(s0)
 1000c9c:	fd442783          	lw	a5,-44(s0)
 1000ca0:	00f767b3          	or	a5,a4,a5
 1000ca4:	fcf42823          	sw	a5,-48(s0)
 1000ca8:	fe842783          	lw	a5,-24(s0)
 1000cac:	fd042703          	lw	a4,-48(s0)
 1000cb0:	00e7a023          	sw	a4,0(a5)
 1000cb4:	0080006f          	j	1000cbc <_Z14mem_write_bitsmmmhh+0x118>
 1000cb8:	00000013          	nop
 1000cbc:	03c12083          	lw	ra,60(sp)
 1000cc0:	03812403          	lw	s0,56(sp)
 1000cc4:	04010113          	addi	sp,sp,64
 1000cc8:	00008067          	ret

01000ccc <_ZN4UartC1Em>:
 1000ccc:	fe010113          	addi	sp,sp,-32
 1000cd0:	00112e23          	sw	ra,28(sp)
 1000cd4:	00812c23          	sw	s0,24(sp)
 1000cd8:	02010413          	addi	s0,sp,32
 1000cdc:	fea42623          	sw	a0,-20(s0)
 1000ce0:	feb42423          	sw	a1,-24(s0)
 1000ce4:	fe842703          	lw	a4,-24(s0)
 1000ce8:	fec42783          	lw	a5,-20(s0)
 1000cec:	00e7a023          	sw	a4,0(a5)
 1000cf0:	00000013          	nop
 1000cf4:	01c12083          	lw	ra,28(sp)
 1000cf8:	01812403          	lw	s0,24(sp)
 1000cfc:	02010113          	addi	sp,sp,32
 1000d00:	00008067          	ret

01000d04 <_ZN4Uart9write_regEmm>:
 1000d04:	fe010113          	addi	sp,sp,-32
 1000d08:	00112e23          	sw	ra,28(sp)
 1000d0c:	00812c23          	sw	s0,24(sp)
 1000d10:	02010413          	addi	s0,sp,32
 1000d14:	fea42623          	sw	a0,-20(s0)
 1000d18:	feb42423          	sw	a1,-24(s0)
 1000d1c:	fec42223          	sw	a2,-28(s0)
 1000d20:	fec42783          	lw	a5,-20(s0)
 1000d24:	0007a703          	lw	a4,0(a5)
 1000d28:	fe842783          	lw	a5,-24(s0)
 1000d2c:	00279793          	slli	a5,a5,0x2
 1000d30:	00f707b3          	add	a5,a4,a5
 1000d34:	fe442703          	lw	a4,-28(s0)
 1000d38:	00e7a023          	sw	a4,0(a5)
 1000d3c:	00000013          	nop
 1000d40:	01c12083          	lw	ra,28(sp)
 1000d44:	01812403          	lw	s0,24(sp)
 1000d48:	02010113          	addi	sp,sp,32
 1000d4c:	00008067          	ret

01000d50 <_ZN4Uart8read_regEm>:
 1000d50:	fe010113          	addi	sp,sp,-32
 1000d54:	00112e23          	sw	ra,28(sp)
 1000d58:	00812c23          	sw	s0,24(sp)
 1000d5c:	02010413          	addi	s0,sp,32
 1000d60:	fea42623          	sw	a0,-20(s0)
 1000d64:	feb42423          	sw	a1,-24(s0)
 1000d68:	fec42783          	lw	a5,-20(s0)
 1000d6c:	0007a703          	lw	a4,0(a5)
 1000d70:	fe842783          	lw	a5,-24(s0)
 1000d74:	00279793          	slli	a5,a5,0x2
 1000d78:	00f707b3          	add	a5,a4,a5
 1000d7c:	0007a783          	lw	a5,0(a5)
 1000d80:	00078513          	mv	a0,a5
 1000d84:	01c12083          	lw	ra,28(sp)
 1000d88:	01812403          	lw	s0,24(sp)
 1000d8c:	02010113          	addi	sp,sp,32
 1000d90:	00008067          	ret

01000d94 <_ZN4Uart4initEmm>:
 1000d94:	fd010113          	addi	sp,sp,-48
 1000d98:	02112623          	sw	ra,44(sp)
 1000d9c:	02812423          	sw	s0,40(sp)
 1000da0:	03010413          	addi	s0,sp,48
 1000da4:	fca42e23          	sw	a0,-36(s0)
 1000da8:	fcb42c23          	sw	a1,-40(s0)
 1000dac:	fcc42a23          	sw	a2,-44(s0)
 1000db0:	fd442783          	lw	a5,-44(s0)
 1000db4:	00479793          	slli	a5,a5,0x4
 1000db8:	fd842703          	lw	a4,-40(s0)
 1000dbc:	02f757b3          	divu	a5,a4,a5
 1000dc0:	fff78793          	addi	a5,a5,-1
 1000dc4:	fef42623          	sw	a5,-20(s0)
 1000dc8:	fec42783          	lw	a5,-20(s0)
 1000dcc:	7ff7f793          	andi	a5,a5,2047
 1000dd0:	00078613          	mv	a2,a5
 1000dd4:	00100593          	li	a1,1
 1000dd8:	fdc42503          	lw	a0,-36(s0)
 1000ddc:	f29ff0ef          	jal	1000d04 <_ZN4Uart9write_regEmm>
 1000de0:	00000013          	nop
 1000de4:	02c12083          	lw	ra,44(sp)
 1000de8:	02812403          	lw	s0,40(sp)
 1000dec:	03010113          	addi	sp,sp,48
 1000df0:	00008067          	ret

01000df4 <_ZN4Uart5writeEh>:
 1000df4:	fe010113          	addi	sp,sp,-32
 1000df8:	00112e23          	sw	ra,28(sp)
 1000dfc:	00812c23          	sw	s0,24(sp)
 1000e00:	02010413          	addi	s0,sp,32
 1000e04:	fea42623          	sw	a0,-20(s0)
 1000e08:	00058793          	mv	a5,a1
 1000e0c:	fef405a3          	sb	a5,-21(s0)
 1000e10:	00000013          	nop
 1000e14:	00300593          	li	a1,3
 1000e18:	fec42503          	lw	a0,-20(s0)
 1000e1c:	f35ff0ef          	jal	1000d50 <_ZN4Uart8read_regEm>
 1000e20:	00050793          	mv	a5,a0
 1000e24:	2007f793          	andi	a5,a5,512
 1000e28:	00f037b3          	snez	a5,a5
 1000e2c:	0ff7f793          	zext.b	a5,a5
 1000e30:	fe0792e3          	bnez	a5,1000e14 <_ZN4Uart5writeEh+0x20>
 1000e34:	feb44783          	lbu	a5,-21(s0)
 1000e38:	00078613          	mv	a2,a5
 1000e3c:	00200593          	li	a1,2
 1000e40:	fec42503          	lw	a0,-20(s0)
 1000e44:	ec1ff0ef          	jal	1000d04 <_ZN4Uart9write_regEmm>
 1000e48:	00000013          	nop
 1000e4c:	01c12083          	lw	ra,28(sp)
 1000e50:	01812403          	lw	s0,24(sp)
 1000e54:	02010113          	addi	sp,sp,32
 1000e58:	00008067          	ret

01000e5c <_ZN4Uart4readEv>:
 1000e5c:	fd010113          	addi	sp,sp,-48
 1000e60:	02112623          	sw	ra,44(sp)
 1000e64:	02812423          	sw	s0,40(sp)
 1000e68:	03010413          	addi	s0,sp,48
 1000e6c:	fca42e23          	sw	a0,-36(s0)
 1000e70:	00300593          	li	a1,3
 1000e74:	fdc42503          	lw	a0,-36(s0)
 1000e78:	ed9ff0ef          	jal	1000d50 <_ZN4Uart8read_regEm>
 1000e7c:	fea42623          	sw	a0,-20(s0)
 1000e80:	fec42783          	lw	a5,-20(s0)
 1000e84:	1007f793          	andi	a5,a5,256
 1000e88:	00078663          	beqz	a5,1000e94 <_ZN4Uart4readEv+0x38>
 1000e8c:	fff00793          	li	a5,-1
 1000e90:	01c0006f          	j	1000eac <_ZN4Uart4readEv+0x50>
 1000e94:	fec42783          	lw	a5,-20(s0)
 1000e98:	01079793          	slli	a5,a5,0x10
 1000e9c:	4107d793          	srai	a5,a5,0x10
 1000ea0:	0ff7f793          	zext.b	a5,a5
 1000ea4:	01079793          	slli	a5,a5,0x10
 1000ea8:	4107d793          	srai	a5,a5,0x10
 1000eac:	00078513          	mv	a0,a5
 1000eb0:	02c12083          	lw	ra,44(sp)
 1000eb4:	02812403          	lw	s0,40(sp)
 1000eb8:	03010113          	addi	sp,sp,48
 1000ebc:	00008067          	ret

01000ec0 <_ZN4Uart10is_tx_fullEv>:
 1000ec0:	fe010113          	addi	sp,sp,-32
 1000ec4:	00112e23          	sw	ra,28(sp)
 1000ec8:	00812c23          	sw	s0,24(sp)
 1000ecc:	02010413          	addi	s0,sp,32
 1000ed0:	fea42623          	sw	a0,-20(s0)
 1000ed4:	00300593          	li	a1,3
 1000ed8:	fec42503          	lw	a0,-20(s0)
 1000edc:	e75ff0ef          	jal	1000d50 <_ZN4Uart8read_regEm>
 1000ee0:	00050793          	mv	a5,a0
 1000ee4:	2007f793          	andi	a5,a5,512
 1000ee8:	00f037b3          	snez	a5,a5
 1000eec:	0ff7f793          	zext.b	a5,a5
 1000ef0:	00078513          	mv	a0,a5
 1000ef4:	01c12083          	lw	ra,28(sp)
 1000ef8:	01812403          	lw	s0,24(sp)
 1000efc:	02010113          	addi	sp,sp,32
 1000f00:	00008067          	ret

01000f04 <_ZN4Uart11is_rx_emptyEv>:
 1000f04:	fe010113          	addi	sp,sp,-32
 1000f08:	00112e23          	sw	ra,28(sp)
 1000f0c:	00812c23          	sw	s0,24(sp)
 1000f10:	02010413          	addi	s0,sp,32
 1000f14:	fea42623          	sw	a0,-20(s0)
 1000f18:	00300593          	li	a1,3
 1000f1c:	fec42503          	lw	a0,-20(s0)
 1000f20:	e31ff0ef          	jal	1000d50 <_ZN4Uart8read_regEm>
 1000f24:	00050793          	mv	a5,a0
 1000f28:	1007f793          	andi	a5,a5,256
 1000f2c:	00f037b3          	snez	a5,a5
 1000f30:	0ff7f793          	zext.b	a5,a5
 1000f34:	00078513          	mv	a0,a5
 1000f38:	01c12083          	lw	ra,28(sp)
 1000f3c:	01812403          	lw	s0,24(sp)
 1000f40:	02010113          	addi	sp,sp,32
 1000f44:	00008067          	ret

01000f48 <_ZN4Uart12write_stringEPKc>:
 1000f48:	fe010113          	addi	sp,sp,-32
 1000f4c:	00112e23          	sw	ra,28(sp)
 1000f50:	00812c23          	sw	s0,24(sp)
 1000f54:	02010413          	addi	s0,sp,32
 1000f58:	fea42623          	sw	a0,-20(s0)
 1000f5c:	feb42423          	sw	a1,-24(s0)
 1000f60:	0200006f          	j	1000f80 <_ZN4Uart12write_stringEPKc+0x38>
 1000f64:	fe842783          	lw	a5,-24(s0)
 1000f68:	00178713          	addi	a4,a5,1
 1000f6c:	fee42423          	sw	a4,-24(s0)
 1000f70:	0007c783          	lbu	a5,0(a5)
 1000f74:	00078593          	mv	a1,a5
 1000f78:	fec42503          	lw	a0,-20(s0)
 1000f7c:	e79ff0ef          	jal	1000df4 <_ZN4Uart5writeEh>
 1000f80:	fe842783          	lw	a5,-24(s0)
 1000f84:	0007c783          	lbu	a5,0(a5)
 1000f88:	fc079ee3          	bnez	a5,1000f64 <_ZN4Uart12write_stringEPKc+0x1c>
 1000f8c:	00000013          	nop
 1000f90:	00000013          	nop
 1000f94:	01c12083          	lw	ra,28(sp)
 1000f98:	01812403          	lw	s0,24(sp)
 1000f9c:	02010113          	addi	sp,sp,32
 1000fa0:	00008067          	ret

01000fa4 <_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE>:
 1000fa4:	                                         .

01000fa5 <_ZNSt8__detail30__integer_to_chars_is_unsignedImEE>:
 1000fa5:	                                         .

01000fa6 <_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE>:
 1000fa6:	                                         ..
