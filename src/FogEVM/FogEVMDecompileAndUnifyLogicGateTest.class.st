Class {
	#name : #FogEVMDecompileAndUnifyLogicGateTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #test }
FogEVMDecompileAndUnifyLogicGateTest >> testAND [
	| sequence |
	"AND(A,B)->
	  sequence +
		 value := A and: B
	  stack + 
	    value
	"
	sequence := self
		decompile: (self createBytecodeForAND: '0x1' and: '0x1').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
]

{ #category : #test }
FogEVMDecompileAndUnifyLogicGateTest >> testISZERO [
	| sequence |
	"ISZERO(A)->
	  sequence +
		 value := A = 0
	  stack + 
	    value
	"
	bytecode := self createBytecodeForISZERO: '0x1'.
	sequence := self decompile: bytecode.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLogicGateTest >> testNOT [
	| sequence |
	"NOT(A) ->
	 sequence +
     notA := A negated.
	 stack +
	  notA
   "
	sequence := self decompile: (self createBytecodeForNOT: '0x1').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions.
	
]

{ #category : #test }
FogEVMDecompileAndUnifyLogicGateTest >> testOR [
	| sequence |
	"OR(A,B)->
	  sequence +
		 value := A or: B
	  stack + 
	    value
	"
	sequence := self
		decompile: (self createBytecodeForOR: '0x1' and: '0x1').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLogicGateTest >> testXOR [
	| sequence |
	"XOR(A,B)->
	  sequence +
		 value := A xor: B
	  stack + 
	    value
	"
	sequence := self
		decompile: (self createBytecodeForXOR: '0x1' and: '0x0').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements first value.
	self assert: sequence allInstructions equals: bytecode instructions
]
