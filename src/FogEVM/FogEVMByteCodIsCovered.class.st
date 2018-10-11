Class {
	#name : #FogEVMByteCodIsCovered,
	#superclass : #TestCase,
	#category : #'FogEVM-Tests'
}

{ #category : #tests }
FogEVMByteCodIsCovered >> testBytecodeIsCovered [
	self assert: FogEVMInstruction checkUnImplementedBytecodes isEmpty
]
