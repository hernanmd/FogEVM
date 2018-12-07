"
Halts the execution as a return, reverting all the changes. 
"
Class {
	#name : #FogVMRevert,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMRevert class >> byteCode [
<doc>
		^'0xfd'.
	
]

{ #category : #'as yet unclassified' }
FogVMRevert class >> description [
<doc>
	^ 'Halts the execution as a return, reverting all the changes. '
]

{ #category : #generated }
FogVMRevert class >> expectedPops [
<doc>
	^ 2
]

{ #category : #generated }
FogVMRevert class >> expectedPushes [
<doc>
	^ 0
]

{ #category : #generated }
FogVMRevert class >> goCode [
<doc>
	^ '
	func opRevert(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	ret := memory.GetPtr(offset.Int64(), size.Int64())

	interpreter.intPool.put(offset, size)
	return ret, nil
}
	'
]

{ #category : #generated }
FogVMRevert class >> memoryUsage [
<doc>
	^ self memoryTable at: #memoryRevert
]

{ #category : #generated }
FogVMRevert class >> mnemonic [
<doc>
		^'REVERT'.
	
]

{ #category : #generated }
FogVMRevert class >> returns [
<doc>
	^ true 
]

{ #category : #generated }
FogVMRevert class >> reverts [
<doc>
	^ true
]
