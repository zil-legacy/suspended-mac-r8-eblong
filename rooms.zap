

	.FUNCT	CPU-FCN,RARG=0
	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	WINNER,IRIS \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	PRSO,P?NE \FALSE
	CALL	ROBOT-TELL,STR?500
	RTRUE	


	.FUNCT	WEATHER-BANKS-FCN,RARG=0,STR
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LONG-DESCS
	EQUAL?	WINNER,IRIS \TRUE
	ZERO?	IRIS-FIXED /TRUE
	LESS?	DEGREES,31 \?ELS13
	LESS?	WINDS,10 \?ELS16
	SET	'STR,STR?506
	JUMP	?CND11
?ELS16:	LESS?	WINDS,30 \?ELS18
	SET	'STR,STR?507
	JUMP	?CND11
?ELS18:	LESS?	WINDS,60 \?ELS20
	SET	'STR,STR?508
	JUMP	?CND11
?ELS20:	LESS?	WINDS,80 \?ELS22
	SET	'STR,STR?509
	JUMP	?CND11
?ELS22:	LESS?	WINDS,100 \?ELS24
	SET	'STR,STR?510
	JUMP	?CND11
?ELS24:	SET	'STR,STR?511
	JUMP	?CND11
?ELS13:	LESS?	DEGREES,41 \?ELS28
	LESS?	WINDS,10 \?ELS31
	SET	'STR,STR?512
	JUMP	?CND11
?ELS31:	LESS?	WINDS,20 \?ELS33
	SET	'STR,STR?513
	JUMP	?CND11
?ELS33:	LESS?	WINDS,30 \?ELS35
	SET	'STR,STR?514
	JUMP	?CND11
?ELS35:	LESS?	WINDS,40 \?ELS37
	SET	'STR,STR?515
	JUMP	?CND11
?ELS37:	LESS?	WINDS,50 \?ELS39
	SET	'STR,STR?516
	JUMP	?CND11
?ELS39:	SET	'STR,STR?517
	JUMP	?CND11
?ELS28:	LESS?	WINDS,10 \?ELS46
	SET	'STR,STR?518
	JUMP	?CND11
?ELS46:	LESS?	WINDS,20 \?ELS48
	SET	'STR,STR?519
	JUMP	?CND11
?ELS48:	LESS?	WINDS,30 \?ELS50
	SET	'STR,STR?520
	JUMP	?CND11
?ELS50:	LESS?	WINDS,40 \?ELS52
	SET	'STR,STR?521
	JUMP	?CND11
?ELS52:	LESS?	WINDS,50 \?ELS54
	SET	'STR,STR?522
	JUMP	?CND11
?ELS54:	SET	'STR,STR?523
?CND11:	PRINTI	"The monitors for surface weather show:
"
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"
  TEMP: "
	PRINTN	DEGREES
	PRINTI	"   WINDS: "
	PRINTN	WINDS
	PRINTI	"
  PRECIPITATION: a "
	PRINT	STR
	PRINTI	"
  TOWER PRESSURES: Tower 1 -- "
	PRINTN	PRESSURE1
	PRINTI	"
                   Tower 2 -- "
	PRINTN	PRESSURE2
	PRINTI	"
                   Tower 3 -- "
	PRINTN	PRESSURE3
	CRLF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	CALL	WEATHER-ROBOTS
	RTRUE	


	.FUNCT	WEATHER-ROBOTS,COUNT=0,OFFSET=0,OBJ,CHECK-LOC
	IN?	IRIS,WEATHER-BANKS \?ELS3
	SET	'CHECK-LOC,WEATHER
	JUMP	?CND1
?ELS3:	IN?	IRIS,RTD-BANKS \?ELS5
	SET	'CHECK-LOC,RTD
	JUMP	?CND1
?ELS5:	SET	'CHECK-LOC,HYDRO
?CND1:	
?PRG8:	GET	NAME-TBL,OFFSET
	IN?	STACK,CHECK-LOC \?CND10
	INC	'COUNT
?CND10:	IGRTR?	'OFFSET,5 \?PRG8
	ZERO?	COUNT /TRUE
	PRINTI	"Through the monitors I can see "
	SET	'OFFSET,0
