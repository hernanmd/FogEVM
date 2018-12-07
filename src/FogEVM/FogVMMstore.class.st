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
<doc>
		^'0x52'.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> description [ 
<doc>
	^ 'Save word to memory'
]

{ #category : #generated }
FogVMMstore class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMMstore class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> gas [
<doc>
		^ self gasTable at: #gasMStore.
]

{ #category : #generated }
FogVMMstore class >> goCode [
<doc>
	^ 'func opMstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// pop value of the stack
	mStart, val := stack.pop(), stack.pop()
	memory.Set32(mStart.Uint64(), val)

	interpreter.intPool.put(mStart, val)
	return'
]

{ #category : #'as yet unclassified' }
FogVMMstore class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryMStore.
]

{ #category : #generated }
FogVMMstore class >> mnemonic [
<doc>
		^'MSTORE'.
	
]
