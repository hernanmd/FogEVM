"
Load word from memory
"
Class {
	#name : #FogVMMload,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMMload class >> byteCode [
		^'0x51'.
	
]

{ #category : #'as yet unclassified' }
FogVMMload class >> description [ 
	^ 'Load word from memory'
]

{ #category : #generated }
FogVMMload class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMMload class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMMload class >> gas [
		^ self gasTable at: #gasMLoad.

]

{ #category : #generated }
FogVMMload class >> goCode [
	^ 'func opMload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset := stack.pop()
	val := interpreter.intPool.get().SetBytes(memory.Get(offset.Int64(), 32))
	stack.push(val)

	interpreter.intPool.put(offset)
	return '
]

{ #category : #'as yet unclassified' }
FogVMMload class >> memoryUsage [
		^ self memoryTable at: #memoryMLoad.

]

{ #category : #generated }
FogVMMload class >> mnemonic [
		^'MLOAD'.
	
]
