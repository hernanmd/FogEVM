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
<doc>
		^'0xff'.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> description [ 
<doc>
	^ 'Halt execution and register account for later deletion'
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPops [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> gas [
<doc>
		^ self gasTable at: #gasSuicide.
]

{ #category : #generated }
FogVMSelfdestruct class >> goCode [
<doc>
	^ 'func opSuicide(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	balance := interpreter.evm.StateDB.GetBalance(contract.Address())
	interpreter.evm.StateDB.AddBalance(common.BigToAddress(stack.pop()), balance)

	interpreter.evm.StateDB.Suicide(contract.Address())
	return nil, nil
}'
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> halts [
<doc>
		^ true.
]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonic [
<doc>
		^'SELFDESTRUCT'.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonicForCrawl [
<doc>
	^ 'SUICIDE'
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> writes [
<doc>
		^ true.
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct >> readsStorage [
	^ true.
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct >> writesStorage [
	^ true
]
