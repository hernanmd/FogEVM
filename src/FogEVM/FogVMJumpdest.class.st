"
Mark a valid destination for jumps
"
Class {
	#name : #FogVMJumpdest,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMJumpdest class >> byteCode [
		^'0x5b'.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpdest class >> description [ 
	^ 'Mark a valid destination for jumps'
]

{ #category : #generated }
FogVMJumpdest class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMJumpdest class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpdest class >> gas [
		^ self gasTable at: #JumpdestGas.

]

{ #category : #generated }
FogVMJumpdest class >> goCode [
	^ 'func opJumpdest(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	retu'
]

{ #category : #generated }
FogVMJumpdest class >> mnemonic [
		^'JUMPDEST'.
	
]

{ #category : #testing }
FogVMJumpdest >> isValidJumpDestination [
	^true
]
