.8086
.model small
.stack 100h
.data
	    ;dos matrices, representan posiciones del cuerpo
	snakei db 10, 10, 10, 225 dup(0);reservo 225 valores adicionales
    snakej db 25, 26, 27, 177 dup(0);reservo 177 valores adicionales 

    
	movimiento dw 0001h ;W S A D
    
	;COORDENADAS
	headI db ?
    headJ db ?
    tailI db ? 
    tailJ db ?
	
    sizeofSnake dw 3
	
    puntaje db 'Score: ', '$'
	
	;INSTRUCCIONES a mostrar en pantalla
    inst_comenzar db '         Presiona espacio para comenzar        ', '$'
    inst_pausa db '           Presiona espacio para continuar...  ', '$'
    inst_controles db  '             Espacio->Pausa, Esc->Cerrar juego             ', '$'
    inst_final db  '          Gracias por jugar ;). apreta cualquier tecla para salir          ', '$'
		
	

.code

extrn logo:proc
extrn print:proc
extrn deltaTime:proc
extrn bandera:proc
;Imprime en pantalla, recibe por dx

;-------------------------------------------------

;randomizer para el spawn de la fruta

randomizer proc
    ;guardo registros
	 push ax
    push cx
    push dx
    
	;randomizer-->numeros aleatorios
    try_again:
    mov ah, 00h        
    int 1Ah      
	
	;calculo coordenada X
    mov ax, dx
    xor ah, ah      
    xor dx, dx         
    xor cx, cx      
    mov cx, 21      
   div cx          
  inc dl      
    push dx
    
	;generacion de ticks para coordenada Y
    mov ah, 00h        
    int 1Ah    

	;calculo coordenada Y
   mov ax, dx
    xor ah, ah
    xor dx, dx
    xor cx, cx
    mov cx, 78
    div cx
    inc dl
    
	;combinacion y muestreo
	;coordenada en screen
    pop ax
    mov ch, al  ;Fila
    mov cl, dl  ;Columna
    mov dx, cx    
    mov ah,02h  ;Muevo el cursor
    int 10h
    
	;compruebo contenido en screen
    mov ah,08h
    int 10h 
    cmp al, 02ah
    jz try_again
    
	;coloco el nuevo char y restauro registros
    mov dx, cx
    mov ah, 02h
    int 10h
    mov cx, 1
    mov al, 0feh
    mov bl, 06h
    mov ah, 09h
    int 10h
    
   pop dx
    pop cx
    pop ax
    ret
randomizer endp
;-------------------------------------------------

;regToAscii para mostrar el score
regToAsciiScore proc
    ;guardo registros
	push ax
    push bx
    push cx
    push dx
    
	;conversion
    mov bx, 10
    xor cx, cx
	;descompongo números en dígitos
tostack:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz tostack
	;extraigo y muestro 
fromstack:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop fromstack
	
	;restauro registros y retorno. Chévere, no?
    pop dx
    pop cx
    pop bx
    pop ax
    ret
regToAsciiScore endp
;_______________________________________




