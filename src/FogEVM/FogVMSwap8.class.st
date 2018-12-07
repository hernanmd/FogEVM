"
Exchange 1st and 8 stack items.
"
Class {
	#name : #FogVMSwap8,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> byteCode [ 
<doc>
	^'0x97'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> description [ 
<doc>
	^ 'Exchange 1st and 8 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> expectedPops [
<doc>
	^ 9
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> expectedPushes [
<doc>
	^ 9
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap8 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> mnemonic [
<doc>
	^ 'SWAP8'
]
