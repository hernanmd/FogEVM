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
		^'0x45'.
	
]

{ #category : #'as yet unclassified' }
FogVMGaslimit class >> description [ 
	^ 'Get the blocks gas limit'
]

{ #category : #generated }
FogVMGaslimit class >> expectedPops [
		^0.
	
]

{ #category : #generated }
FogVMGaslimit class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMGaslimit class >> gas [
		^ self gasTable at: #GasQuickStep.

]

{ #category : #generated }
FogVMGaslimit class >> goCode [
	^ 'func opGasLimit(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().SetUint64(interpreter.evm.GasLimit)))
	retu'
]

{ #category : #generated }
FogVMGaslimit class >> mnemonic [
		^'GASLIMIT'.
	
]
