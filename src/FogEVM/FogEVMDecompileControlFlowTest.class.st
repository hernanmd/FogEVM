Class {
	#name : #FogEVMDecompileControlFlowTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #test }
FogEVMDecompileControlFlowTest >> testJUMP [
	| sequence |
	"
	JUMP(Address) ->
		sequence +
		 address := Address
		 jump(address)
      stack +
	"
	sequence := self decompile: (self createBytecodeForJUMP: '0x24').
	self assert: sequence statements size equals: 2.
	self assert: sequence instructions size equals: 4.
	self assertIsAssignment: sequence statements first.
	self assert: sequence statements last isStrictJump.
	self assert: sequence statements last address equals: sequence statements first variable
]

{ #category : #test }
FogEVMDecompileControlFlowTest >> testJUMPI [
	| sequence conditionalSequence |
	"JUMPI(Position, Condition)->
		sequence +
		 condition := Condition.
		 position := Position.
		 jumpi(condition, address) -> subsecuence
		stack + 
	"
	
	sequence := self decompile: (self createBytecodeForJUMPIDecompilation: '0x1' Pointer: '0x45').
	"Main scope related test"
	self assert: sequence instructions size equals: 4.
	self assert: sequence instructions last isFinishStatus.
	self assert: sequence statements size equals: 3.
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.
	self assert: sequence statements last isConditionalJump.
	self assert: sequence statements last condition equals: sequence statements first variable.
	self assert: sequence statements last address equals: sequence statements second variable.
	self assert: decompiler scope stack isEmpty.

	"Conditional scope"
	conditionalSequence := sequence statements last scope sequence.
	self assert: conditionalSequence instructions size equals: 5.
	self assert: conditionalSequence instructions last isFinishStatus.
	self assert: conditionalSequence statements size equals: 3.
	self assertIsAssignment: conditionalSequence statements first.
	self assertIsAssignment: conditionalSequence statements second.
	self assertIsAssignment: conditionalSequence statements last.
	self assertIsBinaryOperation: conditionalSequence statements last value selector: #+.
	self assert: sequence statements last scope stack size equals: 1.
	self assert: sequence statements last scope stack pop equals: conditionalSequence statements last variable
]

{ #category : #test }
FogEVMDecompileControlFlowTest >> testPC [
	| sequence |
	"
	PC-> 
	sequence + 
	 runtime := #Runtime. 
	 pc := runtime currentProcessCounter
	stack +
	 pc	
	"
	sequence := self decompile: self createBytecodeForPCDecompile.
	self assert: sequence statements size equals: 2 .
	self assert: sequence instructions size equals: 1 .
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.
	self assertIsVariable: sequence statements first variable named: #Runtime.
	self assertIsRuntimeGlobal: sequence statements first value.
]

{ #category : #test }
FogEVMDecompileControlFlowTest >> testSTOP [
	| sequence |
	"STOP->
	  sequence 
	  stack
	"
	sequence := self decompile: self createBytecodeForSTOP.
	self assert: sequence instructions size equals: 1.
	self assert: sequence statements isEmpty.
	self assert: sequence isClosed.
	self should: [ sequence addStatement: nil ] raise: Error
]
