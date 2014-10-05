		; Inserimento delle variabili
			.data
matX:		.double		2.3, 5.8, 11.4, 9.4, 3.0, 1.8, 4.6, 3.7, 6.6
matY:		.double		10.4, 5.3, 7.7, 1.3, 8.9, 3.7, 8.6, 2.0, 9.7
matZ:		.double		0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
max:		.word		3
elem_1_z:	.double		0.0


		; Inizio programma
			.text
			.global	main
main:
			LW      r1, max				; Inizializzo il numero di elementi
			ADDI    r2, r0, 0			; i = 0

zero_j:		
			MULT    r5, r2, r1			; i * max
			ADDI    r3, r0, 0			; j = 0
			

zero_k:		
			ADDI    r4, r0, 0			; k = 0
			LD      f0, elem_1_z		; Inializzo a 0.0 il registro

loop:		
		; Lettura elemento in posizione matX[i][k] e matY[k][j]			
			MULT    r8, r4, r1			; k * max
			ADD     r6, r5, r4			; i * max + k
			SLL     r7, r6, 3			; Posizione elemento matX
			LD      f2, matX(r7)		; Leggo elemento di matX
			ADD     r9, r8, r3			; k * max + j
			SLL     r10, r9, 3			; Posizione elemento di matY
			LD      f4, matY(r10)		; Leggo elemento di matY

		; Moltiplico i due valori
			MULTD   f6, f2, f4			; matX[i][k] * matY[k][j]
			
		; Incremento k e controllo il suo valore
			ADD     r4, r4, 1			; k = k + 1
			SEQ     r11, r4, r1			; Controllo se k = max
		
		; Aggiungo il valore al registro
			ADDD    f0, f0, f6			; Aggiungo il risultato nel registro (f0 += matX[i][k] * matY[k][j])
			
		; Salto a 'loop' dopo aver verificato il valore di k
			BEQZ    r11, loop			; Se k != max vai a 'loop' altrimenti continua il codice
		
		; Salvo il valore del registro in matZ
			ADD     r13, r5, r3			; i * max + j
			SLL     r14, r13, 3			; Posizione elemento matZ
			SD      matZ(r14), f0		; Salvo il valore di f0 in matZ[i][j]
	
		; Incremento j e controllo il suo valore
			ADD     r3, r3, 1			; j = j + 1
			SEQ     r15, r3, r1			; Controllo se j = max
			BEQZ    r15, zero_k			; Se j != max vai a 'zero_k' altrimenti continua il codice
	
		; Incremento i e controllo il suo valore
			ADD     r2, r2, 1			; i = i + 1
			SEQ     r16, r2, r1			; Controllo se i = max
			BEQZ    r16, zero_j			; Se i != max vai a 'zero_j' altrimenti continua il codice

		; Fine programma
			trap	0					;Fine