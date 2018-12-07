"
Halts execution
"
Class {
	#name : #FogVMStop,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMStop class >> byteCode [
<doc>
		^'0x00'.
	
]

{ #category : #'as yet unclassified' }
FogVMStop class >> description [ 
<doc>
	^ 'Halts execution'
]

{ #category : #generated }
FogVMStop class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMStop class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMStop class >> gas [
<doc>
	^ self gasTable at: #constGasFunc
]

{ #category : #generated }
FogVMStop class >> goCode [
<doc>
	^ 'func opStop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	return n'
]

{ #category : #generated }
FogVMStop class >> mnemonic [
<doc>
		^'STOP'.
	
]

{ #category : #testing }
FogVMStop >> isFinishStatus [
	^ true
]
