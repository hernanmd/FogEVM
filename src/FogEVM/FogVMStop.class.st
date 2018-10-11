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
		^'0x00'.
	
]

{ #category : #'as yet unclassified' }
FogVMStop class >> description [ 
	^ 'Halts execution'
]

{ #category : #generated }
FogVMStop class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMStop class >> expectedPushes [
		^0.
	
]

{ #category : #generated }
FogVMStop class >> gas [
	^ self gasTable at: #constGasFunc
]

{ #category : #generated }
FogVMStop class >> goCode [
	^ 'func opStop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	return n'
]

{ #category : #generated }
FogVMStop class >> mnemonic [
		^'STOP'.
	
]

{ #category : #testing }
FogVMStop >> isFinishStatus [
	^ true
]
