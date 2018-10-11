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
	^'0x97'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> description [ 
	^ 'Exchange 1st and 8 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> expectedPops [
	^ 9
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> expectedPushes [
	^ 9
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap8 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap8 class >> mnemonic [
	^ 'SWAP8'
]
