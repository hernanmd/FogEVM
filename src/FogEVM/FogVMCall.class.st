"
Message-call into an account
"
Class {
	#name : #FogVMCall,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCall class >> byteCode [
		^'0xf1'.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> description [ 
	^ 'Message-call into an account'
]

{ #category : #generated }
FogVMCall class >> expectedPops [
		^7.
	
]

{ #category : #generated }
FogVMCall class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> gas [
		^ self gasTable at: #gasCall.

]

{ #category : #generated }
FogVMCall class >> goCode [
	^ 'func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return n'
]

{ #category : #'as yet unclassified' }
FogVMCall class >> memoryUsage [
		^ self memoryTable at: #memoryCall.

]

{ #category : #generated }
FogVMCall class >> mnemonic [
		^'CALL'.
	
]

{ #category : #'as yet unclassified' }
FogVMCall class >> returns [
		^ true.

]
