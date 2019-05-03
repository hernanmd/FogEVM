Class {
	#name : #FogEVMDecompileLogicGateTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #test }
FogEVMDecompileLogicGateTest >> testAND [
	| sequence |
	"AND(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a and: b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForAND: '0x1' and: '0x1').
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #and:
]

{ #category : #test }
FogEVMDecompileLogicGateTest >> testISZERO [
	| sequence |
	"ISZERO(A)->
	  sequence +
	    a := A.
		 value := a = 0
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForISZERO: '0x1').
	self assert: sequence statements size equals: 2.
	self assert: sequence allInstructions size equals: 3.
	self assertIsBinaryOperation: sequence statements last value selector: #equals:.
	self assert: decompiler scope stack size equals: 1.
	self assert: decompiler scope stack pop equals: sequence statements last variable
]

{ #category : #test }
FogEVMDecompileLogicGateTest >> testNOT [
	| sequence |
	"NOT(A) ->
	 sequence +
     a := A.
     notA := a negated.
	 stack +
	  notA
   "
	sequence := self decompile: (self createBytecodeForNOT: '0x1').
	self assert: sequence allInstructions size equals: 3.
	self assert: sequence statements size equals: 2.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence statements first variable equals: sequence statements last value receiver
]

{ #category : #test }
FogEVMDecompileLogicGateTest >> testOR [
	| sequence |
	"OR(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a or: b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForOR: '0x1' and: '0x1').
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #or:
]

{ #category : #test }
FogEVMDecompileLogicGateTest >> testXOR [
		| sequence |
	"XOR(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 value := a xor: b
	  stack + 
	    value
	"
	sequence := self decompile: (self createBytecodeForXOR: '0x1' and: '0x0').
	self assertIsBinaryOperationBytecode: sequence stack: decompiler scope stack selector: #xor:
]
