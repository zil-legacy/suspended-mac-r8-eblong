

	.FUNCT	PARSER,PTR=P-LEXSTART,WORD,VAL=0,VERB=0,LEN,DIR=0,NW=0,LW=0,NUM,SCNT,CNT=-1
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	PUT	P-ITBL,CNT,0
	JUMP	?PRG1
?REP2:	SET	'P-ADVERB,0
	SET	'P-OADJ,0
	SET	'P-ADJECTIVE,0
	SET	'P-MERGED,0
	PUT	P-PRSO,P-MATCHLEN,0
	PUT	P-PRSI,P-MATCHLEN,0
	PUT	P-BUTS,P-MATCHLEN,0
	ZERO?	P-CONT /?ELS10
	SET	'PTR,P-CONT
	SET	'P-CONT,0
	EQUAL?	PRSA,V?$TELL /?CND8
	CRLF	
	JUMP	?CND8
?ELS10:	GRTR?	P-NACTORS,1 \?ELS16
	CALL	ACTOR-CHANGE
	ZERO?	STACK /?ELS16
	PUTB	P-LEXV,P-LEXWORDS,P-OPLEN
	SET	'PTR,P-OPCONT
	JUMP	?CND8
?ELS16:	SET	'OLD-WINNER,WINNER
	SET	'QUOTE-FLAG,0
	ZERO?	SETUP-MODE \?ELS23
	CRLF	
	JUMP	?CND21
?ELS23:	SET	'VERB,ACT?WALK
	PUT	P-ITBL,P-VERB,ACT?WALK
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,0
	PUT	P-ITBL,P-PREP1,PR?TO
	PUT	P-ITBL,P-PREP1N,W?TO
?CND21:	EQUAL?	WINNER,TWOBOTS \?CND26
	GET	P-ACTORS,1
	CALL	CHANGE-WINNER,STACK
	CRLF	
?CND26:	GETB	0,1
	BAND	STACK,16
	ZERO?	STACK /?CND29
	PRINTI	"(FC linked to "
	CALL	NDESC,WINNER
	PRINTI	")"
?CND29:	PRINTI	">"
	READ	P-INBUF,P-LEXV
?CND8:	GETB	P-LEXV,P-LEXWORDS >P-LEN
	ZERO?	P-LEN \?CND36
	PRINTI	"FC: Communication meaningless."
	CRLF	
	RFALSE	
?CND36:	SET	'LEN,P-LEN
	SET	'P-DIR,0
	SET	'P-NCN,0
	SET	'P-GETFLAGS,0
	SET	'P-TWOBOTS,0
?PRG41:	DLESS?	'P-LEN,0 \?ELS45
	SET	'QUOTE-FLAG,0
	JUMP	?REP42
?ELS45:	GET	P-LEXV,PTR >WORD
	ZERO?	WORD \?THN48
	CALL	NUMBER?,PTR >WORD
	ZERO?	WORD /?ELS47
?THN48:	EQUAL?	WORD,W?BOTH,W?TOGETHER \?ELS52
	SET	'P-TWOBOTS,1
	JUMP	?CND50
?ELS52:	EQUAL?	WORD,W?TO \?ELS54
	EQUAL?	VERB,ACT?$TELL \?ELS54
	SET	'WORD,W?QUOTE
	JUMP	?CND50
?ELS54:	EQUAL?	WORD,W?THEN \?CND50
	ZERO?	VERB \?CND50
	PUT	P-ITBL,P-VERB,ACT?$TELL
	PUT	P-ITBL,P-VERBN,0
	SET	'WORD,W?QUOTE
?CND50:	EQUAL?	WORD,W?THEN,W?. /?THN64
	EQUAL?	WORD,W?QUOTE \?ELS63
?THN64:	EQUAL?	WORD,W?QUOTE \?CND66
	ZERO?	QUOTE-FLAG /?ELS71
	SET	'QUOTE-FLAG,0
	JUMP	?CND66
?ELS71:	SET	'QUOTE-FLAG,1
?CND66:	ZERO?	P-LEN /?THN75
	ADD	PTR,P-LEXELEN >P-CONT
?THN75:	PUTB	P-LEXV,P-LEXWORDS,P-LEN
	JUMP	?REP42
?ELS63:	CALL	WT?,WORD,PS?DIRECTION,P1?DIRECTION >VAL
	ZERO?	VAL /?ELS78
	EQUAL?	LEN,1 /?THN81
	EQUAL?	LEN,2 \?ELS84
	EQUAL?	VERB,ACT?WALK /?THN81
?ELS84:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	EQUAL?	NW,W?THEN,W?QUOTE \?ELS86
	EQUAL?	VERB,ACT?WALK \?ELS86
	GRTR?	LEN,2 /?THN81
?ELS86:	EQUAL?	NW,W?. \?ELS88
	EQUAL?	VERB,ACT?WALK,0 \?ELS88
	GRTR?	LEN,1 /?THN81
?ELS88:	ZERO?	QUOTE-FLAG /?ELS90
	EQUAL?	LEN,2 \?ELS90
	EQUAL?	NW,W?QUOTE /?THN81
?ELS90:	GRTR?	LEN,2 \?ELS78
	EQUAL?	VERB,ACT?WALK \?ELS78
	EQUAL?	NW,W?COMMA,W?AND \?ELS78
?THN81:	SET	'DIR,VAL
	EQUAL?	NW,W?COMMA,W?AND \?CND93
	ADD	PTR,P-LEXELEN
	PUT	P-LEXV,STACK,W?THEN
?CND93:	GRTR?	LEN,2 /?CND43
	SET	'QUOTE-FLAG,0
	JUMP	?REP42
?ELS78:	CALL	WT?,WORD,PS?VERB,P1?VERB >VAL
	ZERO?	VAL /?ELS100
	ZERO?	VERB \?ELS100
	SET	'VERB,VAL
	PUT	P-ITBL,P-VERB,VAL
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,WORD
	MUL	PTR,2
	ADD	STACK,2 >NUM
	GETB	P-LEXV,NUM
	PUTB	P-VTBL,2,STACK
	ADD	NUM,1
	GETB	P-LEXV,STACK
	PUTB	P-VTBL,3,STACK
	JUMP	?CND43
?ELS100:	CALL	WT?,WORD,PS?PREPOSITION,0 >VAL
	ZERO?	VAL \?THN105
	EQUAL?	WORD,W?ALL,W?ONE,W?A /?THN109
	EQUAL?	WORD,W?BOTH /?THN109
	CALL	WT?,WORD,PS?ADJECTIVE
	ZERO?	STACK \?THN109
	CALL	WT?,WORD,PS?OBJECT
	ZERO?	STACK /?ELS104
