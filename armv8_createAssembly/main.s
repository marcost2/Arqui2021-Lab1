/* .data
N = .dword 0x40
*/
	.text
	.org 0x0000
	ADD XZR, XZR, XZR
    STUR X0, [X0, #0]
	ADD	x9, XZR, x17
	ADD	x10, XZR, XZR

Loop:
    ADD X10, x10, x16
	SUB x9, x9, x1
	cbz x9, End
	cbz xzr, Loop

End:
    STUR X10, [X0, #0]

Infloop:
    CBZ XZR, Infloop