drawUI proc
    ;ya basta meryjein, ya sabes que guardo los registros
    push ax
    push bx
    push cx
    push dx
    
    ;configuro video mode
    ;pensamos en usar el 320x200 como la SEGA
    ;pero en este grupo no bancamos el flickering
    ;así que usamos resolución 80x25 (además es
    ;más fácil de trabajar)
    mov ah,00h
    mov al,02h
    int 10h

    mov ax, 3            ;Lee la posicion actual del cursor
    int 10h
    
    ;configuramos cursor y borde superior
    mov ah, 01h          
    mov ch, 20h          ;Asigna forma de cursor, CH fila iniciaal del scan 
    int 10h

    mov bl, 03h         ; Atributo: texto cian, fondo negro

    ;Dibujo Borde superior
    xor dx,dx
    
    mov cx, 80           ;Numero de veces que se printea el caracter
    mov al, 0DBh        
    mov ah, 09h         ;Servicio que escribe un caracter en la posicion del vector
    int 10h
    
    ;bordes verticales
    xor dx,dx
    xor si, si
    mov si,1
    ;fila 1 a 24
    cycl:
    inc dh ;aumenta posicion en fila
    xor dl, dl ;coloca cursor en columna 0
    mov ah, 02h 
    int 10h
    
    mov bl, 03h
    mov cx, 1
    mov al, 0DBh ;ascii char: █
    mov ah,09h   ;Mueve el cursor a la fila 0 columna 0
    int 10h
    
    inc dl
    mov ah, 02h  ;Incrementa la columna y mueve el cursor
    int 10h
    
    mov bl, 02h                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;Acá se cambian tanto el color del borde inferior como el de la serpiente
    mov cx, 78   ; Cant de veces que printeo el caracter
    mov al, 32   ; Caracter ASCII 32 (ESPACIO)
    mov ah,09h   ;Servicio para printear caracter 
    int 10h
    
                ;Dibujo un █ en Col 0 Row 0 y espacios en Row 0 Col N

    add dl, 78 ;columna 78 en pixeles
    mov ah, 02h ;Muevo el cursor a la ultima columna
    int 10h
    
    mov bl, 03h
    mov cx, 1    ;Termino la primer fila
    mov al, 0DBh ;ascii char: █
    mov ah, 09h
    int 10h
    
    inc si
    cmp si, 24 ;hasta fila 24
    jnz cycl
    ;Resumido, va iterando en cada fila poniendo un █ en la primer y ultima columna y un espacio en el medio
    ;borde inferior
    inc dh 
    xor dl, dl 
    mov ah, 02h     ;Mueve el cursor a la ultima columna primer fila
    int 10h
    
    mov bl, 03h
    mov cx, 80      ;Veces que va a printear
    mov al, 0DBh    ;Caracter
    mov ah, 09h     ;Servicio para printear caracter en cursor
    int 10h
    
    mov dh, 22      ;DH FILA
    mov dl, 0       ;DL COLUMNA
    mov ah, 02h     ;Muevo el cursor
    int 10h
    
    mov bl, 03h
    mov cx, 80
    mov al, 0DBh
    mov ah, 09h
    int 10h


    
    ;mostrar puntaje en screen
    mov dh, 23
    mov dl, 2
    mov ah, 02h
    int 10h
    
    lea dx, puntaje
    call print
    
    ;mostrar valor del puntaje
    mov ax, sizeofSnake
    sub ax, 3
    call regToAsciiScore
    
    ;Mostrar mensajes en pantalla
    mov dh, 23
    mov dl, 14
    mov ah, 02h
    int 10h
    
    mov bl, 03h
    mov cx, 1
    mov al, 0DBh
    mov ah, 09h
    int 10h
    

    inc dl
    mov ah, 02h
    int 10h
    
    push dx
    lea dx, inst_comenzar
    call print
    
    pop dx
    mov ah, 02h
    int 10h
    
    mov ah, 08h
    int 21h
    
    LoopTeclaComenzar:
    mov ah, 00h
    int 16h
    cmp ah, 39h
    jne LoopTeclaComenzar
    xor al, al

    lea dx, inst_controles
    call print
    
    mov dh, 23      ;DH FILA
    mov dl, 79       ;DL COLUMNA
    mov ah, 02h     ;Muevo el cursor
    int 10h
    
    mov bl, 03h
    mov cx, 1
    mov al, 0DBh
    mov ah, 09h
    int 10h

    mov dh, 24      ;DH FILA
    mov dl, 0       ;DL COLUMNA
    mov ah, 02h     ;Muevo el cursor
    int 10h
    
    mov bl, 03h
    mov cx, 80
    mov al, 0DBh
    mov ah, 09h
    int 10h





    ;fin y restauracion de registros
    mov dx, 0A30h
    mov ah, 02h
    int 10h
    
    mov bl, 06h
    mov cx, 1
    mov al, 0feh
    mov ah, 09h
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
drawUI endp

;_______________________________________

;funcion para controlar el delta time
;qué es delta time? El tiempo que tarda en
;renderizar un frame (afecta a la velocidad
;y tiempo de respuesta) 

;_______________________________________
movementInput proc
    ;guardo reg ax
	push ax
    ;leo tecla
	mov ah, 01h             ;Lee el buffer de teclado
    int 16h
    ;verifica si se presiono
	jz movementInput_end
    mov ah, 00h             ;Lee pulsacion de tecla
    int 16h
    NOP
    NOP
    NOP
    
	;Pausa
    check_pause:
    cmp ah, 39h 
    jnz check_esc
    jmp pauseFunc
    
	;Finalizar programa
	check_esc:
    cmp ah, 01h
    jnz check_arrows
    jmp fin
    
	;Flechas: movimiento serpentino
	;¿Por qué no WASD? Porque hay que definir wasd y WASD, es sensible a mayúsculas
	check_arrows:
    cmp ah, 48h
    jz UP
    cmp ah, 50h
    jz DOWN
    cmp ah, 4Bh
    jz LEFT
    cmp ah, 4Dh
    jz RIGHT
    jmp movementInput_end

	;Movimiento serpentino    