?THN109:	SET	'VAL,0
?THN105:	GRTR?	P-LEN,0 \?ELS113
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?OF \?ELS113
	ZERO?	VAL \?ELS113
	EQUAL?	WORD,W?ALL,W?ONE,W?A /?ELS113
	EQUAL?	WORD,W?BOTH /?ELS113
	JUMP	?CND43
?ELS113:	ZERO?	VAL /?ELS117
	ZERO?	P-LEN /?THN120
	ADD	PTR,2
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?THEN,W?. \?ELS117
?THN120:	LESS?	P-NCN,2 \?CND43
	PUT	P-ITBL,P-PREP1,VAL
	PUT	P-ITBL,P-PREP1N,WORD
	JUMP	?CND43
?ELS117:	EQUAL?	P-NCN,2 \?ELS126
	PRINTI	"FC: I found too many nouns in that sentence."
	CRLF	
	RFALSE	
?ELS126:	INC	'P-NCN
	CALL	CLAUSE,PTR,VAL,WORD >PTR
	ZERO?	PTR /FALSE
	LESS?	PTR,0 \?CND43
	SET	'QUOTE-FLAG,0
	JUMP	?REP42
?ELS104:	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS137
	JUMP	?CND43
?ELS137:	CALL	CANT-USE,PTR
	RFALSE	
?ELS47:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND43:	SET	'LW,WORD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG41
?REP42:	ZERO?	DIR /?CND142
	SET	'PRSA,V?WALK
	SET	'PRSO,DIR
	SET	'P-WALK-DIR,DIR
	RTRUE	
?CND142:	SET	'P-WALK-DIR,0
	ZERO?	P-OFLAG /?CND146
	CALL	ORPHAN-MERGE
?CND146:	CALL	SYNTAX-CHECK
	ZERO?	STACK /FALSE
	CALL	SNARF-OBJECTS
	ZERO?	STACK /FALSE
	CALL	TAKE-CHECK
	ZERO?	STACK /FALSE
	CALL	MANY-CHECK
	ZERO?	STACK /FALSE
	RTRUE


	.FUNCT	ACTOR-CHANGE
?PRG1:	LESS?	P-NACTORS,2 /FALSE
	INC	'P-CACTOR
	CRLF	
	DEC	'P-NACTORS
	GET	P-ACTORS,P-CACTOR
	CALL	CHANGE-WINNER,STACK
	ZERO?	STACK /?PRG1
	RTRUE	


	.FUNCT	WT?,PTR,BIT,B1=5,OFFST=P-P1OFF,TYP
	GETB	PTR,P-PSOFF >TYP
	BTST	TYP,BIT \FALSE
	GRTR?	B1,4 /TRUE
	BAND	TYP,P-P1BITS >TYP
	EQUAL?	TYP,B1 /?CND13
	INC	'OFFST
?CND13:	GETB	PTR,OFFST
	RSTACK	


	.FUNCT	CLAUSE,PTR,VAL,WORD,OFF,NUM,ANDFLG=0,FIRST??=1,NW,LW=0,?TMP1
	SUB	P-NCN,1
	MUL	STACK,2 >OFF
	ZERO?	VAL /?ELS3
	ADD	P-PREP1,OFF >NUM
	PUT	P-ITBL,NUM,VAL
	ADD	NUM,1
	PUT	P-ITBL,STACK,WORD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND1
?ELS3:	INC	'P-LEN
?CND1:	ZERO?	P-LEN \?CND6
	DEC	'P-NCN
	RETURN	-1
?CND6:	ADD	P-NC1,OFF >NUM
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,NUM,STACK
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?THE,W?A,W?AN \?CND9
	GET	P-ITBL,NUM
	ADD	STACK,4
	PUT	P-ITBL,NUM,STACK
?CND9:	
?PRG12:	DLESS?	'P-LEN,0 \?CND14
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	-1
?CND14:	GET	P-LEXV,PTR >WORD
	ZERO?	WORD \?THN20
	CALL	NUMBER?,PTR >WORD
	ZERO?	WORD /?ELS19
?THN20:	ZERO?	P-LEN \?ELS24
	SET	'NW,0
	JUMP	?CND22
?ELS24:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
?CND22:	EQUAL?	WORD,W?AND,W?COMMA \?ELS29
	SET	'ANDFLG,1
	JUMP	?CND17
?ELS29:	EQUAL?	WORD,W?ALL,W?BOTH,W?ONE \?ELS31
	EQUAL?	NW,W?OF \?CND17
	DEC	'P-LEN
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND17
?ELS31:	EQUAL?	WORD,W?THEN,W?. /?THN37
	CALL	WT?,WORD,PS?PREPOSITION
	ZERO?	STACK /?ELS36
	ZERO?	FIRST?? \?ELS36
?THN37:	INC	'P-LEN
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	SUB	PTR,P-LEXELEN
	RETURN	STACK
?ELS36:	ZERO?	ANDFLG /?ELS42
	CALL	WT?,WORD,PS?DIRECTION
	ZERO?	STACK \?THN45
	CALL	WT?,WORD,PS?VERB
	ZERO?	STACK /?ELS42
?THN45:	SUB	PTR,4 >PTR
	ADD	PTR,2
	PUT	P-LEXV,STACK,W?THEN
	ADD	P-LEN,2 >P-LEN
	JUMP	?CND17
?ELS42:	CALL	WT?,WORD,PS?OBJECT
	ZERO?	STACK /?ELS48
	CALL	WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE
	ZERO?	STACK /?ELS51
	ZERO?	NW /?ELS51
	CALL	WT?,NW,PS?OBJECT
	ZERO?	STACK /?ELS51
	JUMP	?CND17
?ELS51:	ZERO?	ANDFLG \?ELS55
	EQUAL?	NW,W?BUT,W?EXCEPT /?ELS55
	EQUAL?	NW,W?AND,W?COMMA /?ELS55
	ADD	NUM,1 >?TMP1
	ADD	PTR,2
	MUL	STACK,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	PTR
?ELS55:	SET	'ANDFLG,0
	JUMP	?CND17
?ELS48:	CALL	WT?,WORD,PS?ADJECTIVE
	ZERO?	STACK \?CND17
	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS61
	JUMP	?CND17
?ELS61:	CALL	WT?,WORD,PS?PREPOSITION
	ZERO?	STACK /?ELS65
	JUMP	?CND17
?ELS65:	CALL	CANT-USE,PTR
	RFALSE	
?ELS19:	CALL	UNKNOWN-WORD,PTR
	RFALSE	
?CND17:	SET	'LW,WORD
	SET	'FIRST??,0
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG12


	.FUNCT	NUMBER?,PTR,CNT,BPTR,CHR,SUM=0,TIM=0,?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,2 >CNT
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,3 >BPTR
?PRG1:	DLESS?	'CNT,0 \?ELS5
	JUMP	?REP2
