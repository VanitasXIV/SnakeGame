.8086
	.model small
	.stack 100h
	.data



	

	clockgame db 3

		
   inst_dificultad1 db '          Seleccione dificultad presionando:          ', '$'
   inst_dificultad2 db '        1- Facil      2- Intermedio      3- Dificil        ', '$'        

;logo autogenerado con ASCII Image Discord Bot
	s1 db  32,  32,  32,  32,  32,  32
       db 220, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 220
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219 
       db  32, 32
       db  32,  32,  32, 219, 219, 219, 219, 219, 219,  32,  32,  32 
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219 
       db  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219 
       db  32,  32,  32,  32,  32,  32, '$'
       
       
    s2 db  32,  32,  32,  32,  32,  32
       db 219, 219, 219, 219, 223, 223, 223, 223, 223, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 219,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db  32,  32, 219, 219, 219, 219, 219, 219, 219, 219,  32,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 223, 223, 223, 223, 223, 223, 223, 223, 219
       db  32,  32,  32,  32,  32,  32, '$'
       
    s3 db  32,  32,  32,  32,  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32
       db 219, 219, 219, 219, 219,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db  32, 219, 219, 219, 219,  32,  32, 219, 219, 219, 219,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32, 219, 219, 219, 219,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    
    s4 db  32,  32,  32,  32,  32,  32
       db 219, 219, 219, 220,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32
       db 219, 219, 219, 219, 219, 219,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 223,  32,  32,  32,  32, 223, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 220, 220, 220, 219, 219, 219, 219,  32,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    s5 db  32,  32,  32,  32,  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 220
       db  32,  32
       db 219, 219, 219,  32, 219, 219, 219,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 223,  32,  32,  32
       db  32,  32
       db 219, 219, 219, 220, 220, 220, 220, 220, 219,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    s6 db  32,  32,  32,  32,  32,  32
       db 223, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32, 219, 219, 219,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 220,  32,  32,  32
       db  32,  32
       db 219, 219, 219, 223, 223, 223, 223, 223, 219,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    s7 db  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32,  32,  32, 223, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32, 219, 219, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 220, 220, 220, 220, 220, 220, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 223, 223, 223, 219, 219, 219, 219,  32,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    s8 db  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32, 219, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32, 219, 219, 219, 219,  32
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32,  32,  32,  32
       db  32,  32,  32,  32,  32,  32, '$'
    s9 db  32,  32,  32,  32,  32,  32
       db 219, 219, 219, 220, 220, 220, 220, 220, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32, 219, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 220, 220, 220, 220, 220, 220, 220, 220, 219
       db  32,  32,  32,  32,  32,  32, '$'
   s10 db  32,  32,  32,  32,  32,  32
       db 223, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 223
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219,  32,  32,  32,  32,  32,  32, 219, 219, 219
       db  32,  32
       db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219
       db  32,  32,  32,  32,  32,  32, '$'
       
    g1 db 220, 223, 223, 223, 220
       db  32,  32
       db 220, 223, 223, 223, 220
       db  32,  32
       db 219,  32, 219,  32, 219,  32
       db  32,  32
       db 220, 223, 223, 223, 220
       db '$'
    g2 db 219,  32,  32,  32, 219
       db  32,  32
       db 223,  32,  32,  32, 219
       db  32,  32
       db 219, 219,  32, 219,  32, 219
       db  32,  32
       db 219,  32,  32,  32, 219
       db '$'
    g3 db 219,  32,  32,  32, 219
       db  32,  32
       db 220, 220, 220, 220, 219
       db  32,  32
       db 219,  32,  32,  32,  32, 219
       db  32,  32
       db 219, 223, 223, 223
       db '$'
    g4 db 219,  32,  32,  32, 219
       db  32,  32
       db 219,  32,  32,  32, 219
       db  32,  32
       db 219,  32,  32,  32,  32, 219
       db  32,  32
       db 219,  32,  32,  32,  220
       db '$'
    g5 db  32, 223, 223, 223, 219
       db  32,  32
       db  32, 223, 223, 223, 223
       db  32,  32
       db 223,  32,  32,  32,  32, 223
       db  32,  32
       db  32, 223, 223, 223
       db '$'
    g6 db  32,  32,  32,  32, 219, '$'
    g7 db  32, 223, 223, 223, '$' 

.code


public logo
public print
public deltaTime




deltaTime proc
	;guardo registros
	push si
    push bx
    push dx

	;configuro tiempo de retraso
    xor bx, bx
    add bl, clockgame
    mov si, bx ;3 ticks de retraso
    mov ah, 00h    ;Servicio que lee el clock del sistema
    int 1Ah ;int para acceder al reloj del sistema
    ;El clock se incrementa 18,206 por segundo

	;calculo el tiempo
    mov bx, dx          ;Me guardo en BX el "Low Order word" del tick count
    add bx, si          ;Le sumo n 
	
	
    deltaTime_loop:

    int 1Ah ;actualiza el tick
    cmp dx, bx ;compara el numero actual de ticks con 3
    jne deltaTime_loop

	;restauro registros
    pop dx
    pop bx
    pop si
    ret
deltaTime endp


print proc
    push ax
    mov ah, 09h             
    int 21h
    pop ax
    ret
print endp


printcolor proc
    push ax
    push bx
    
    cmp byte ptr[bx],24h
    je finprintcolor

    mov al,[bx]
    mov bl,06h
    mov ah, 09h             
    int 10h

    

    inc dl
    mov ah,02h
    int 10h
    jmp finprintcolor


    finprintcolor:

    pop bx
    pop ax
    ret
printcolor endp


