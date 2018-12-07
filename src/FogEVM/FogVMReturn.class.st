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
<doc>
		^'0xf3'.
	
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> description [ 
<doc>
	^ 'Halt execution returning output data'
]

{ #category : #generated }
FogVMReturn class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMReturn class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> gas [
<doc>
		^ self gasTable at: #gasReturn.
]

{ #category : #generated }
FogVMReturn class >> goCode [
<doc>
	^ 'func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))
	return'
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> halts [
<doc>
		^ true.
]

{ #category : #'as yet unclassified' }
FogVMReturn class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryReturn.
]

{ #category : #generated }
FogVMReturn class >> mnemonic [
<doc>
		^'RETURN'.
	
]

{ #category : #testing }
FogVMReturn >> isFinishStatus [
	^true
]