?ELS5:	GETB	P-INBUF,BPTR >CHR
	EQUAL?	CHR,58 \?ELS10
	SET	'TIM,SUM
	SET	'SUM,0
	JUMP	?CND8
?ELS10:	GRTR?	SUM,10000 /FALSE
	LESS?	CHR,58 \FALSE
	GRTR?	CHR,47 \FALSE
	MUL	SUM,10 >?TMP1
	SUB	CHR,48
	ADD	?TMP1,STACK >SUM
?CND8:	INC	'BPTR
	JUMP	?PRG1
?REP2:	PUT	P-LEXV,PTR,W?INTNUM
	GRTR?	SUM,1000 /FALSE
	ZERO?	TIM /?CND19
	LESS?	TIM,8 \?ELS27
	ADD	TIM,12 >TIM
	JUMP	?CND25
?ELS27:	GRTR?	TIM,23 /FALSE
?CND25:	MUL	TIM,60
	ADD	SUM,STACK >SUM
?CND19:	SET	'P-NUMBER,SUM
	RETURN	W?INTNUM


	.FUNCT	ORPHAN-MERGE,CNT=-1,TEMP,VERB,BEG,END,ADJ=0,WRD,?TMP1
	SET	'P-OFLAG,0
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB /?ELS3
	GET	P-OTBL,P-VERB
	EQUAL?	VERB,STACK \FALSE
?ELS3:	EQUAL?	P-NCN,2 /FALSE
	GET	P-OTBL,P-NC1
	EQUAL?	STACK,1 \?ELS9
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP1
	EQUAL?	TEMP,STACK /?THN13
	ZERO?	TEMP \FALSE
?THN13:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC1,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?CND1
?ELS9:	GET	P-OTBL,P-NC2
	EQUAL?	STACK,1 \?ELS18
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP2
	EQUAL?	TEMP,STACK /?THN22
	ZERO?	TEMP \FALSE
?THN22:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC2,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC2L,STACK
	SET	'P-NCN,2
	JUMP	?CND1
?ELS18:	ZERO?	P-ACLAUSE /?CND1
	EQUAL?	P-NCN,1 /?ELS31
	SET	'P-ACLAUSE,0
	RFALSE	
?ELS31:	GET	P-ITBL,P-NC1 >BEG
	GET	P-ITBL,P-NC1L >END
?PRG34:	EQUAL?	BEG,END \?ELS38
	ZERO?	ADJ /?ELS41
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND29
?ELS41:	SET	'P-ACLAUSE,0
	RFALSE	
?ELS38:	ZERO?	ADJ \?ELS46
	GET	BEG,0 >WRD
	GETB	WRD,P-PSOFF
	BTST	STACK,PS?ADJECTIVE \?ELS46
	SET	'ADJ,WRD
	JUMP	?CND36
?ELS46:	GETB	WRD,P-PSOFF
	BTST	STACK,PS?OBJECT /?THN51
	EQUAL?	WRD,W?ONE \?CND36
?THN51:	EQUAL?	WRD,P-ANAM,W?ONE \FALSE
	CALL	ACLAUSE-WIN,ADJ
	JUMP	?CND29
?CND36:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG34
?CND29:	
?CND1:	
?PRG58:	IGRTR?	'CNT,P-ITBLLEN \?ELS62
	SET	'P-MERGED,1
	RTRUE	
?ELS62:	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG58


	.FUNCT	ACLAUSE-WIN,ADJ
	SET	'P-CCSRC,P-OTBL
	ADD	P-ACLAUSE,1
	CALL	CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET	P-OTBL,P-NC2
	ZERO?	STACK /?ELS2
	SET	'P-NCN,2
?ELS2:	SET	'P-ACLAUSE,0
	RTRUE	


	.FUNCT	WORD-PRINT,CNT,BUF
?PRG1:	DLESS?	'CNT,0 /TRUE
	GETB	P-INBUF,BUF
	PRINTC	STACK
	INC	'BUF
	JUMP	?PRG1


	.FUNCT	UNKNOWN-WORD,PTR,BUF,?TMP1
	PRINTI	"FC: I don't know the word '"
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	"'."
	CRLF	
	SET	'QUOTE-FLAG,0
	SET	'P-OFLAG,0
	RTRUE	


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	PRINTI	"FC: I can't use the word '"
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	CALL	WORD-PRINT,?TMP1,STACK
	PRINTI	"' here."
	CRLF	
	SET	'QUOTE-FLAG,0
	SET	'P-OFLAG,0
	RTRUE	


	.FUNCT	SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1=0,DRIVE2=0,PREP,VERB,TMP,?TMP2,?TMP1
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB \?CND1
	PRINTI	"FC: I can't find a verb in that sentence!"
	CRLF	
	RFALSE	
?CND1:	SUB	255,VERB
	GET	VERBS,STACK >SYN
	GETB	SYN,0 >LEN
	ADD	1,SYN >SYN
?PRG6:	GETB	SYN,P-SBITS
	BAND	STACK,P-SONUMS >NUM
	GRTR?	P-NCN,NUM \?ELS10
	JUMP	?CND8
?ELS10:	LESS?	NUM,1 /?ELS12
	ZERO?	P-NCN \?ELS12
	GET	P-ITBL,P-PREP1 >PREP
	ZERO?	PREP /?THN15
	GETB	SYN,P-SPREP1
	EQUAL?	PREP,STACK \?ELS12
?THN15:	SET	'DRIVE1,SYN
	JUMP	?CND8
?ELS12:	GETB	SYN,P-SPREP1 >?TMP1
	GET	P-ITBL,P-PREP1
	EQUAL?	?TMP1,STACK \?CND8
	EQUAL?	NUM,2 \?ELS21
	EQUAL?	P-NCN,1 \?ELS21
	SET	'DRIVE2,SYN
	JUMP	?CND8
?ELS21:	GETB	SYN,P-SPREP2 >?TMP1
	GET	P-ITBL,P-PREP2
	EQUAL?	?TMP1,STACK \?CND8
	CALL	SYNTAX-FOUND,SYN
	RTRUE	
?CND8:	DLESS?	'LEN,1 \?ELS28
	ZERO?	DRIVE1 \?REP7
	ZERO?	DRIVE2 /?ELS31
	JUMP	?REP7
?ELS31:	PRINTI	"FC: I don't understand that sentence."
	CRLF	
	RFALSE	
?ELS28:	ADD	SYN,P-SYNLEN >SYN
	JUMP	?PRG6
