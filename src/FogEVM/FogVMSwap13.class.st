"
Exchange 1st and 13 stack items.
"
Class {
	#name : #FogVMSwap13,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> byteCode [ 
<doc>
	^'0x9c'
]

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> description [ 
<doc>
	^ 'Exchange 1st and 13 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> expectedPops [
<doc>
	^ 14
]

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> expectedPushes [
<doc>
	^ 14
]

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap13 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap13 class >> mnemonic [
<doc>
	^ 'SWAP13'
]
