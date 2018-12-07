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
<doc>
		^'0x51'.
	
]

{ #category : #'as yet unclassified' }
FogVMMload class >> description [ 
<doc>
	^ 'Load word from memory'
]

{ #category : #generated }
FogVMMload class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMMload class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMMload class >> gas [
<doc>
		^ self gasTable at: #gasMLoad.
]

{ #category : #generated }
FogVMMload class >> goCode [
<doc>
	^ 'func opMload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset := stack.pop()
	val := interpreter.intPool.get().SetBytes(memory.Get(offset.Int64(), 32))
	stack.push(val)

	interpreter.intPool.put(offset)
	return '
]

{ #category : #'as yet unclassified' }
FogVMMload class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryMLoad.
]

{ #category : #generated }
FogVMMload class >> mnemonic [
<doc>
		^'MLOAD'.
	
]