?PRG21:	GET	NAME-TBL,OFFSET >OBJ
	IN?	OBJ,CHECK-LOC \?CND23
	EQUAL?	WINNER,OBJ /?CND23
	CALL	NDESC,OBJ
	EQUAL?	COUNT,1 \?ELS32
	JUMP	?REP22
?ELS32:	EQUAL?	COUNT,2 \?ELS34
	PRINTI	" and "
	JUMP	?CND30
?ELS34:	PRINTI	", "
?CND30:	DEC	'COUNT
?CND23:	INC	'OFFSET
	JUMP	?PRG21
?REP22:	PRINTI	" in the "
	PRINTD	CHECK-LOC
	PRINTR	"."


	.FUNCT	SUPPLIES-N-FCN,RARG=0,OBJ
	EQUAL?	RARG,M-LOOK \FALSE
	EQUAL?	WINNER,IRIS \?ELS8
	ZERO?	IRIS-FIXED \?ELS8
	CALL	PICK-ONE,IRIS-BLIND
	PRINT	STACK
	CRLF	
	RETURN	2
?ELS8:	GET	LDSUPPLIES,ROFF
	PRINT	STACK
	FIRST?	SOCKET1 >OBJ \?ELS21
	EQUAL?	WINNER,AUDA /?ELS21
	PRINTI	". A "
	CALL	NDESC,OBJ
	PRINTI	" sits in the "
	CALL	NDESC,SOCKET1
	JUMP	?CND19
?ELS21:	EQUAL?	WINNER,AUDA /?CND19
	PRINTI	". The "
	CALL	NDESC,SOCKET1
	PRINTI	" is empty"
?CND19:	FIRST?	SOCKET2 >OBJ \?ELS32
	EQUAL?	WINNER,AUDA /?ELS32
	FIRST?	SOCKET1 \?ELS37
	PRINTI	", and"
	JUMP	?CND35
?ELS37:	PRINTI	", but"
?CND35:	PRINTI	" a "
	CALL	NDESC,OBJ
	PRINTI	" sits in the "
	CALL	NDESC,SOCKET2
	JUMP	?CND30
?ELS32:	EQUAL?	WINNER,AUDA /?CND30
	FIRST?	SOCKET1 \?ELS50
	PRINTI	", but the "
	CALL	NDESC,SOCKET2
	PRINTI	" is empty"
	JUMP	?CND30
?ELS50:	PRINTI	" as is the "
	CALL	NDESC,SOCKET2
?CND30:	PRINTI	"."
	IN?	ORANGE-WIRE,MACHINE \?CND59
	FSET?	MACHINE,OPENBIT \?CND59
	GET	WIRE-FIRST,ROFF
	PRINT	STACK
	CALL	NDESC,ORANGE-WIRE
	GET	WIRE-SECOND,ROFF
	PRINT	STACK
?CND59:	IN?	FUSE,MACHINE \?CND66
	FSET?	MACHINE,OPENBIT \?CND66
	EQUAL?	WINNER,AUDA /?CND66
	EQUAL?	WINNER,IRIS \?ELS73
	PRINTI	" A small glass fuse it sits in the panel."
	JUMP	?CND66
?ELS73:	EQUAL?	WINNER,POET \?ELS77
	PRINTI	" Meanwhile, a "
	CALL	NDESC,FUSE
	PRINTI	" monitors the situation."
	JUMP	?CND66
?ELS77:	PRINTI	" A "
	CALL	NDESC,FUSE
	PRINTI	" sits in the panel."
?CND66:	FSET?	MACHINE,OPENBIT \?CND6
	EQUAL?	WINNER,AUDA /?CND6
	GET	CIRCLE-DESCS,ROFF
	PRINT	STACK
?CND6:	IN?	NEWCHIP0,SOCKET1 \?CND91
	IN?	NEWCHIP2,SOCKET2 \?CND91
	EQUAL?	WINNER,SENSA /?THN99
	EQUAL?	WINNER,POET /?THN99
	EQUAL?	WINNER,AUDA /?THN99
	EQUAL?	WINNER,IRIS \?CND91
	ZERO?	IRIS-FIXED /?CND91
?THN99:	PRINTI	" "
	GET	FLASHING,ROFF
	PRINT	STACK