?REP7:	ZERO?	DRIVE1 /?ELS44
	GETB	DRIVE1,P-SFWIM1 >?TMP2
	GETB	DRIVE1,P-SLOC1 >?TMP1
	GETB	DRIVE1,P-SPREP1
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS44
	PUT	P-PRSO,P-MATCHLEN,1
	PUT	P-PRSO,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE1
	RSTACK	
?ELS44:	ZERO?	DRIVE2 /?ELS48
	GETB	DRIVE2,P-SFWIM2 >?TMP2
	GETB	DRIVE2,P-SLOC2 >?TMP1
	GETB	DRIVE2,P-SPREP2
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?ELS48
	PUT	P-PRSI,P-MATCHLEN,1
	PUT	P-PRSI,1,OBJ
	CALL	SYNTAX-FOUND,DRIVE2
	RSTACK	
?ELS48:	EQUAL?	VERB,ACT?FIND \?ELS52
	PRINTI	"FC: I can't answer that question."
	CRLF	
	RFALSE	
?ELS52:	ZERO?	SETUP-MODE \FALSE
	CALL	ORPHAN,DRIVE1,DRIVE2
	PRINTI	"FC: What do you want to "
	GET	P-OTBL,P-VERBN >TMP
	ZERO?	TMP \?ELS64
	PRINTI	"tell"
	JUMP	?CND62
?ELS64:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS68
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND62
?ELS68:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
?CND62:	ZERO?	DRIVE2 /?CND71
	CALL	CLAUSE-PRINT,P-NC1,P-NC1L
?CND71:	SET	'P-OFLAG,1
	ZERO?	DRIVE1 /?ELS79
	GETB	DRIVE1,P-SPREP1
	JUMP	?CND75
?ELS79:	GETB	DRIVE2,P-SPREP2
?CND75:	CALL	PREP-PRINT,STACK
	PRINTI	"?"
	CRLF	
	RFALSE	


	.FUNCT	CANT-ORPHAN
	PRINTI	"""FC: That command was incomplete. Why don't you try again?"""
	CRLF	
	RFALSE	


	.FUNCT	ORPHAN,D1,D2,CNT=-1
	PUT	P-OCLAUSE,P-MATCHLEN,0
	SET	'P-CCSRC,P-ITBL
?PRG1:	IGRTR?	'CNT,P-ITBLLEN \?ELS5
	JUMP	?REP2
?ELS5:	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
	JUMP	?PRG1
?REP2:	EQUAL?	P-NCN,2 \?CND8
	CALL	CLAUSE-COPY,P-NC2,P-NC2L
?CND8:	LESS?	P-NCN,1 /?CND11
	CALL	CLAUSE-COPY,P-NC1,P-NC1L
?CND11:	ZERO?	D1 /?ELS18
	GETB	D1,P-SPREP1
	PUT	P-OTBL,P-PREP1,STACK
	PUT	P-OTBL,P-NC1,1
	RTRUE	
?ELS18:	ZERO?	D2 /FALSE
	GETB	D2,P-SPREP2
	PUT	P-OTBL,P-PREP2,STACK
	PUT	P-OTBL,P-NC2,1
	RTRUE	


	.FUNCT	CLAUSE-PRINT,BPTR,EPTR,?TMP1
	GET	P-ITBL,BPTR >?TMP1
	GET	P-ITBL,EPTR
	CALL	BUFFER-PRINT,?TMP1,STACK,1
	RSTACK	


	.FUNCT	BUFFER-PRINT,BEG,END,CP,NOSP=0,WRD,FIRST??=1,PN=0,?TMP1
?PRG1:	EQUAL?	BEG,END /TRUE
	ZERO?	NOSP /?ELS10
	SET	'NOSP,0
	JUMP	?CND8
?ELS10:	PRINTI	" "
?CND8:	GET	BEG,0 >WRD
	EQUAL?	WRD,W?. \?ELS18
	SET	'NOSP,1
	JUMP	?CND3
?ELS18:	ZERO?	FIRST?? /?CND21
	ZERO?	PN \?CND21
	ZERO?	CP /?CND21
	PRINTI	"the "
?CND21:	ZERO?	P-OFLAG /?ELS30
	PRINTB	WRD
	JUMP	?CND28
?ELS30:	EQUAL?	WRD,W?IT \?ELS33
	EQUAL?	P-IT-LOC,WINNER-HERE \?ELS33
	PRINTD	P-IT-OBJECT
	JUMP	?CND28
?ELS33:	GETB	BEG,2 >?TMP1
	GETB	BEG,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND28:	SET	'FIRST??,0
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CAPITALIZE,PTR,?TMP1
	GETB	PTR,3
	GETB	P-INBUF,STACK
	SUB	STACK,32
	PRINTC	STACK
	GETB	PTR,2
	SUB	STACK,1 >?TMP1
	GETB	PTR,3
	ADD	STACK,1
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PREP-PRINT,PREP,WRD
	ZERO?	PREP /FALSE
	PRINTI	" "
	CALL	PREP-FIND,PREP >WRD
	PRINTB	WRD
	RTRUE	


	.FUNCT	CLAUSE-COPY,BPTR,EPTR,INSRT=0,BEG,END
	GET	P-CCSRC,BPTR >BEG
	GET	P-CCSRC,EPTR >END
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,BPTR,STACK
?PRG1:	EQUAL?	BEG,END \?ELS5
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,EPTR,STACK
	RTRUE	
?ELS5:	ZERO?	INSRT /?CND8
	GET	BEG,0
	EQUAL?	P-ANAM,STACK \?CND8
	CALL	CLAUSE-ADD,INSRT
?CND8:	GET	BEG,0
	CALL	CLAUSE-ADD,STACK
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CLAUSE-ADD,WRD,PTR
	GET	P-OCLAUSE,P-MATCHLEN
	ADD	STACK,2 >PTR
	SUB	PTR,1
	PUT	P-OCLAUSE,STACK,WRD
	PUT	P-OCLAUSE,PTR,0
	PUT	P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE	


	.FUNCT	PREP-FIND,PREP,CNT=0,SIZE
	GET	PREPOSITIONS,0
	MUL	STACK,2 >SIZE
?PRG1:	IGRTR?	'CNT,SIZE /FALSE
	GET	PREPOSITIONS,CNT
	EQUAL?	STACK,PREP \?PRG1
	SUB	CNT,1
	GET	PREPOSITIONS,STACK
	RETURN	STACK


	.FUNCT	SYNTAX-FOUND,SYN
	SET	'P-SYNTAX,SYN
	GETB	SYN,P-SACTION >PRSA
	RETURN	PRSA


	.FUNCT	GWIM,GBIT,LBIT,PREP,OBJ
	EQUAL?	GBIT,RMUNGBIT \?CND1
	RETURN	ROOMS
