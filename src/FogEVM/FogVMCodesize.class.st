"
Get size of code running in current environment
"
Class {
	#name : #FogVMCodesize,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCodesize class >> byteCode [
<doc>
		^'0x38'.
	
]

{ #category : #'as yet unclassified' }
FogVMCodesize class >> description [ 
<doc>
	^ 'Get size of code running in current environment'
]

{ #category : #generated }
FogVMCodesize class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMCodesize class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMCodesize class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMCodesize class >> goCode [
<doc>
	^ 'func opCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	l := interpreter.intPool.get().SetInt64(int64(len(contract.Code)))
	stack.push(l)

	retu'
]

{ #category : #generated }
FogVMCodesize class >> mnemonic [
<doc>
		^'CODESIZE'.
	
]
