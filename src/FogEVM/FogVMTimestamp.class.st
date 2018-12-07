"
Get the block's timestamp
"
Class {
	#name : #FogVMTimestamp,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMTimestamp class >> byteCode [
<doc>
		^'0x42'.
	
]

{ #category : #'as yet unclassified' }
FogVMTimestamp class >> description [ 
<doc>
	^ 'Get the blocks timestamp'
]

{ #category : #generated }
FogVMTimestamp class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMTimestamp class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMTimestamp class >> gas [
<doc>
		^ self gasTable at: #GasQuickStep.
]

{ #category : #generated }
FogVMTimestamp class >> goCode [
<doc>
	^ 'func opTimestamp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Time)))
	ret'
]

{ #category : #generated }
FogVMTimestamp class >> mnemonic [
	<doc>
	^ 'TIMESTAMP'
]
