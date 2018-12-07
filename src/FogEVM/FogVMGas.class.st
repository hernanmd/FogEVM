"
Get the amount of available gas, including the corresponding reduction 
"
Class {
	#name : #FogVMGas,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMGas class >> byteCode [
<doc>
		^'0x5a'.
	
]

{ #category : #'as yet unclassified' }
FogVMGas class >> description [ 
<doc>
	^ 'Get the amount of available gas, including the corresponding reduction '
]

{ #category : #generated }
FogVMGas class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMGas class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGas class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMGas class >> goCode [
<doc>
	^ 'func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	return ni'
]

{ #category : #generated }
FogVMGas class >> mnemonic [
<doc>
		^'GAS'.
	
]