UP:
    mov ax, movimiento          ;Movimiento guarda la letra tocada
    test movimiento, 0100h
    jnz movementInput_end
    mov movimiento, 1000h
    jmp movementInput_end
DOWN:
    mov ax, movimiento
    test movimiento, 1000h
    jnz movementInput_end
    mov movimiento, 0100h
    jmp movementInput_end
LEFT:   
    mov ax, movimiento
    test movimiento, 0001h
    jnz movementInput_end
    mov movimiento, 0010h
    jmp movementInput_end
RIGHT:  
    mov ax, movimiento
    test movimiento, 0010h
    jnz movementInput_end
    mov movimiento, 0001h
    jmp movementInput_end


movementInput_end:
    pop ax
    ret
movementInput endp

start:
;inicializo segmento de datos
    MOV AX, @data
    MOV DS, AX 
	
	;llamada a funciones
    call logo    
    call drawUI
    
	;dibujo a la serpiente
    mov cx, sizeofSnake
    mov di, 0                       ;Voy a usar DI para moverme por los dos vectores posicion de la serpiente (Fila y columna)
    
    gameLoop:                   ;Etiqueta que uso para dibujar la serpiente
		mov dh, snakeI[di]        ;Muevo el cursor a la posicion de la serpiente
		mov dl, snakeJ[di]    
		mov ah, 02h
		int 10h
        
		push cx                   
		mov cx, 1
		mov al, 02ah              ;Imprimo una vez el caracter "*" en el offset correspondiente las veces que hagan falta
		mov ah, 0Ah
		int 10h
		pop cx
		inc di
		loop gameLoop            ;Cuando termino de printear hago el delta time para que printee con el timing correcto simulando movimiento
		;si loop no funciona lloro
	;logica del movimiento y
	;actualizacion de la serpiente
	;@@1 etiqueta local          ;Etiqueta donde se corroboran las colisiones
		@@1:
			call deltaTime
			call movementInput
    
		xor si, si
		mov si, sizeofSnake         ;cabeza = Ultima posicion del vector
		mov bl, snakeI[si-1]       ;Posicion X de la cabeza
		mov dl, snakeJ[si-1]       ;Posicion Y de la cabeza
    
		;manejo de la matriz
		mov cx, movimiento    ;Flag que se pisa al llamar a la funcion Movimiento
		upc:
		test cx, 1000h        ; TEST = XOR pero guarda resultado en flag
		jz downc
		sub bl, 1
		downc:
		test cx, 0100h     ;Leo el flag de movimiento y dependiendo de la ultima flechita presionada, desplazo la cabeza para donde corresponda
		jz leftc
		add bl, 1
		leftc:
		test cx, 0010h
		jz rightc
		sub dl, 1
		rightc:
		test cx, 0001h
		jz skip
		add dl, 1
	
	skip:
		mov headI, bl ;    Piso Pos X de cabeza con nueva posicion
		mov headJ, dl ;    Piso Pos Y de cabeza con nueva posicion
    
    
		mov dh, headI
		mov dl, headJ    
		mov ah, 02h           ;Muevo el cursor hacia la cabeza de la serpiente ---- (DEJAMOS LA A PARA Q NO EXPLOTE; CONSIDERAMOS SACAR) ----BORRAR ----BORRAR ----BORRAR----
		int 10h
		;manejo de colisiones
		mov ah, 08h           ;Lee el caracter que está en la posicion del cursor (Ahora mismo el cursor almacena la cabeza de la serpiente)
		int 10h               ;Y lo almacena en AL
    
		cmp al, 2Ah      ;Si la cabeza coincide con un "*" 
		jnz edges          ;Si la cabeza no choca con el cuerpo, va a revisar si choca con los bordes 
		jmp fin         ;Si la cabeza choca con el cuerpo, perdiste
		edges:
		cmp al, 0DBh    ;Si la cabeza coincide con el caracter ASCII del borde  
		jnz f00d        ;Si la cabeza NO coincide con el borde, chequea si colisiona con la "fruta"
		jmp fin         ;Si la cabeza coincide con el borde, perdiste
		f00d:
		cmp al, 0feh    ;Compara la posicion de la cabeza con el ASCII de la fruta
		jnz next        ;Si la cabeza NO coincide con la fruta, salta
		mov bx, sizeofSnake   ;Si la cabeza coincide con la fruta, incremento en 1 la posicion 
		xor bh, bh
		inc bx                ;Se suma 1 al Size of Snake
		mov sizeofSnake, bx   ;Nuevo Size of Snake = Size + 1
		mov al, headI         ;Guardo en AL la pos X de la cabeza
		mov snakeI[bx-1], al     ;Guardo en la nueva cabeza, la posicion anterior de la cabeza
		mov al, headJ
		mov snakeJ[bx-1], al     ;Repito para posicion en Y
		;actualización y visualización
		mov dh, snakeI[bx-1]
		mov dl, snakeJ[bx-1]        ;Muevo el cursor a la nueva cabeza  
		mov ah, 02h
		int 10h
		mov ah, 09h                 ;Printea un asterisco en la nueva posicion de la cabeza
		mov cx, 1
        mov bl, 02h
        ;mov dl, 2Ah
        mov al, 02ah
		int 10h
    
      call randomizer
		;int 87h ;llamo al randomizer para generar una nueva fruta 
    
		mov dh, 23
		mov dl, 9
		mov ah, 02h        ;Muevo el cursor a donde se va a mostrar el Score
		int 10h
		mov ax, sizeofSnake   ;Me traigo el tamaño actual de la seripiente a AX 
		sub ax, 3             ;Le resto el tamaño iniciail
		call regToAsciiScore  ;Printeo
    
		jmp @@1
		next:		
		
		;TODO
		    mov al, snakeI[0]      ;Guardo en AL la cola actual
    mov tailI, al       ;guardo la cola anterior
    mov al, snakeJ[0]    ;Piso la nueva cola con la anterior
    mov tailJ, al

    mov cx, sizeofSnake
    xor ch, ch
    mov di, 0
    reSet_body:
        mov   al, snakeI[di+1]
        mov   snakeI[di], al
        
        mov   al, snakeJ[di+1]
        mov   snakeJ[di], al
        inc di
    loop reSet_body
    
    mov bx, sizeofSnake      ;seteo nuevas coordenadas 
    xor bh, bh
    mov al, headI
    mov   snakeI[bx-1], al
    mov al, headJ
    mov   snakeJ[bx-1], al
    
    push ax
    push dx
    mov dh, snakeI[bx-1]
    mov dl, snakeJ[bx-1]      
    mov ah, 02h
    int 10h
    mov ah, 02h
    mov dl, 2Ah
    int 21h
    pop dx 
    pop ax
    
    push ax
    push dx
    mov dh, tailI
    mov dl, tailJ       
    mov ah, 02h
    int 10h
    mov ah, 02h
    mov dl, 20h
    int 21h
    pop dx 
    pop ax
		
		
		
	jmp @@1
	;Pausa y mensajes finales
    pauseFunc:
    mov dh, 23
    mov dl, 15
    mov ah, 02h
    int 10h
    push dx
    lea dx, inst_pausa      ;Printeo cartel de pausa
    call print
    
    lecturaTeclaPausa:

    mov ah, 00h             ;Pido una tecla
    int 16h
    cmp ah, 39h
    jne lecturaTeclaPausa


    sigueLaPausa:
    pop dx
    mov ah, 02h             ;Muevo el cursor
    int 10h                 ;COMPARTEN OFFSET LOS 2 TEXTOS, EL DE PAUSA Y EL NORMAL
    mov ah, 09h             ;
    lea dx, inst_controles  ; 
    call print
    jmp @@1
    
    fin:
    int 83h
    mov dh, 10
    mov dl, 2
    mov ah, 02h
    int 10h
    push dx
    lea dx, inst_final
    call print

    call bandera

    

    mov ah, 08h
    int 21h
    xor dx, dx
    mov ah, 02h 
    int 10h
    mov ax, 3
    int 10h
    MOV AH, 4Ch
    INT 21h
end start