	.data
strd:	.asciz	" %u "//print en decimal
strx:	.asciz	" %x "//print en hexadecimal
nl:	.asciz	"\n"

length: .byte   0x0A
tab:	.byte   0xFF, 0x0A, 0x00, 0xB0, 0x01, 0xE0, 0xFF, 0xB0, 0x04, 0x50

	.align	2

	.text
	.globl	main

main:	stmfd	sp!,{lr}
	ldr	r3,=length // r3 = 10 (longueur tab)
  ldrb    r3,[r3]


	ldr	r0,=strx //r0 = " %x " <- valeur hexa
	mov	r1,r3 //r1=r3
	stmfd	sp!,{r3}	// attention printf peut modifier r0-r3
	bl	printf // printf le registre 3 ? not fully sure xD -> print(r0,r1) -> r0=" %x ", r1=0x0A
  ldmfd	sp!,{r3} // reload la valeur stocke y a 2 lignes


  cmp     r3,#0 //r3 est la condition d arret. si r3=0, on branch a fin
  beq	fin		// tableau vide

	ldr	r0,=nl // r0 ="\n"
	stmfd	sp!,{r3}// on presock r3
	bl	printf // on print le saut a la ligne (r0)
	ldmfd	sp!,{r3} // on rechoppe val r3,

	mov	r4,#0 // r4=0
	ldr	r5,=tab // r5 =tab
  ldr	r0,=strd //print en decimal " %u "
1:      ldrb	r1,[r5,r4]	// nombres non signes
	stmfd	sp!,{r0,r3}//stock r0 r3
	bl	printf //il print 1ere valeur du tab printf(r0,r1)-> "%u",[r5,r4]
	ldmfd	sp!,{r0,r3} //va rechercher les valuers r0 et r3,
	add	r4,r4,#1 // incremente r4
	cmp	r4,r3 // compare r4 a r3
	bls	1b // branch 1b si r4 est smaller or same que r3 -> 1b retourne au label local 1 precedent

	ldr	r0,=nl // saut a la ligne
	stmfd	sp!,{r3}
	bl	printf
	ldmfd	sp!,{r3}

	mov	r4,#0 // on remet r4 a 0
	ldr	r5,=tab
        ldr	r0,=strx // on refait exactement la meme chose, en affichant en hexadecimal
1:      ldrb	r1,[r5,r4]	// nombres non signes
	stmfd	sp!,{r0,r3}
	bl	printf
	ldmfd	sp!,{r0,r3}
	add	r4,r4,#1
	cmp	r4,r3
	bls	1b // ici, on a print a, saut a la ligne, le tableau en decimal, salut a la ligne, et finalement tableau en hexadecimal


	ldr	r0,=nl//saut a la ligne
	stmfd	sp!,{r3}
	bl	printf
	ldmfd	sp!,{r3}


	sub	r5,r3,#1 //r5 = r3 -1, r3 vaut a, ou 10, et du coup r5 vaut 9 mtn
for1:   cmp     r5,#1		// r5 est i -> on compare r5 et 1
        blo     fintri // si r5<1 on branch a fintri
        mov	r6,#0		// r6 est j =0
	ldr	r4,=tab // r4 est l adresse de tab
for2:	cmp	r6,r5 //compare r6 et r5
	bhs     1f //si r6>= r5
	ldrb	r7,[r4],#1// r7=[r4], r4 est incremente
	add	r6,r6,#1//r6=r6+1
	ldrb	r8,[r4]//r8=[r4] -> r4 a bien incremente apres le load precedend
	cmp     r7,r8//compare r7 et r8
	bhs	for2//si r7>r8, on va a for2
  strb	r7,[r4]//si plus petit, on vient ici et on stock dans l adresse memoire r4, la valeur r7
	strb	r8,[r4,#-1]// stock r8 a l adresse precedente, et en fait on a inverse les 2 valeurs en memoire
	b	for2
1:	sub	r5,r5,#1//on decremente r5, pcq la la derniere valeur on sait qu elle est bien !
	b	for1


fintri: ldr	r0,=nl//saut a la ligne
	stmfd	sp!,{r3}
	bl	printf
	ldmfd	sp!,{r3}

	mov	r4,#0
	ldr	r5,=tab
        ldr	r0,=strd
1:      ldrb	r1,[r5,r4]	// nombres non signes -> print a nouveau tout le tableau
	stmfd	sp!,{r0,r3}
	bl	printf
	ldmfd	sp!,{r0,r3}
	add	r4,r4,#1
	cmp	r4,r3
	bls	1b

fin:	ldr	r0,=nl//saut a la ligne
	stmfd	sp!,{r3}
	bl	printf
	ldmfd	sp!,{r3}

	mov	r0,#0
	ldmfd	sp!,{lr}
	mov	pc,lr //fin code