?CND1:	SET	'P-GWIMBIT,GBIT
	SET	'P-SLOCBITS,LBIT
	PUT	P-MERGE,P-MATCHLEN,0
	CALL	GET-OBJECT,P-MERGE,0
	ZERO?	STACK /?ELS8
	SET	'P-GWIMBIT,0
	GET	P-MERGE,P-MATCHLEN
	EQUAL?	STACK,1 \FALSE
	GET	P-MERGE,1 >OBJ
	FSET?	OBJ,VEHBIT \?CND14
	EQUAL?	PREP,PR?DOWN \?CND14
	SET	'PREP,PR?ON
?CND14:	PRINTI	"("
	ZERO?	PREP /?CND21
	CALL	PREP-FIND,PREP
	PRINTB	STACK
	PRINTI	" the "
?CND21:	CALL	NDESC,OBJ
	PRINTI	")"
	CRLF	
	RETURN	OBJ
?ELS8:	SET	'P-GWIMBIT,0
	RFALSE	


	.FUNCT	SNARF-OBJECTS,PTR
	GET	P-ITBL,P-NC1 >PTR
	ZERO?	PTR /?CND1
	GETB	P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET	P-ITBL,P-NC1L
	CALL	SNARFEM,PTR,STACK,P-PRSO
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /?CND1
	CALL	BUT-MERGE,P-PRSO >P-PRSO
?CND1:	GET	P-ITBL,P-NC2 >PTR
	ZERO?	PTR /TRUE
	GETB	P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET	P-ITBL,P-NC2L
	CALL	SNARFEM,PTR,STACK,P-PRSI
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /TRUE
	GET	P-PRSI,P-MATCHLEN
	EQUAL?	STACK,1 \?ELS18
	CALL	BUT-MERGE,P-PRSO >P-PRSO
	RTRUE	
?ELS18:	CALL	BUT-MERGE,P-PRSI >P-PRSI
	RTRUE	


	.FUNCT	BUT-MERGE,TBL,LEN,BUTLEN,CNT=1,MATCHES=0,OBJ,NTBL
	GET	TBL,P-MATCHLEN >LEN
	PUT	P-MERGE,P-MATCHLEN,0
?PRG1:	DLESS?	'LEN,0 \?ELS5
	JUMP	?REP2
?ELS5:	GET	TBL,CNT >OBJ
	CALL	ZMEMQ,OBJ,P-BUTS
	ZERO?	STACK /?ELS7
	JUMP	?CND3
?ELS7:	ADD	MATCHES,1
	PUT	P-MERGE,STACK,OBJ
	INC	'MATCHES
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	PUT	P-MERGE,P-MATCHLEN,MATCHES
	SET	'NTBL,P-MERGE
	SET	'P-MERGE,TBL
	RETURN	NTBL


	.FUNCT	SNARFEM,PTR,EPTR,TBL,BUT=0,LEN,WV,WORD,NW
	SET	'P-GETFLAGS,0
	SET	'P-CSPTR,PTR
	SET	'P-CEPTR,EPTR
	PUT	P-BUTS,P-MATCHLEN,0
	PUT	TBL,P-MATCHLEN,0
	GET	PTR,0 >WORD
?PRG1:	EQUAL?	PTR,EPTR \?ELS5
	ZERO?	BUT /?ORP9
	PUSH	BUT
	JUMP	?THN6
?ORP9:	PUSH	TBL
?THN6:	CALL	GET-OBJECT,STACK
	RETURN	STACK
?ELS5:	GET	PTR,P-LEXELEN >NW
	EQUAL?	WORD,W?ALL \?ELS14
	SET	'P-GETFLAGS,P-ALL
	EQUAL?	NW,W?OF \?CND12
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND12
?ELS14:	EQUAL?	WORD,W?BUT,W?EXCEPT \?ELS19
	ZERO?	BUT /?ORP25
	PUSH	BUT
	JUMP	?THN22
?ORP25:	PUSH	TBL
?THN22:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	SET	'BUT,P-BUTS
	PUT	BUT,P-MATCHLEN,0
	JUMP	?CND3
?ELS19:	EQUAL?	WORD,W?A,W?ONE \?ELS27
	ZERO?	P-ADJ \?ELS30
	SET	'P-GETFLAGS,P-ONE
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?ELS30:	SET	'P-NAM,P-ONEOBJ
	ZERO?	BUT /?ORP41
	PUSH	BUT
	JUMP	?THN38
?ORP41:	PUSH	TBL
?THN38:	CALL	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	ZERO?	NW /TRUE
	JUMP	?CND3
?ELS27:	EQUAL?	WORD,W?AND,W?COMMA \?ELS45
	EQUAL?	NW,W?AND,W?COMMA /?ELS45
	ZERO?	BUT /?ORP53
	PUSH	BUT
	JUMP	?THN50
?ORP53:	PUSH	TBL
?THN50:	CALL	GET-OBJECT,STACK
	ZERO?	STACK \?CND12
	RFALSE	
?ELS45:	CALL	WT?,WORD,PS?PREPOSITION
	ZERO?	STACK /?ELS55
	EQUAL?	PTR,P-CSPTR \?ELS55
	ADD	P-CSPTR,P-WORDLEN >P-CSPTR
	JUMP	?CND3
?ELS55:	CALL	WT?,WORD,PS?BUZZ-WORD
	ZERO?	STACK /?ELS59
	JUMP	?CND3
?ELS59:	EQUAL?	WORD,W?AND,W?COMMA \?ELS61
	JUMP	?CND3
?ELS61:	EQUAL?	WORD,W?OF \?ELS63
	ZERO?	P-GETFLAGS \?CND12
	SET	'P-GETFLAGS,P-INHIBIT
	JUMP	?CND12
?ELS63:	CALL	WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE >WV
	ZERO?	WV /?ELS68
	CALL	ADJ-CHECK
	ZERO?	STACK /?ELS68
	ZERO?	P-ADJ /?CND71
	SET	'P-OADJ,P-ADJ
	SET	'P-OADJECTIVE,P-ADJECTIVE
?CND71:	SET	'P-ADJ,WV
	SET	'P-ADJN,WORD
	SET	'P-ADJECTIVE,WORD
	JUMP	?CND3
?ELS68:	CALL	WT?,WORD,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND3
	SET	'P-NAM,WORD
	SET	'P-ONEOBJ,WORD
?CND12:	
?CND3:	EQUAL?	PTR,EPTR /?PRG1
	ADD	PTR,P-WORDLEN >PTR
	SET	'WORD,NW
	JUMP	?PRG1


	.FUNCT	ADJ-CHECK
	ZERO?	P-ADJ \TRUE
	RTRUE	


	.FUNCT	GET-OBJECT,TBL,VRB=1,LEN,XBITS,TLEN,GCHECK=0,OLEN=0
	ZERO?	SETUP-MODE /?CND1
	SET	'GCHECK,1
