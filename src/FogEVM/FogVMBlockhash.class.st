"
Get the hash of one of the 256 most recent complete blocks
"
Class {
	#name : #FogVMBlockhash,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMBlockhash class >> byteCode [
<doc>
		^'0x40'.
	
]

{ #category : #'as yet unclassified' }
FogVMBlockhash class >> description [ 
<doc>
	^ 'Get the hash of one of the 256 most recent complete blocks'
]

{ #category : #generated }
FogVMBlockhash class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMBlockhash class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMBlockhash class >> gas [
<doc>
		^ self gasTable at: #GasExtStep.
]

{ #category : #generated }
FogVMBlockhash class >> goCode [
<doc>
	^ 'func opBlockhash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	num := stack.pop()

	n := interpreter.intPool.get().Sub(interpreter.evm.BlockNumber, common.Big257)
	if num.Cmp(n) > 0 && num.Cmp(interpreter.evm.BlockNumber) < 0 {
		stack.push(interpreter.evm.GetHash(num.Uint64()).Big())
	} else {
		stack.push(interpreter.intPool.getZero())
	}
	interpreter.intPool.put(num, n)
	ret'
]

{ #category : #generated }
FogVMBlockhash class >> mnemonic [
<doc>
		^'BLOCKHASH'.
	
]
