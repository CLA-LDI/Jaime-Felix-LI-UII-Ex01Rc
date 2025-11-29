					TITLE	Programa para comparar dos cadenas (Examen Unidad II Recuperación Tipo c)

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD

				.DATA
Cadena01		WORD	80 DUP ( ? )
Cadena02		WORD	80 DUP ( ? )
LongCadena01	QWORD	?
LongCadena02	QWORD	?
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 'p', 'r', 'i', 'm', 'e', 'r', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ':', ' '
MenEnt02		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 's', 'e', 'g', 'u', 'n', 'd', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ':', ' '
; Definir los mensajes de salida correspondientes

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador estándar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador estándar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la primera cadena
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	WriteConsoleW
				POP		R10

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Cadena01				; Dirección de la cadena a leer
				MOV		R8, LENGTHOF Cadena01		; Número de caracteres máximo a leer
				LEA		R9, LongCadena01			; Dirección de la variable donde se guarda el total de caracteres leídos
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	ReadConsoleW
				POP		R10

				SUB		LongCadena01, 2				; Para eliminar el <Enter>

				; Solicitar la segunda cadena

				; Debe comparar las dos cadenas hasta la longitud de la más pequeña.
				; Al final del ciclo de comparación pregunte la causa de salida del ciclo:

				; JA - La primer cadena es menor.
				; JE - Las cadenas son iguales.
				; JB - La primer cadena es mayor.

				; Mostrar el resultado correspondiente
				; La primer cadena es menor que la segunda.
				; La primer cadena es igual que la segunda.
				; La primer cadena es mayor que la segunda.

				; Salto de línea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				PUSH	R10
				CALL	WriteConsoleW
				POP		R10

				; Recuperar el espacio de la pila
				ADD		RSP, 40

				; Salir al S. O
				MOV		RAX, 0					; Código de salida 0
				RET								; Retornar al sistema operativo
Principal		ENDP
				END
