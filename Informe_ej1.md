# Lab 1: ARMv8 en System Verilog #

## Integrantes ##

* Arrascaeta Labrador, Valentín.
* Bobbiesi Bender, Sofía Antonella.
* Tolcachir, Marcos.

## Ejercicio 1: Microprocesador con Pipeline ##

### Objetivos del ejercicio ###

Como consigna se pidió implementar modificaciones sobre un procesador con pipeline diseñado en ARMv8. A partir del mismo, se debiá ejecutar un código assembly (cargándolo en el módulo `imem.sv` como instrucciones hexadecimales) y verificar el resultado de la salida en el archivo `mem.dump` que es producido al realizar una simulación RTL usando la herramienta Quartus Prime.

Una vez hecho esto, se debía modificar el código assembly original para evitar hazard de datos y de control que afectaran dicha salida.

### Consignas  ###

* Mostrar el contenido de memoria al finalizar la ejecución del  código original (sin el agregado de instrucciones nop).

* Tomar una captura de la pantalla “Wave” de ModelSim de una parte de la ejecución de este código que muestre claramente la ocurrencia de un hazard de datos, a partir del análisis de las señales involucradas.

* Tomar una captura de la pantalla “Wave” de ModelSim de una parte de la ejecución de este código que muestre claramente la ocurrencia de un hazard de control, a partir del análisis de las señales involucradas.

* Mostrar el programa modificado que se utilizó para verificar el comportamiento del procesador (con el agregado de instrucciones nop).

### Resolución ###

Una vez realizados los cambios pertinentes para el correcto funcionamiento del procesador con pipeline se ejecutó el código original que se muestra a continuación:

~~~assembly
Assembly Code version #1