logo proc

		push ax
	    push dx
	    

	  DificultadLoop:

	   mov ax, 3
	   int 10h

	 ;voy a llenar TODO el espacio de pantalla con caracteres "espacio" con un color asignado
	 ;al tener un color asignado, todo lo que pise ese "espacio vacío" tomará los atributos (color) del caracter anterior
	 ;depués imprimo normalmente el logo y toma el color que quiero
	 ;hay varios loops con el mismo nombre, cada loop recorre cierta cantidad de filas para llenar con un color asignado


	 mov si,1 ;contador para el loop
    
    xor dh,dh

   color1:
    inc dh 				;aumenta posicion en fila
    xor dl, dl 		;coloca cursor en columna 0
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 06h      ;Asigno el color (naranja)
    mov cx, 80   		; Cant de veces que printeo el caracter
    mov al, 32   		; Caracter ASCII 32 (ESPACIO)
    mov ah,09h   		;Servicio para printear caracter (con atributos)
    int 10h
    
               

    add dl, 80 	   ;columna 78 en pixeles
    mov ah, 02h   	;Muevo el cursor a la ultima columna
    int 10h
    
    
    
    inc si
    cmp si, 9 			;elijo hasta qué fila llega el primer color
   jnz color1

   color2:           ;repite color1
    inc dh 				;empieza desde la fila anterior
    xor dl, dl 		;coloca cursor en columna 0
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 03h      ;Asigno el color (cyan)
    mov cx, 80   		; Cant de veces que printeo el caracter
    mov al, 32   		; Caracter ASCII 32 (ESPACIO)
    mov ah,09h   		;Servicio para printear caracter (con atributos)
    int 10h
    
               

    add dl, 80 	   ;columna 78 en pixeles
    mov ah, 02h   	;Muevo el cursor a la ultima columna
    int 10h
    
    
    
    inc si
    cmp si, 15 		;elijo hasta qué fila llega el primer color
   jnz color2



   color3:           ;repite color
    inc dh 				;empieza desde la fila anterior
    xor dl, dl 		
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 06h      ;Asigno el color (naranja)
    mov cx, 80   		
    mov al, 32   		
    mov ah,09h   		
    int 10h
    
               

    add dl, 80 	   
    mov ah, 02h   	
    int 10h
    
    
    
    inc si
    cmp si, 17 		
   jnz color3

   color4:           ;repite color
    inc dh 				;empieza desde la fila anterior
    xor dl, dl 		
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 03h      ;Asigno el color (cyan)
    mov cx, 80   		
    mov al, 32   		
    mov ah,09h   		
    int 10h
    
               

    add dl, 80 	   
    mov ah, 02h   	
    int 10h
    
    
    
    inc si
    cmp si, 22 		
   jnz color4

   color5:           ;repite color
    inc dh 				;empieza desde la fila anterior
    xor dl, dl 		
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 06h      ;Asigno el color (naranja)
    mov cx, 80   		
    mov al, 32   		
    mov ah,09h   		
    int 10h
    
               

    add dl, 80 	   
    mov ah, 02h   	
    int 10h
    
    
    
    inc si
    cmp si, 23 		
   jnz color5

   color6:           ;repite color
    inc dh 				;empieza desde la fila anterior
    xor dl, dl 		
    mov ah, 02h 
    int 10h
    
    inc dl
    mov ah, 02h  		;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 03h      ;Asigno el color (cyan)
    mov cx, 80   		
    mov al, 32   		
    mov ah,09h   		
    int 10h
    
               

    add dl, 80 	   
    mov ah, 02h   	
    int 10h
    
    
    
    inc si
    cmp si, 24 		
   jnz color6

	    mov dx, 0300h
	    mov ax,0200h
	    int 10h
	    mov ah, 09h
	    mov dx, offset s1
	    int 21h
	    mov dx, offset s2
	    int 21h
	    mov dx, offset s3
	    int 21h
	    mov dx, offset s4
	    int 21h
	    mov dx, offset s5
	    int 21h
	    mov dx, offset s6
	    int 21h
	    mov dx, offset s7
	    int 21h
	    mov dx, offset s8
	    int 21h
	    mov dx, offset s9
	    int 21h
	    mov dx, offset s10
	    int 21h                 ;Termino de mostrar la palabra "Snake"
	    
	    mov dh, 15
	    mov dl, 27              ;Muevo el cursor mas abajo 
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g1              ;Empiezo a mostrar la palabra "Game"
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g2
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g3
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g4
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g5
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g6
	    call print
	    pop dx
	    
	    inc dh
	    mov ah, 02h
	    int 10h
	    
	    push dx
	    lea dx, g7
	    call print
	    pop dx
	    
	    mov ah, 2 
	    mov dh, 22
	    mov dl, 13
	    int 10h 

	    mov dx, offset inst_dificultad1
	    mov ah, 9
	    int 21h

	    mov ah, 2 
	    mov dh, 23
	    mov dl, 11
	    int 10h 

	    mov dx, offset inst_dificultad2
	    mov ah, 9
	    int 21h




	    mov dh, 25
	    xor dl, dl
	    mov ah, 02h     ;Servicio que mueve el cursor
	    int 10h
	    
	    
	    mov ah, 01h     ;Pido caracter unicamente para interrumpir el programa 
	    int 21h
	    cmp al, "1"
	    je Facil
	    cmp al, "2"
	    je Intermedio
	    cmp al, "3"
	    je Dificil
	    jmp DificultadLoop


	    Facil:
	    jmp FinLoopDificultad

	    Intermedio:
	    sub clockgame, 1
	    jmp FinLoopDificultad

	    Dificil:
	    sub clockgame, 2
	    jmp FinLoopDificultad

	    FinLoopDificultad:
	    pop dx
	    pop ax
	    ret
logo endp

	end