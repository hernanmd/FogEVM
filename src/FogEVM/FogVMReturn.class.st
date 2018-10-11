"
Halt execution returning output data
"
Class {
	#name : #FogVMReturn,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMReturn class >> byteCode [
		^'0xf3'.
	
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> description [ 
	^ 'Halt execution returning output data'
]

{ #category : #generated }
FogVMReturn class >> expectedPops [
		^2.
	
]

{ #category : #generated }
FogVMReturn class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> gas [
		^ self gasTable at: #gasReturn.

]

{ #category : #generated }
FogVMReturn class >> goCode [
	^ 'func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))
	return'
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> halts [
		^ true.

]

{ #category : #'as yet unclassified' }
FogVMReturn class >> memoryUsage [
		^ self memoryTable at: #memoryReturn.

]

{ #category : #generated }
FogVMReturn class >> mnemonic [
		^'RETURN'.
	
]

{ #category : #testing }
FogVMReturn >> isFinishStatus [
	^true
]
