! Suma de vectores: W = U + V
suma_vect:
    ld [%i1], %l0     ! Cargar primer elemento de U en %l0
    ld [%i2], %l1     ! Cargar primer elemento de V en %l1
    add %l0, %l1, %l2 ! Sumar U + V y almacenar en %l2
    st %l2, [%i3]     ! Guardar el resultado en W
    retl
    nop

! Escalamiento de vector: W = K * U
escala_vect:
    ld [%i1], %l0     ! Cargar primer elemento de U en %l0
    mov %i2, %l1      ! Cargar escalar K en %l1
    mulx %l0, %l1, %l2 ! Multiplicar U * K
    st %l2, [%i3]     ! Guardar el resultado en W
    retl
    nop

! División escalar de vector: W = U / K
vector_sobre_esc:
    ld [%i1], %l0     ! Cargar primer elemento de U en %l0
    mov %i2, %l1      ! Cargar escalar K en %l1
    sdivx %l0, %l1, %l2 ! Dividir U / K
    st %l2, [%i3]     ! Guardar el resultado en W
    
acumula_pasos:
    ! %i0: número de elementos de los vectores
    ! %i1: dirección de memoria de Pos_i
    ! %i2: dirección de memoria de V_i
    ! %i3: escalar KV
    ! %i4: escalar Paso
    ! %i5: escalar t

    ! %o0: número de elementos del vector
    ! %o1: número de vectores retornados
    ! %o2: dirección de memoria de la lista

    mov %i4, %o0  ! Inicializa índice paso en %o0

ciclo:
    subcc %o0, 1, %o0  ! Decrementa el índice paso
    be fin             ! Si llega a cero, termina
    nop                ! Relleno de pipeline

    mov %i2, %i1       ! Mueve la dirección de V_i a %i1
    mov %i3, %i2       ! Mueve KV a %i2
    set ? , %i3        ! Falta definir el valor de %i3 (¿dirección de memoria?)

    call escala_vect   ! Llama a la función escala_vect
    nop                ! Relleno de pipeline

fin:
    retl               ! Retorno de la función
    nop
