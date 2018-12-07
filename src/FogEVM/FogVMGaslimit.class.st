"
Get the blocks gas limit
"
Class {
	#name : #FogVMGaslimit,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMGaslimit class >> byteCode [
<doc>
		^'0x45'.
	
]

{ #category : #'as yet unclassified' }
FogVMGaslimit class >> description [ 
<doc>
	^ 'Get the blocks gas limit'
]

{ #category : #generated }
FogVMGaslimit class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMGaslimit class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGaslimit class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMGaslimit class >> goCode [
<doc>
	^ 'func opGasLimit(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().SetUint64(interpreter.evm.GasLimit)))
	retu'
]

{ #category : #generated }
FogVMGaslimit class >> mnemonic [
<doc>
		^'GASLIMIT'.
	
]