?CND1:	SET	'XBITS,P-SLOCBITS
	GET	TBL,P-MATCHLEN >TLEN
	BTST	P-GETFLAGS,P-INHIBIT /TRUE
	ZERO?	P-NAM \?CND8
	ZERO?	P-ADJ /?CND8
	CALL	WT?,P-ADJN,PS?OBJECT,P1?OBJECT
	ZERO?	STACK /?CND8
	SET	'P-NAM,P-ADJN
	ZERO?	P-OADJ /?ELS15
	SET	'P-ADJ,P-OADJ
	SET	'P-ADJECTIVE,P-OADJECTIVE
	JUMP	?CND8
?ELS15:	SET	'P-ADJECTIVE,0
	SET	'P-ADJ,0
?CND8:	ZERO?	P-NAM \?CND19
	ZERO?	P-ADJ \?CND19
	EQUAL?	P-GETFLAGS,P-ALL /?CND19
	ZERO?	P-GWIMBIT \?CND19
	ZERO?	VRB /FALSE
	PRINTI	"FC: I think that sentence was missing a noun."
	CRLF	
	RFALSE	
?CND19:	EQUAL?	P-GETFLAGS,P-ALL \?THN33
	ZERO?	P-SLOCBITS \?ELS32
?THN33:	SET	'P-SLOCBITS,-1
	JUMP	?CND30
?ELS32:	EQUAL?	P-GETFLAGS,P-ALL \?CND30
	ZERO?	P-NAM /?CND30
	EQUAL?	PRSA,V?TAKE \?CND30
	SET	'P-SLOCBITS,-1
?CND30:	SET	'P-TABLE,TBL
?PRG39:	BTST	P-GETFLAGS,P-ALL \?CND41
	EQUAL?	P-NAM,W?ROBOTS \?CND41
	SET	'GCHECK,1
?CND41:	ZERO?	GCHECK /?ELS48
	CALL	GLOBAL-CHECK,TBL
	JUMP	?CND46
?ELS48:	ZERO?	LIT /?CND52
	CALL	DO-SL,WINNER-HERE,SOG,SIR
?CND52:	CALL	DO-SL,WINNER,SH,SC
?CND46:	GET	TBL,P-MATCHLEN
	SUB	STACK,TLEN >LEN
	BTST	P-GETFLAGS,P-ALL \?ELS58
	JUMP	?CND56
?ELS58:	BTST	P-GETFLAGS,P-ONE \?ELS60
	ZERO?	LEN /?ELS60
	EQUAL?	LEN,1 /?CND63
	RANDOM	LEN
	GET	TBL,STACK
	PUT	TBL,1,STACK
	PRINTI	"(How about the "
	GET	TBL,1
	PRINTD	STACK
	PRINTI	"?)"
	CRLF	
?CND63:	PUT	TBL,P-MATCHLEN,1
	JUMP	?CND56
?ELS60:	GRTR?	LEN,1 /?THN72
	ZERO?	LEN \?ELS71
	EQUAL?	P-SLOCBITS,-1 /?ELS71
?THN72:	EQUAL?	P-SLOCBITS,-1 \?ELS78
	SET	'P-SLOCBITS,XBITS
	SET	'OLEN,LEN
	GET	TBL,P-MATCHLEN
	SUB	STACK,LEN
	PUT	TBL,P-MATCHLEN,STACK
	JUMP	?PRG39
?ELS78:	ZERO?	LEN \?CND81
	SET	'LEN,OLEN
?CND81:	ZERO?	VRB /?ELS86
	ZERO?	P-NAM /?ELS86
	CALL	WHICH-PRINT,TLEN,LEN,TBL
	EQUAL?	TBL,P-PRSO \?ELS93
	PUSH	P-NC1
	JUMP	?CND89
?ELS93:	PUSH	P-NC2
?CND89:	SET	'P-ACLAUSE,STACK
	SET	'P-AADJ,P-ADJ
	SET	'P-ANAM,P-NAM
	CALL	ORPHAN,0,0
	SET	'P-OFLAG,1
	JUMP	?CND84
?ELS86:	ZERO?	VRB /?CND84
	PRINTI	"FC: You must supply a noun!"
	CRLF	
?CND84:	SET	'P-NAM,0
	SET	'P-ADJ,0
	RFALSE	
?ELS71:	ZERO?	LEN \?ELS102
	ZERO?	GCHECK /?ELS102
	ZERO?	VRB /?CND105
	EQUAL?	PRSA,V?QUERY \?ELS111
	EQUAL?	WINNER,WHIZ \?ELS111
	ZERO?	PLUGGED-IN /?ELS111
	JUMP	?CND105
?ELS111:	ZERO?	LIT /?ELS115
	GET	DETECT-TBL,ROFF
	CALL	ROBOT-TELL,STACK,0
	ZERO?	P-OFLAG /?ELS119
	ZERO?	P-ADJ /?CND121
	ZERO?	P-NAM /?CND121
	PRINTI	" any such"
?CND121:	ZERO?	P-NAM /?CND117
	EQUAL?	P-NAM,W?IRIS,W?AUDA,W?WALDO /?THN135
	EQUAL?	P-NAM,W?WHIZ,W?SENSA,W?POET \?CND132
?THN135:	PRINTI	" robot "
?CND132:	PRINTB	P-NAM
	JUMP	?CND117
?ELS119:	EQUAL?	P-NAM,W?IRIS,W?AUDA,W?WALDO /?THN144
	EQUAL?	P-NAM,W?WHIZ,W?SENSA,W?POET \?ELS143
?THN144:	PRINTI	" "
	JUMP	?CND141
?ELS143:	PRINTI	" any"
?CND141:	CALL	BUFFER-PRINT,P-CSPTR,P-CEPTR,0
?CND117:	PRINTI	" here."
	CRLF	
	JUMP	?CND105
?ELS115:	PRINTI	"It's too dark to see."
	CRLF	
?CND105:	SET	'P-NAM,0
	SET	'P-ADJ,0
	RFALSE	
?ELS102:	ZERO?	LEN \?CND56
	SET	'GCHECK,1
	JUMP	?PRG39
?CND56:	SET	'P-ADJ,0
	SET	'P-NAM,0
	SET	'P-SLOCBITS,XBITS
	RTRUE	


	.FUNCT	WHICH-PRINT,TLEN,LEN,TBL,OBJ,RLEN,TEMPROFF
	SET	'RLEN,LEN
	PRINTI	"FC: Which "
	PRINTB	P-NAM
	PRINTI	" do you mean, "
