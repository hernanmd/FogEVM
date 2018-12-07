"
Get size of an accounts code
"
Class {
	#name : #FogVMExtcodesize,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMExtcodesize class >> byteCode [
<doc>
		^'0x3b'.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodesize class >> description [ 
<doc>
	^ 'Get size of an accounts code'
]

{ #category : #generated }
FogVMExtcodesize class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMExtcodesize class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodesize class >> gas [
<doc>
		^ self gasTable at: #gasExtCodeSize.
]

{ #category : #generated }
FogVMExtcodesize class >> goCode [
<doc>
	^ 'func opExtCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetUint64(uint64(interpreter.evm.StateDB.GetCodeSize(common.BigToAddress(slot))))

	r'
]

{ #category : #generated }
FogVMExtcodesize class >> mnemonic [
<doc>
		^'EXTCODESIZE'.
	
]
