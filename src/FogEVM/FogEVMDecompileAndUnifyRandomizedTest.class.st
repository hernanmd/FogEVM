Class {
	#name : #FogEVMDecompileAndUnifyRandomizedTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#instVars : [
		'generator',
		'x',
		'y',
		'z'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #'building suites' }
FogEVMDecompileAndUnifyRandomizedTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #'as yet unclassified' }
FogEVMDecompileAndUnifyRandomizedTest >> assertIsBinaryOperationBytecode: sequence  selector: aSelector [
  ^ self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: aSelector
]

{ #category : #test }
FogEVMDecompileAndUnifyRandomizedTest >> generator: aGenerator [
	| hex |
	hex := Hexadecimal new.
	x := hex write0xHexadecimal: (aGenerator nextInt: 512).
	y := hex write0xHexadecimal: (aGenerator nextInt: 512).
	z := hex write0xHexadecimal: (aGenerator nextInt: 512).
	generator := aGenerator
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testADD [
	| sequence |
	"ADD(A,B)->
	  sequence +
		 addition := a + b
	  stack + 
	    addition
	"
	
	sequence := self decompile: (self createBytecodeForADD: x plus: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.



]

{ #category : #test }
FogEVMDecompileAndUnifyRandomizedTest >> testADDMOD [
	| sequence |
	" 
	ADDMOD(A,B,C)->
	 sequence +
	  summod := (a + b) mod c.
	 stack +
	  summod
	"
	sequence := self decompile: (self createBytecodeForADDMOD: x and: y and: z).
	
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testBYTE [
| sequence |
	"BYTE(A,B)->
	  sequence +
		 byte := a at: b
	  stack + 
	    byte
	"
	sequence := self decompile: (self createBytecodeForBYTE: '0xFF00AA' at: '0x3').
self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.	

]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testDIV [
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
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testEQ [
	| sequence |
	"EQ(A,B)->
	  sequence +
		 value := a = b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForEQ: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testEXP [
	| sequence |
	"EXP(A,B)->
	  sequence +
		 value := a ** b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForEXP: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testGT [
	| sequence |
	"GT(A,B)->
	  sequence +
		 value := a > b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForGT: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testLT [
	| sequence |
	"LT(A,B)->
	  sequence +
		 value := a < b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForLT: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testMOD [
	| sequence |
	"MOD(A,B)->
	  sequence +
		 value := a mod b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForMOD: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testMUL [
	| sequence |
	"MUL(A,B)->
	  sequence +
		 value := a * b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForMUL: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #test }
FogEVMDecompileAndUnifyRandomizedTest >> testMULMOD [
	| sequence |
	" 
	MULMOD(A,B,C)->
	 sequence +
	  summod := (a * b) mod c.
	 stack +
	  summod
	"
	sequence := self
		decompile: (self createBytecodeForMULMOD: x and: y and: z).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyRandomizedTest >> testPOP [
	
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
FogEVMDecompileAndUnifyRandomizedTest >> testSAR [
	| sequence |
	"SAR(A,B)->
	  sequence +
		 value := a sar b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSAR: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSDIV [
	| sequence |
	"SDIV(A,B)->
	  sequence +
		 value := a sdiv b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSDIV: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSGT [
	| sequence |
	"SGT(A,B)->
	  sequence +
		 value := a sdiv b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSGT: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSHL [
	| sequence |
	"SHL(A,B)->
	  sequence +
		 value := a << b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSHL: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSHR [
 | sequence |
	"SHR(A,B)->
	  sequence +
		 value := a >> b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSHR: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #test }
FogEVMDecompileAndUnifyRandomizedTest >> testSIGNEXTEND [
	| sequence |
	"
	SIGNEXTEND(VALUE, LENGTH) ->
	 sequence + 
	  extendedValue := value extend: length.
	 stack + 
	  extendedValue. 
	"
	z := Hexadecimal new write0xHexadecimal: (generator nextInt: 30) + 1.
	sequence := self decompile: (self createBytecodeForSIGNEXTEND: y of: 16 to: z).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSLT [
 | sequence |
	"SHR(A,B)->
	  sequence +
		 value := a signedLesserThan b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSLT: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
	
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSMOD [
 | sequence |
	"SMOD(A,B)->
	  sequence +
		 value := a smod b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSMOD: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #'test binary op bytecode' }
FogEVMDecompileAndUnifyRandomizedTest >> testSUB [
	| sequence |
	"SMOD(A,B)->
	  sequence +
		 value := a - b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForSUB: x and: y).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions
]
