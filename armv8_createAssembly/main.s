/* .data
N = .dword 0x40
*/
	.text
	.org 0x0000
	ADD XZR, XZR, XZR
	ADDS X0, X0, X0
	B.EQ eq
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	CBZ XZR, fail
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	
eq:
	STUR X0, [X0, #0]
	ADDS X0, X0, X8
	B.NE ne
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	CBZ XZR, fail
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

ne:
	STUR X0, [X0, #0]
	ADD X0, X0, X8
lo:	ADDS X30, X30, X30
	B.HS hs
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	B.LO lo
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

hs: 
	STUR X30, [X0, #0]
	SUBS X30, X30, X1
	ADD X0, X0, X8
	B.MI mi
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	CBZ XZR, fail
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
mi:
	STUR X0, [X0, #0]
	ADDS X0, X0, X8
	B.PL pl
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	CBZ XZR, fail
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
pl:
	STUR X0, [X0, #0]
	ADD X0, X0, X8
vc:	ADDS X30, X30, X30
	B.VS vs
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	B.VC vc
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
vs:
	STUR X30, [X0, #0]
	ADD X0, X0, X8
ls:	ADDS X30, X30, X30
	B.HI hi
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	B.LS ls
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

hi: 
	STUR X30, [X0, #0]
fail:
	finlup: CBZ XZR, finlup
