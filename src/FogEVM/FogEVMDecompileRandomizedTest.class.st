Class {
	#name : #FogEVMDecompileRandomizedTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#instVars : [
		'generator',
		'x',
		'y',
		'z'
	],
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #'building suites' }
FogEVMDecompileRandomizedTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #'as yet unclassified' }
FogEVMDecompileRandomizedTest >> assertIsBinaryOperationBytecode: sequence  selector: aSelector [
  ^ self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: aSelector
]

{ #category : #test }
FogEVMDecompileRandomizedTest >> generator: aGenerator [
	| hex |
	hex := Hexadecimal new.
	x := hex write0xHexadecimal: (aGenerator nextInt: 512).
	y := hex write0xHexadecimal: (aGenerator nextInt: 512).
	z := hex write0xHexadecimal: (aGenerator nextInt: 512).
	generator := aGenerator
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testADD [
	| sequence |
	"ADD(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 addition := a + b
	  stack + 
	    addition
	"
	sequence := self decompile: (self createBytecodeForADD: x plus: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #plus:.


]

{ #category : #test }
FogEVMDecompileRandomizedTest >> testADDMOD [
	| sequence |
	" 
	ADDMOD(A,B,C)->
	 sequence +
	  a := A.
	  b := B.
	  c := C.
	  sum := a + b.
	  summod := sum mod c.
	 stack +
	  summod
	"
	sequence := self decompile: (self createBytecodeForADDMOD: x and: y and: z).
	
	self assert: sequence statements size equals: 5.
	self assert: sequence allInstructions size equals: 5.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assertIsBinaryOperation: sequence statements fourth value selector: #plus:.
	self assertIsBinaryOperation: sequence statements last value selector: #mod:.
	
	self assert: sequence statements last value receiver equals: sequence statements fourth variable.
	self assert: decompiler scope stack size equals: 1.
	self assert: decompiler scope stack pop equals: sequence statements last variable.
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testBYTE [
| sequence |
	"BYTE(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 byte := a at: b
	  stack + 
	    byte
	"
	sequence := self decompile: (self createBytecodeForBYTE: '0xFF00AA' at: '0x3').
	self assertIsUnaryMessageSendBytecode: sequence stack: decompiler scope stack selector: #at:.
	

]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testDIV [
	| sequence |
	"ADD(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 addition := a + b
	  stack + 
	    addition
	"
	y := Hexadecimal new  write0xHexadecimal: ((Hexadecimal new readHexadecimal:  y) max: 1).
	sequence := self decompile: (self createBytecodeForDIV: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #divide:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testEQ [
	| sequence |
	"EQ(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a = b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForEQ: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #equals:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testEXP [
	| sequence |
	"EXP(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a ** b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForEXP: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #power:
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testGT [
	| sequence |
	"GT(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a > b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForGT: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #greaterThan:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testLT [
	| sequence |
	"LT(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a < b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForLT: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #lesserThan:
		
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testMOD [
	| sequence |
	"MOD(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a mod b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForMOD: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #mod:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testMUL [
	| sequence |
	"MUL(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a * b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForMUL: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #multiply:
]

{ #category : #test }
FogEVMDecompileRandomizedTest >> testMULMOD [
	| sequence |
	" 
	MULMOD(A,B,C)->
	 sequence +
	  a := A.
	  b := B.
	  c := C.
	  sum := a * b.
	  summod := sum mod c.
	 stack +
	  summod
	"
	sequence := self
		decompile: (self createBytecodeForMULMOD: x and: y and: z).
	self assert: sequence statements size equals: 5.
	self assert: sequence allInstructions size equals: 5.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self
		assertIsBinaryOperation: sequence statements fourth value
		selector: #multiply:.
	self
		assertIsBinaryOperation: sequence statements last value
		selector: #mod:.
	self
		assert: sequence statements last value receiver
		equals: sequence statements fourth variable.
	self assert: decompiler scope stack size equals: 1.
	self
		assert: decompiler scope stack pop
		equals: sequence statements last variable
]

{ #category : #test }
FogEVMDecompileRandomizedTest >> testPOP [
	
	| sequence |
	"POP(VAR)->
	  sequence +
	   value := VAR.
	  stack +
	   
	"
	sequence := self decompile: (self createBytecodeForPOP: x).
	self assert: sequence statements size equals: 1.
	self assert: sequence allInstructions size equals: 3.
	self assertIsAssignment: sequence statements first.
	
	
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSAR [
	| sequence |
	"SAR(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a sar b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSAR: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #sar:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSDIV [
	| sequence |
	"SDIV(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a sdiv b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSDIV: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #signedDivision:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSGT [
	| sequence |
	"SGT(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a sdiv b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSGT: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #signedGreaterThan:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSHL [
	| sequence |
	"SHL(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a << b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSHL: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #shiftLeft:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSHR [
 | sequence |
	"SHR(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a >> b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSHR: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #shiftRight:
	
]

{ #category : #test }
FogEVMDecompileRandomizedTest >> testSIGNEXTEND [
	| sequence |
	"
	SIGNEXTEND(VALUE, LENGTH) ->
	 sequence + 
	  value := VALUE. 
	  length := LENGTH.
	  extendedValue := value extend: length.
	 stack + 
	  extendedValue. 
	"
	z := Hexadecimal new write0xHexadecimal: (generator nextInt: 30) + 1.
	sequence := self decompile: (self createBytecodeForSIGNEXTEND: y of: 16 to: z).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #extendRepresentationTo:
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSLT [
 | sequence |
	"SHR(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a signedLesserThan b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSLT: x and: y).
	self assertIsUnaryMessageSendBytecode: sequence stack: decompiler scope stack selector: #signedIsLesserThan:
	
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSMOD [
 | sequence |
	"SMOD(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a smod b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSMOD: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #signedMod:
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileRandomizedTest >> testSUB [
	| sequence |
	"SMOD(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a - b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSUB: x and: y).
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #minus:
]
