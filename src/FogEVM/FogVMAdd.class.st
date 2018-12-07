"
Addition operation
"
Class {
	#name : #FogVMAdd,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAdd class >> byteCode [
	<doc> 
	^ '0x01'
]

{ #category : #'as yet unclassified' }
FogVMAdd class >> description [ 
<doc>
	^ 'Addition operation'
]

{ #category : #generated }
FogVMAdd class >> expectedPops [
	<doc>
	^ 2
]

{ #category : #generated }
FogVMAdd class >> expectedPushes [
	<doc>
	^ 1
]

{ #category : #'as yet unclassified' }
FogVMAdd class >> gas [
<doc>
	^ self gasTable at: #GasFastestStep
]

{ #category : #generated }
FogVMAdd class >> goCode [
	<doc>
	^ 'func opAdd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	math.U256(y.Add(x, y))

	interpreter.intPool.put(x)
	return nil'
]

{ #category : #generated }
FogVMAdd class >> mnemonic [
	<doc>
	^ 'ADD'
]
