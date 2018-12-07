"
Exchange 1st and 6 stack items.
"
Class {
	#name : #FogVMSwap6,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> byteCode [ 
<doc>
	^'0x95'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> description [ 
<doc>
	^ 'Exchange 1st and 6 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> expectedPops [
<doc>
	^ 7
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> expectedPushes [
<doc>
	^ 7
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap6 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> mnemonic [
<doc>
	^ 'SWAP6'
]