?PRG5:	INC	'TLEN
	GET	TBL,TLEN >OBJ
	PRINTI	"the "
	IN?	OBJ,ROOMS \?ELS11
	PRINTD	OBJ
	JUMP	?CND9
?ELS11:	CALL	NDESC,OBJ
?CND9:	EQUAL?	LEN,2 \?ELS20
	EQUAL?	RLEN,2 /?CND21
	PRINTI	","
?CND21:	PRINTI	" or "
	JUMP	?CND18
?ELS20:	GRTR?	LEN,2 \?CND18
	PRINTI	", "
?CND18:	DLESS?	'LEN,1 \?PRG5
	PRINTR	"?"


	.FUNCT	GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT=0,OBJ,OBITS,FOO
	GET	TBL,P-MATCHLEN >LEN
	SET	'OBITS,P-SLOCBITS
	GETPT	WINNER-HERE,P?GLOBAL >RMG
	ZERO?	RMG /?CND1
	PTSIZE	RMG
	SUB	STACK,1 >RMGL
?PRG4:	GETB	RMG,CNT >OBJ
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND6
	CALL	OBJ-FOUND,OBJ,TBL
?CND6:	IGRTR?	'CNT,RMGL \?PRG4
?CND1:	GETPT	WINNER-HERE,P?PSEUDO >RMG
	ZERO?	RMG /?CND12
	PTSIZE	RMG
	DIV	STACK,4
	SUB	STACK,1 >RMGL
	SET	'CNT,0
?PRG15:	MUL	CNT,2
	GET	RMG,STACK
	EQUAL?	P-NAM,STACK \?ELS19
	MUL	CNT,2
	ADD	STACK,1
	GET	RMG,STACK
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	GETPT	PSEUDO-OBJECT,P?ACTION
	SUB	STACK,5 >FOO
	GET	P-NAM,0
	PUT	FOO,0,STACK
	GET	P-NAM,1
	PUT	FOO,1,STACK
	CALL	OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP	?CND12
?ELS19:	IGRTR?	'CNT,RMGL \?PRG15
?CND12:	GET	TBL,P-MATCHLEN
	EQUAL?	STACK,LEN \FALSE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	CALL	DO-SL,GLOBAL-OBJECTS,1,1
	SET	'P-SLOCBITS,OBITS
	GET	TBL,P-MATCHLEN
	ZERO?	STACK \FALSE
	EQUAL?	WINNER,WHIZ \?ELS36
	EQUAL?	PRSA,V?QUERY \?ELS36
	ZERO?	PLUGGED-IN /?ELS36
	PRINTI	"CLC: Hmm. That's a tough one. Hold on a minute while I try to locate a reference ..."
	CRLF	
	CRLF	
	CALL	MOBY-FIND,TBL
	PRINTI	"CLC: "
	GET	TBL,P-MATCHLEN >FOO
	GRTR?	FOO,1 \?CND43
	EQUAL?	P-NAM,W?WALKWA,W?MECHAN,W?BLT /?THN48
	EQUAL?	P-NAM,W?GLIDER /?THN48
	EQUAL?	P-NAM,W?GROOVE,W?TRACK \?CND43
?THN48:	PUT	TBL,P-MATCHLEN,1
	SET	'FOO,1
?CND43:	ZERO?	FOO \?ELS54
	CALL	PICK-ONE,NOT-FOUND
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS54:	GRTR?	FOO,1 \?ELS58
	PUT	TBL,P-MATCHLEN,0
	PRINTR	"I'm afraid you weren't specific enough. One object at a time, and adjectives can be helpful."
?ELS58:	CALL	PICK-ONE,CROWDED
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS36:	EQUAL?	PRSA,V?FOLLOW /?THN67
	EQUAL?	PRSA,V?EXAMINE,V?MOVE-ROBOT-TO-LOC,V?WALK-TO \FALSE
?THN67:	CALL	DO-SL,ROOMS,1,1
	RSTACK	


	.FUNCT	MOBY-FIND,TBL,FOO
	FIRST?	ROOMS >FOO /?KLU13
?KLU13:	
?PRG1:	ZERO?	FOO \?ELS5
	JUMP	?REP2
?ELS5:	CALL	SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT?	FOO >FOO /?KLU14
?KLU14:	JUMP	?PRG1
?REP2:	GET	TBL,P-MATCHLEN
	ZERO?	STACK \FALSE
	CALL	DO-SL,LOCAL-GLOBALS,1,1
	RSTACK	


	.FUNCT	DO-SL,OBJ,BIT1,BIT2
	ADD	BIT1,BIT2
	BTST	P-SLOCBITS,STACK \?ELS5
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCALL
	RSTACK	
?ELS5:	BTST	P-SLOCBITS,BIT1 \?ELS12
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP
	RSTACK	
?ELS12:	BTST	P-SLOCBITS,BIT2 \TRUE
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT
	RSTACK	


	.FUNCT	SEARCH-LIST,OBJ,TBL,LVL,FLS,NOBJ
	FIRST?	OBJ >OBJ \FALSE
?PRG6:	EQUAL?	P-GETFLAGS,P-ALL \?ELS10
	EQUAL?	OBJ,PANEL \?ELS10
	EQUAL?	PRSA,V?DROP \?ELS10
	JUMP	?CND8
?ELS10:	EQUAL?	LVL,P-SRCBOT /?CND8
	GETPT	OBJ,P?SYNONYM
	ZERO?	STACK /?CND8
	CALL	THIS-IT?,OBJ,TBL
	ZERO?	STACK /?CND8
	CALL	OBJ-FOUND,OBJ,TBL
?CND8:	EQUAL?	PRSA,V?QUERY /?THN22
	FSET?	OBJ,INVISIBLE /?CND17
?THN22:	EQUAL?	LVL,P-SRCTOP \?THN24
	FSET?	OBJ,SEARCHBIT /?THN24
	FSET?	OBJ,SURFACEBIT \?CND17
?THN24:	FIRST?	OBJ >NOBJ \?CND17
	EQUAL?	OBJ,WINNER /?CND17
	FSET?	OBJ,OPENBIT /?THN26
	FSET?	OBJ,TRANSBIT \?CND17
?THN26:	EQUAL?	LVL,P-SRCTOP \?ELS30
	FSET?	OBJ,SEARCHBIT \?ELS30
	EQUAL?	P-GETFLAGS,P-ALL \?ELS30
	JUMP	?CND17
?ELS30:	FSET?	OBJ,SURFACEBIT \?ELS39
	PUSH	P-SRCALL
	JUMP	?CND35
?ELS39:	FSET?	OBJ,SEARCHBIT \?ELS41
	PUSH	P-SRCALL
	JUMP	?CND35
