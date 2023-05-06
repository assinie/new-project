
;----------------------------------------------------------------------
;			includes cc65
;----------------------------------------------------------------------
.feature string_escapes

.include "telestrat.inc"
.include "fcntl.inc"

XMAINARGS = $2C
XGETARGV = $2E

;----------------------------------------------------------------------
;			includes SDK
;----------------------------------------------------------------------
.include "SDK.mac"
.include "types.mac"

;----------------------------------------------------------------------
;			include application
;----------------------------------------------------------------------

;----------------------------------------------------------------------
;				imports
;----------------------------------------------------------------------

;----------------------------------------------------------------------
;				exports
;----------------------------------------------------------------------
.export _main

;----------------------------------------------------------------------
;                       Segments vides
;----------------------------------------------------------------------
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"

;----------------------------------------------------------------------
;			Defines / Constantes
;----------------------------------------------------------------------
VERSION = $20232011
.define PROGNAME "hello"

;----------------------------------------------------------------------
;				Variables
;----------------------------------------------------------------------
.pushseg
	.segment "DATA"
		unsigned short _argv
		unsigned char _argc
		unsigned short argn

.popseg

;----------------------------------------------------------------------
;			Programme principal
;----------------------------------------------------------------------
.segment "CODE"



;----------------------------------------------------------------------
;
; Entrée:
;
; Sortie:
;
; Variables:
;	Modifiées:
;		-
;	Utilisées:
;		-
; Sous-routines:
;	-
;----------------------------------------------------------------------
.proc _main

	get_args:
		initmainargs _argv, _argc
		dec	_argc
		bne	main

		jsr	cmnd_version

		print	noarg_msg

		mfree	(_argv)

		rts

	main:
		getmainarg #1, (_argv), argn

		print	hello_msg

		print	(argn)

		crlf

		mfree	(_argv)

		rts
.endproc


;----------------------------------------------------------------------
;
; Entrée:
;
; Sortie:
;
; Variables:
;	Modifiées:
;		-
;	Utilisées:
;		-
; Sous-routines:
;	-
;----------------------------------------------------------------------
.proc cmnd_version
		.out   .sprintf("%s version %x.%x - %x.%x", PROGNAME, (::VERSION & $ff0)>>4, (::VERSION & $0f), ::VERSION >> 16, (::VERSION & $f000)>>12)

		prints	.sprintf("%s version %x.%x - %x.%x", PROGNAME, (::VERSION & $ff0)>>4, (::VERSION & $0f), ::VERSION >> 16, (::VERSION & $f000)>>12)
		crlf

		rts
.endproc

;----------------------------------------------------------------------
;			Chaines statiques
;----------------------------------------------------------------------
.pushseg
	.segment "RODATA"
		noarg_msg:
			.asciiz "Aucun argument\r\n"

		hello_msg:
			.asciiz "Hello "
.popseg