?CND91:	CRLF	
	RTRUE	


	.FUNCT	TRANSIT-MONITOR-FCN,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LONG-DESCS
	EQUAL?	WINNER,IRIS \TRUE
	EQUAL?	WINNER,IRIS \?CND6
	ZERO?	IRIS-FIXED /TRUE
?CND6:	PRINTI	"All around I can see monitors which show the status of the Transit Systems on the surface of the planet. The monitors describe the following situation:
"
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"
  FLOATERS AIRBORNE: "
	PRINTN	FLOATERS
	PRINTI	"000
  TAXIS IN USE: "
	PRINTN	TAXIS
	PRINTI	"000
  GLIDE RAMP SPEEDS: "
	PRINTN	RAMP-SPEED
	PRINTI	" mph
  FLOATER CRASH RATE: "
	PRINTN	CRASH-RATE
	PRINTI	"0
  TAXI ACCIDENT RATE: "
	PRINTN	COLLISIONS
	PRINTI	"0
  GLIDE RAMP CASUALTIES: "
	PRINTN	RAMP-KILLS
	PRINTI	"0"
	CRLF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	CALL	WEATHER-ROBOTS
	RSTACK	


	.FUNCT	HYDROMONITORS-FCN,RARG=0,STRW,STRM,STRL,WL,ML,LL
	EQUAL?	RARG,M-LOOK \FALSE
	EQUAL?	WINNER,IRIS /?ELS8
	CALL	LONG-DESCS
	RTRUE	
?ELS8:	ZERO?	IRIS-FIXED \?CND6
	CALL	LONG-DESCS
	RTRUE	
?CND6:	SUB	WATER-LEVEL,WATER-OPT
	LESS?	STACK,0 \?ELS15
	SUB	WATER-LEVEL,WATER-OPT
	SUB	0,STACK
	JUMP	?CND11
?ELS15:	SUB	WATER-LEVEL,WATER-OPT
?CND11:	ADD	STACK,0 >WL
	SUB	MINERALS,MINERALS-OPT
	LESS?	STACK,0 \?ELS22
	SUB	MINERALS,MINERALS-OPT
	SUB	0,STACK
	JUMP	?CND18
?ELS22:	SUB	MINERALS,MINERALS-OPT
?CND18:	ADD	STACK,0 >ML
	SUB	WATTS,WATTS-OPT
	LESS?	STACK,0 \?ELS29
	SUB	WATTS,WATTS-OPT
	SUB	0,STACK
	JUMP	?CND25
?ELS29:	SUB	WATTS,WATTS-OPT
?CND25:	ADD	STACK,0 >LL
	GRTR?	WATER-LEVEL,WATER-OPT \?ELS34
	SET	'STRW,STR?573
	JUMP	?CND32
?ELS34:	EQUAL?	WATER-LEVEL,WATER-OPT \?ELS36
	SET	'STRW,STR?574
	JUMP	?CND32
?ELS36:	SET	'STRW,STR?575
?CND32:	GRTR?	MINERALS,MINERALS-OPT \?ELS41
	SET	'STRM,STR?573
	JUMP	?CND39
?ELS41:	EQUAL?	MINERALS,MINERALS-OPT \?ELS43
	SET	'STRM,STR?574
	JUMP	?CND39
?ELS43:	SET	'STRM,STR?575
?CND39:	GRTR?	WATTS,WATTS-OPT \?ELS48
	SET	'STRL,STR?573
	JUMP	?CND46
?ELS48:	EQUAL?	WATTS,WATTS-OPT \?ELS50
	SET	'STRL,STR?574
	JUMP	?CND46
?ELS50:	SET	'STRL,STR?575
?CND46:	PRINTI	"Through the monitors I can see the following information:
"
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	PRINTI	"
           LEVEL  SETTING  OUTPUT
