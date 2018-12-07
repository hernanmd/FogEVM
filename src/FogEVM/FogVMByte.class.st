"
Retrieve single byte from word
"
Class {
	#name : #FogVMByte,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMByte class >> byteCode [
<doc>
		^'0x1a'.
	
]

{ #category : #'as yet unclassified' }
FogVMByte class >> description [ 
<doc>
	^ 'Retrieve single byte from word'
]

{ #category : #generated }
FogVMByte class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMByte class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMByte class >> gas [
<doc>
		^ self gasTable at: #GasFastestStep.
]

{ #category : #generated }
FogVMByte class >> goCode [
<doc>
	^ 'func opByte(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	th, val := stack.pop(), stack.peek()
	if th.Cmp(common.Big32) < 0 {
		b := math.Byte(val, 32, int(th.Int64()))
		val.SetUint64(uint64(b))
	} else {
		val.SetUint64(0)
	}
	interpreter.intPool.put(th)
	return n'
]

{ #category : #generated }
FogVMByte class >> mnemonic [
<doc>
		^'BYTE'.
	
]
