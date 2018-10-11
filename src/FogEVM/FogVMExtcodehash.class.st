"
opExtCodeHash returns the code hash of a specified account.
"
Class {
	#name : #FogVMExtcodehash,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMExtcodehash class >> byteCode [
	^ '0x3f'
]

{ #category : #generated }
FogVMExtcodehash class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMExtcodehash class >> expectedPushes [
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodehash class >> gas [
		^ self gasTable at: #gasExtCodeHash.

]

{ #category : #generated }
FogVMExtcodehash class >> goCode [
	^ 'func opExtCodeHash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetBytes(interpreter.evm.StateDB.GetCodeHash(common.BigToAddress(slot)).Bytes())
	r'
]

{ #category : #generated }
FogVMExtcodehash class >> mnemonic [
		^'EXTCODEHASH'.
	
]