WATER:      "
	CALL	NUMBER-PRINT,WATER-LEVEL
	GET	DIALSETS,4
	CALL	NUMBER-PRINT,STACK
	PRINT	STRW
	CRLF	
	PRINTI	"MINERALS:   "
	CALL	NUMBER-PRINT,MINERALS
	GET	DIALSETS,5
	CALL	NUMBER-PRINT,STACK
	PRINT	STRM
	CRLF	
	PRINTI	"LIGHTING:   "
	CALL	NUMBER-PRINT,WATTS
	GET	DIALSETS,6
	CALL	NUMBER-PRINT,STACK
	PRINT	STRL
	CRLF	
	PRINTI	"FOOD TONS:  "
	LESS?	FOOD-TONS,100 \?ELS71
	GRTR?	FOOD-TONS,9 \?ELS71
	PRINTI	" "
	JUMP	?CND69
?ELS71:	LESS?	FOOD-TONS,10 \?CND69
	PRINTI	"  "
?CND69:	PRINTN	FOOD-TONS
	PRINTI	"            "
	GRTR?	FOOD-TONS,75 \?ELS86
	PRINTI	"optimal"
	JUMP	?CND84
?ELS86:	GRTR?	FOOD-TONS,50 \?ELS90
	PRINTI	" fair"
	JUMP	?CND84
?ELS90:	GRTR?	FOOD-TONS,25 \?ELS94
	PRINTI	" poor"
	JUMP	?CND84
?ELS94:	PRINTI	"critical"
?CND84:	CRLF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	CALL	WEATHER-ROBOTS
	RTRUE	


	.FUNCT	NUMBER-PRINT,NUM
	LESS?	NUM,10 \?ELS3
	PRINTI	"  "
	JUMP	?CND1
?ELS3:	LESS?	NUM,100 \?CND1
	PRINTI	" "
?CND1:	PRINTN	NUM
	PRINTI	"     "
	RFALSE	


	.FUNCT	WEDGE-FCN
	EQUAL?	WEDGE-PLACED,2 \?ELS5
	EQUAL?	WINNER-HERE,HALLWAY-JUNCTION \?ELS10
	RETURN	HUMAN-ENTRY
?ELS10:	EQUAL?	WINNER-HERE,HUMAN-ENTRY \FALSE
	RETURN	HALLWAY-JUNCTION
?ELS5:	CALL	ROBOT-TELL,STR?616
	RFALSE	


	.FUNCT	JUNCTION-FCN,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	WEDGE-PLACED,2 \FALSE
	FSET	WEDGE,NDESCBIT
	MOVE	WEDGE,WINNER-HERE
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS10
	CALL	LONG-DESCS
	EQUAL?	WEDGE-PLACED,2 \?ELS15
	EQUAL?	WINNER,AUDA /?ELS15
	PRINTI	"The "
	CALL	NDESC,WEDGE
	PRINTI	" is positioned by the step."
	CRLF	
	MOVE	WEDGE,WINNER-HERE
	RTRUE	
?ELS15:	FCLEAR	WEDGE,NDESCBIT
	RTRUE	
?ELS10:	EQUAL?	RARG,M-ENTER \FALSE
	EQUAL?	WEDGE-PLACED,2 \?ELS28
	MOVE	WEDGE,WINNER-HERE
	RTRUE	
?ELS28:	FCLEAR	WEDGE,NDESCBIT
	RTRUE	


	.FUNCT	REPAIRX-FCN,RARG=0,OBJ
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	WEDGE-PLACED,1 \FALSE
	FSET	WEDGE,NDESCBIT
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LONG-DESCS
	PRINTI	"The "
	CALL	NDESC,CONVEYERBELTA
	PRINTI	" is "
	ZERO?	BELT-ON \?CND13
	PRINTI	"not "
?CND13:	PRINTI	"in motion"
	EQUAL?	WINNER-HERE,REPAIR1 \?ELS22
	FIRST?	CONVEYERBELTA >OBJ \?ELS22
	JUMP	?CND20
?ELS22:	EQUAL?	WINNER-HERE,REPAIR2 \?ELS26
	FIRST?	CONVEYERBELTB >OBJ \?ELS26
	JUMP	?CND20
?ELS26:	EQUAL?	WINNER-HERE,REPAIR3 \?CND20
	FIRST?	CONVEYERBELTC >OBJ \?CND20
?CND20:	ZERO?	OBJ /?CND33
	PRINTI	", moving "
	GETP	OBJ,P?ROBOT
	ZERO?	STACK \?CND39
	PRINTI	"a "
