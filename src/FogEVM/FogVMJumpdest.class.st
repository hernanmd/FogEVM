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
<doc>
		^'0x5b'.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpdest class >> description [ 
<doc>
	^ 'Mark a valid destination for jumps'
]

{ #category : #generated }
FogVMJumpdest class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMJumpdest class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMJumpdest class >> gas [
<doc>
		^ self gasTable at: #JumpdestGas.
]

{ #category : #generated }
FogVMJumpdest class >> goCode [
<doc>
	^ 'func opJumpdest(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	retu'
]

{ #category : #generated }
FogVMJumpdest class >> mnemonic [
<doc>
		^'JUMPDEST'.
	
]

{ #category : #testing }
FogVMJumpdest >> isValidJumpDestination [
	^true
]
