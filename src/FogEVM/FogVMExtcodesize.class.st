"
Get size of an account's code
"
Class {
	#name : #FogVMExtcodesize,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMExtcodesize class >> byteCode [
		^'0x3b'.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodesize class >> description [ 
	^ 'Get size of an accounts code'
]

{ #category : #generated }
FogVMExtcodesize class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMExtcodesize class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodesize class >> gas [
		^ self gasTable at: #gasExtCodeSize.

]

{ #category : #generated }
FogVMExtcodesize class >> goCode [
	^ 'func opExtCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetUint64(uint64(interpreter.evm.StateDB.GetCodeSize(common.BigToAddress(slot))))

	r'
]

{ #category : #generated }
FogVMExtcodesize class >> mnemonic [
		^'EXTCODESIZE'.
	
]
