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
		^'0xfd'.
	
]

{ #category : #'as yet unclassified' }
FogVMRevert class >> description [
	^ 'Halts the execution as a return, reverting all the changes. '
]

{ #category : #generated }
FogVMRevert class >> expectedPops [
	^ 2
]

{ #category : #generated }
FogVMRevert class >> expectedPushes [
	^ 0
]

{ #category : #generated }
FogVMRevert class >> goCode [
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
	^ self memoryTable at: #memoryRevert
]

{ #category : #generated }
FogVMRevert class >> mnemonic [
		^'REVERT'.
	
]

{ #category : #generated }
FogVMRevert class >> returns [
	^ true 
]

{ #category : #generated }
FogVMRevert class >> reverts [
	^ true
]
