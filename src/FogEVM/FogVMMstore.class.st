"
Save word to memory
"
Class {
	#name : #FogVMMstore,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMstore class >> byteCode [
		^'0x52'.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> description [ 
	^ 'Save word to memory'
]

{ #category : #generated }
FogVMMstore class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMMstore class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> gas [
		^ self gasTable at: #gasMStore.

]

{ #category : #generated }
FogVMMstore class >> goCode [
	^ 'func opMstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// pop value of the stack
	mStart, val := stack.pop(), stack.pop()
	memory.Set32(mStart.Uint64(), val)

	interpreter.intPool.put(mStart, val)
	return'
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> memoryUsage [
		^ self memoryTable at: #memoryMStore.

]

{ #category : #generated }
FogVMMstore class >> mnemonic [
		^'MSTORE'.
	
]