?ELS41:	PUSH	P-SRCTOP
?CND35:	CALL	SEARCH-LIST,OBJ,TBL,STACK >FLS
?CND17:	NEXT?	OBJ >OBJ /?PRG6
	RTRUE	


	.FUNCT	OBJ-FOUND,OBJ,TBL,PTR
	GETP	OBJ,P?OBJDESCS >PTR
	ZERO?	PTR /?ELS5
	GET	PTR,ROFF
	ZERO?	STACK \?ELS5
	IN?	OBJ,WINNER \TRUE
?ELS5:	EQUAL?	P-GETFLAGS,P-ALL \?ELS9
	EQUAL?	P-NAM,W?ROBOTS /?ELS9
	GETP	OBJ,P?ROBOT
	ZERO?	STACK \TRUE
?ELS9:	EQUAL?	WINNER,IRIS \?ELS13
	ZERO?	IRIS-FIXED \?ELS13
	GETP	OBJ,P?ROBOT
	ZERO?	STACK \?ELS13
	EQUAL?	OBJ,LOCATION /?ELS13
	IN?	OBJ,ROOMS \TRUE
?ELS13:	GET	TBL,P-MATCHLEN >PTR
	ADD	PTR,1
	PUT	TBL,STACK,OBJ
	ADD	PTR,1
	PUT	TBL,P-MATCHLEN,STACK
	RTRUE	


	.FUNCT	TAKE-CHECK
	GETB	P-SYNTAX,P-SLOC1
	CALL	ITAKE-CHECK,P-PRSO,STACK
	ZERO?	STACK /FALSE
	GETB	P-SYNTAX,P-SLOC2
	CALL	ITAKE-CHECK,P-PRSI,STACK
	RSTACK	


	.FUNCT	ITAKE-CHECK,TBL,IBITS,PTR,OBJ,TAKEN,TEMPROFF
	GET	TBL,P-MATCHLEN >PTR
	ZERO?	PTR /TRUE
	BTST	IBITS,SHAVE /?THN8
	BTST	IBITS,STAKE \TRUE
?THN8:	
?PRG10:	DLESS?	'PTR,0 /TRUE
	ADD	PTR,1
	GET	TBL,STACK >OBJ
	EQUAL?	OBJ,IT \?CND17
	SET	'OBJ,P-IT-OBJECT
?CND17:	CALL	HELD?,OBJ
	ZERO?	STACK \?PRG10
	SET	'PRSO,OBJ
	FSET?	OBJ,TRYTAKEBIT \?ELS25
	SET	'TAKEN,1
	JUMP	?CND23
?ELS25:	BTST	IBITS,STAKE \?ELS27
	CALL	ITAKE,0
	EQUAL?	STACK,1 \?ELS27
	SET	'TAKEN,0
	JUMP	?CND23
?ELS27:	SET	'TAKEN,1
?CND23:	ZERO?	TAKEN /?ELS34
	BTST	IBITS,SHAVE \?ELS34
	CALL	ROBOT-TELL,STR?75,0
	GETP	OBJ,P?ROBOT
	ZERO?	STACK \?CND37
	PRINTI	"the "
?CND37:	CALL	NDESC,OBJ
	PRINTI	"."
	CRLF	
	RFALSE	
?ELS34:	ZERO?	TAKEN \?PRG10
	CALL	ROBOT-TELL,STR?76,0
	CALL	NDESC,OBJ
	PRINTI	" first."
	CRLF	
	JUMP	?PRG10


	.FUNCT	HELD?,CAN
	FSET?	CAN,TAKEBIT \FALSE
?PRG4:	LOC	CAN >CAN
	ZERO?	CAN /FALSE
	EQUAL?	CAN,WINNER \?PRG4
	RTRUE	


	.FUNCT	MANY-CHECK,LOSS=0,TMP,?TMP1
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 \?ELS3
	GETB	P-SYNTAX,P-SLOC1
	BTST	STACK,SMANY /?ELS3
	SET	'LOSS,1
	JUMP	?CND1
?ELS3:	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 \?CND1
	GETB	P-SYNTAX,P-SLOC2
	BTST	STACK,SMANY /?CND1
	SET	'LOSS,2
?CND1:	ZERO?	LOSS /TRUE
	PRINTI	"FC: I can't use multiple "
	EQUAL?	LOSS,2 \?CND18
	PRINTI	"in"
?CND18:	PRINTI	"direct objects with '"
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?ELS27
	PRINTI	"tell"
	JUMP	?CND25
?ELS27:	ZERO?	P-OFLAG /?ELS31
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND25
?ELS31:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND25:	PRINTI	"'."
	CRLF	
	RFALSE	


	.FUNCT	ZMEMQ,ITM,TBL,SIZE=-1,CNT=1
	ZERO?	TBL /FALSE
	LESS?	SIZE,0 /?ELS6
	SET	'CNT,0
	JUMP	?CND4
?ELS6:	GET	TBL,0 >SIZE
?CND4:	
?PRG9:	GET	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG9
	RFALSE	


	.FUNCT	ZMEMQB,ITM,TBL,SIZE,CNT=0
?PRG1:	GETB	TBL,CNT
	EQUAL?	ITM,STACK /TRUE
	IGRTR?	'CNT,SIZE \?PRG1
	RFALSE	


	.FUNCT	LIT?,RM,OHERE,LIT=0
	SET	'P-GWIMBIT,ONBIT
	SET	'OHERE,WINNER-HERE
	SET	'WINNER-HERE,RM
	FSET?	RM,ONBIT /?THN4
	ZERO?	ALWAYS-LIT /?ELS3
?THN4:	SET	'LIT,1
	JUMP	?CND1
?ELS3:	PUT	P-MERGE,P-MATCHLEN,0
	SET	'P-TABLE,P-MERGE
	SET	'P-SLOCBITS,-1
	EQUAL?	OHERE,RM \?CND8
	CALL	DO-SL,WINNER,1,1
?CND8:	CALL	DO-SL,RM,1,1
	GET	P-TABLE,P-MATCHLEN
	GRTR?	STACK,0 \?CND1
	SET	'LIT,1
?CND1:	SET	'WINNER-HERE,OHERE
	SET	'P-GWIMBIT,0
	RETURN	LIT


	.FUNCT	PRSO-PRINT,PTR
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC1 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	CALL	NDESC,PRSO
	RSTACK	
?ELS5:	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,PTR,STACK,0
	RSTACK	


	.FUNCT	PRSI-PRINT,PTR
	ZERO?	P-MERGED \?THN6
	GET	P-ITBL,P-NC2 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?ELS5
?THN6:	PRINTI	" "
	CALL	NDESC,PRSO
	RSTACK	
?ELS5:	GET	P-ITBL,P-NC2L
	CALL	BUFFER-PRINT,PTR,STACK,0
	RSTACK	

	.ENDI