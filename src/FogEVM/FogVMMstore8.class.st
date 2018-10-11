"
Save byte to memory
"
Class {
	#name : #FogVMMstore8,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMstore8 class >> byteCode [
		^'0x53'.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore8 class >> description [ 
	^ 'Save byte to memory'
]

{ #category : #generated }
FogVMMstore8 class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMMstore8 class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore8 class >> gas [
		^ self gasTable at: #gasMStore8.

]

{ #category : #generated }
FogVMMstore8 class >> goCode [
	^ 'func opMstore8(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	off, val := stack.pop().Int64(), stack.pop().Int64()
	memory.store[off] = byte(val & 0xff)

	retur'
]

{ #category : #'as yet unclassified' }
FogVMMstore8 class >> memoryUsage [
		^ self memoryTable at: #memoryMStore8.

]

{ #category : #generated }
FogVMMstore8 class >> mnemonic [
		^'MSTORE8'.
	
]
