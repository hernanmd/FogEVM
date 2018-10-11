"
Halt execution and register account for later deletion
"
Class {
	#name : #FogVMSelfdestruct,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSelfdestruct class >> byteCode [
		^'0xff'.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> description [ 
	^ 'Halt execution and register account for later deletion'
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> gas [
		^ self gasTable at: #gasSuicide.

]

{ #category : #generated }
FogVMSelfdestruct class >> goCode [
	^ 'func opSuicide(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	balance := interpreter.evm.StateDB.GetBalance(contract.Address())
	interpreter.evm.StateDB.AddBalance(common.BigToAddress(stack.pop()), balance)

	interpreter.evm.StateDB.Suicide(contract.Address())
	return nil, nil
}'
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> halts [
		^ true.

]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonic [
		^'SELFDESTRUCT'.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonicForCrawl [
	^ 'SUICIDE'
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> writes [
		^ true.

]