1   STUR X1, [X0, #0] 
2   STUR X2, [X0, #8] 
3   STUR X3, [X16, #0] 
4   ADD X3, X4, X5
5   STUR X3, [X0, #24] 
6   SUB X3, X4, X5
7   STUR X3, [X0, #32] 
8   SUB X4, XZR, X10
9   STUR X4, [X0, #40] 
10   ADD X4, X3, X4
11   STUR X4, [X0, #48] 
12   SUB X5, X1, X3
13   STUR X5, [X0, #56] 
14   AND X5, X10, XZR
15   STUR X5, [X0, #64] 
16   AND X5, X10, X3
17   STUR X5, [X0, #72] 
18   AND X20, X20, X20
19   STUR X20, [X0, #80] 
20   ORR X6, X11, XZR
21   STUR X6, [X0, #88] 
22   ORR X6, X11, X3
23   STUR X6, [X0, #96] 
24   LDUR X12, [X0, #0]
25   ADD X7, X12, XZR
26   STUR X7, [X0, #104] 
27   STUR X12, [X0, #112] 
28   ADD XZR, X13, X14
29   STUR XZR, [X0, #120] 
30   CBZ X0, loop1
31   STUR X21, [X0, #128] 
32   
33   loop1: STUR X21, [X0, #136] 
34       ADD X2, XZR, X1
35   
36   loop2: SUB X2, X2, X1
37       ADD X24, XZR, X1
38       STUR X24, [X0, #144] 
39       ADD X0, X0, X8
40       CBZ X2, loop2
41       STUR X30, [X0, #144] 
42       ADD X30, X30, X30
43       SUB X21, XZR, X21
44       ADD X30, X30, X20
45       LDUR X25, [X30, #-8]
46       ADD X30, X30, X30
47       ADD X30, X30, X16
48       STUR X25, [X30, #-8] 
49  
50  finlup: CBZ XZR, finlup
~~~

El output en `mem.dump` (en las direcciones 0-21 que son las que nos interesan) de este código sin modificaciones fue:

~~~text
Memoria RAM de Arm:
Address Data
0 0000000000000001
1 0000000000000002
2 0000000000000003
3 0000000000000003
4 0000000000000009
5 0000000000000004
6 FFFFFFFFFFFFFFF6
7 0000000000000005
8 0000000000000002
9 0000000000000001
10 0000000000000014
11 0000000000000006
12 000000000000000B
13 0000000000000007
14 0000000000000001
15 0000000000000000
16 0000000000000015
17 0000000000000015
18 000000000000001E
19 000000000000003C
20 0000000000000000
21 0000000000000000
~~~

Al darnos cuenta que los resultados no eran los esperados (estipulados por la consigna), decidimos reorganizar el código intercambiando instrucciones de lugar y agregando instrucciones NOP en donde nos pareció correcto. El nuevo código quedó como se muestra a continuación:

~~~assembly
1    STUR X1, [X0, #0]
2    STUR X2, [X0, #8]
3    STUR X3, [X16, #0]
4    ADD X3, X4, X5
5    ADD XZR, XZR, XZR
6    ADD XZR, XZR, XZR
7    STUR X3, [X0, #24]
8    SUB X3, X4, X5
9    SUB X4, XZR, X10
10    ADD XZR, XZR, XZR
11    STUR X3, [X0, #32]
12    STUR X4, [X0, #40]
13    ADD X4, X3, X4
14    SUB X5, X1, X3
15    ADD XZR, XZR, XZR
16    STUR X4, [X0, #48]
17    STUR X5, [X0, #56]
18    AND X5, X10, XZR
19    ADD XZR, XZR, XZR
20    LDUR X12, [X0, #0]
21    STUR X5, [X0, #64]
22    AND X5, X10, X3
23    AND X20, X20, X20
24    ORR X6, X11, XZR
25    STUR X5, [X0, #72]
26    STUR X20, [X0, #80]
27    STUR X6, [X0, #88]
28    ORR X6, X11, X3
29    ADD X7, X12, XZR
30     ADD XZR, X13, X14
31    STUR X6, [X0, #96]
32    STUR X7, [X0, #104] 
33    STUR X12, [X0, #112] 
34    STUR XZR, [X0, #120]
35    ADD XZR, XZR, XZR 
36    ADD XZR, XZR, XZR
37    CBZ X0, loop1
38    ADD XZR, XZR, XZR 
39    ADD XZR, XZR, XZR
40    STUR X21, [X0, #128]
41
42   loop1:
43       STUR X21, [X0, #136]
44       ADD X2, XZR, X1
45
46   loop2:
47       ADD XZR, XZR, XZR 
48       ADD X24, XZR, X1
49       SUB X2, X2, X1
50       ADD XZR, XZR, XZR
51        ADD XZR, XZR, XZR
52        STUR X24, [X0, #144]
53        ADD X0, X0, X8
54        CBZ X2, loop2
55        ADD XZR, XZR, XZR
56        ADD XZR, XZR, XZR
57        STUR X30, [X0, #144] 
58        ADD X30, X30, X30
59        SUB X21, XZR, X21
60        ADD XZR, XZR, XZR
61        ADD X30, X30, X20
62        ADD XZR, XZR, XZR
63        ADD XZR, XZR, XZR
64        LDUR X25, [X30, #-8]
65        ADD X30, X30, X30
66        ADD XZR, XZR, XZR
67        ADD XZR, XZR, XZR
68        ADD X30, X30, X16
69        ADD XZR, XZR, XZR
70        ADD XZR, XZR, XZR
71        STUR X25, [X30, #-8]
72
73    finlup: CBZ XZR, finlup
~~~

El output de este nuevo código, se puede ver a continuación.

~~~text
0 0000000000000001
1 0000000000000002
2 0000000000000003
3 0000000000000009
4 FFFFFFFFFFFFFFFF
5 FFFFFFFFFFFFFFF6
6 FFFFFFFFFFFFFFF5
7 0000000000000002
8 0000000000000000
9 000000000000000A
10 0000000000000014
11 000000000000000B
12 FFFFFFFFFFFFFFFF
13 0000000000000001
14 0000000000000001
15 0000000000000000
16 0000000000000000
17 0000000000000015
18 0000000000000001
19 0000000000000001
20 000000000000001E
21 000000000000000A
~~~

Si lo comparamos con el output anterior, claramente podemos ver como afectan los hazards al comportamiento y salida del programa. Para solucionarlos, utilizamos un patron de análisis que consta de estos dos métodos:

* Donde sea posible agrupar ADD/SUB/STUR/AND que no involucren los mismos registros. El problema era que se modificaba un registro y automaticamente despues se guardaba en memoria. Un ejemplo de esto se puede ver en las líneas 10 y 11 del código original con el registro X4.
En este nuevo código, se reemplazó por las líneas 13-16 agregando operaciones con otros registros para así ganar tiempo antes del STUR

* Si no es posible el método anterior, agregar instrucciones NOP (ADD XZR, XZR, XZR) para así esperar a que el registro se actualice correctamente (Por ejemplo en las líneas 5 y 6)

Finalmente, como el método de resolución hizo que se necesiten más de 64 instrucciones, se extendió el módulo `imem.sv` a 128 palabras para que se pueda cargar correctamente el código sin hazards.

La extensión se realizó agregando un bit mas a la entrada `addr` (hacia arriba, es decir que en vez de ser un arreglo de `[7:2]` ahora va de `[8:2]`) y declarando el arreglo `ROM` desde `[0:127]` dejando así los 128 lugares para las palabras de 32 bits. También se modificó la conexión en `processor_arm.sv` cambiando el tamaño de `addr`.

