Class {
	#name : #FogEVMDecompileAndUnifyControlFlowTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #test }
FogEVMDecompileAndUnifyControlFlowTest >> testJUMP [
	| sequence |
	"
	JUMP(Address) ->
		sequence +
		 jump(address)
      stack +
	"
	sequence := self decompile: (self createBytecodeForJUMP: '0x24').
	self assert: sequence statements size equals: 1.
	self assert: sequence allInstructions size equals: 4.
	self assert: sequence statements last isStrictJump.

]

{ #category : #test }
FogEVMDecompileAndUnifyControlFlowTest >> testJUMPI [
	| sequence  |
	"JUMPI(Position, Condition)->
		sequence +
		 jumpi(condition, address) -> subsecuence
		stack + 
	"
	
	sequence := self decompile: (self createBytecodeForJUMPIDecompilation: '0x1' Pointer: '0x45').
	"Main scope related test"
	self assert: sequence allInstructions size equals: 5.
	self assert: sequence allInstructions last isFinishStatus.
	self assert: sequence statements size equals: 1.
	self assert: sequence statements first isConditionalJump .
]

{ #category : #test }
FogEVMDecompileAndUnifyControlFlowTest >> testPC [
	| sequence |
	"
	PC-> 
	sequence + 
	 pc := runtime currentProcessCounter
	stack +
	 pc	
	"
	sequence := self decompile: self createBytecodeForPCDecompile.
	self assert: sequence statements size equals: 1 .
	self assert: sequence allInstructions size equals: 2 .
	self assertIsRuntimeGlobal: sequence statements first value receiver.
]

{ #category : #test }
FogEVMDecompileAndUnifyControlFlowTest >> testSTOP [
	| sequence |
	"STOP->
	  sequence 
	  stack
	"
	sequence := self decompile: self createBytecodeForSTOP.
	self assert: sequence allInstructions size equals: 1.
	self assert: sequence statements isEmpty.
	self assert: sequence isClosed.
	self should: [ sequence addStatement: nil ] raise: Error
]