?CND39:	CALL	NDESC,OBJ
?CND33:	PRINTI	"."
	CRLF	
	EQUAL?	WEDGE-PLACED,1 \?ELS52
	EQUAL?	WINNER-HERE,REPAIR1 \?ELS52
	PRINTI	"The "
	CALL	NDESC,WEDGE
	PRINTI	" is positioned at the base of the "
	CALL	NDESC,CONVEYERBELTA
	PRINTR	"."
?ELS52:	FCLEAR	WEDGE,NDESCBIT
	RTRUE	


	.FUNCT	SLEEP-CHAMBER-FCN,RARG=0
	EQUAL?	RARG,M-END \FALSE
	EQUAL?	PRSO,TOOLBAG \FALSE
	IN?	TOOLBAG,WINNER \FALSE
	EQUAL?	PRSA,V?TAKE \FALSE
	SET	'RTHIEF,WINNER
	CALL	INT,I-STEAL
	PUT	STACK,0,0
	CALL	QUEUE,I-CHASEAUDA,-1
	PUT	STACK,0,1
	RTRUE	


	.FUNCT	FCMAINT-FCN,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LONG-DESCS
	FCLEAR	WHEEL,NDESCBIT
	GET	FCWHEEL,ROFF
	ZERO?	STACK /TRUE
	ZERO?	ACID-FIXED \TRUE
	GET	FCWHEEL,ROFF
	PRINT	STACK
	CRLF	
	FSET	WHEEL,NDESCBIT
	RTRUE	


	.FUNCT	BEWARE-MIST-FCN,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	ACID-FIXED \FALSE
	EQUAL?	WINNER,WHIZ /FALSE
	EQUAL?	WINNER,WALDO /FALSE
	CALL	LONG-DESCS
	GET	BEWARE-TBL,ROFF
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	SKY-FCN,RARG=0
	EQUAL?	RARG,M-END \FALSE
	EQUAL?	PRSA,V?DROP \FALSE
	CALL	ROBOT-TELL,STR?125,0
	CALL	NDESC,PRSO
	PRINTI	" is whisked up by the force of the tube."
	CRLF	
	IN?	PRSO,SKY1 \?ELS17
	MOVE	PRSO,WEATHER
	RTRUE	
?ELS17:	IN?	PRSO,SKY2 \?ELS19
	MOVE	PRSO,HYDRO
	RTRUE	
?ELS19:	IN?	PRSO,SKY3 \FALSE
	MOVE	PRSO,RTD
	RTRUE	


	.FUNCT	DESCRIBE-CONTROLS-FCN,RARG=0,D1,D2,D3,DOFF=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LONG-DESCS
	EQUAL?	WINNER,AUDA /TRUE
	EQUAL?	WINNER-HERE,WEATHER \?ELS11
	SET	'D1,WDIAL1
	SET	'D2,WDIAL2
	SET	'D3,WDIAL3
	JUMP	?CND9
?ELS11:	SET	'DOFF,3
	SET	'D1,LEVER1
	SET	'D2,LEVER2
	SET	'D3,LEVER3
?CND9:	PRINTI	"The "
	CALL	NDESC,D1
	PRINTI	" is set to "
	ADD	1,DOFF
	GET	DIALSETS,STACK
	PRINTN	STACK
	PRINTI	", the "
	CALL	NDESC,D2
	PRINTI	" is set to "
	ADD	2,DOFF
	GET	DIALSETS,STACK
	PRINTN	STACK
	PRINTI	", and the "
	CALL	NDESC,D3
	PRINTI	" is set to "
	ADD	3,DOFF
	GET	DIALSETS,STACK
	PRINTN	STACK
	PRINTR	"."


	.FUNCT	ACIDMIST-FCN,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	ZERO?	ACID-FIXED \FALSE
	GET	DEADBOTS,ROFF
	ZERO?	STACK \FALSE
	PUT	DEADBOTS,ROFF,1
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	ACID-FIXED \FALSE
	CALL	LONG-DESCS
	EQUAL?	WINNER,WHIZ /TRUE
	GET	MISTY-TBL,ROFF
	PRINT	STACK
	CRLF	
	RTRUE	

	.ENDI