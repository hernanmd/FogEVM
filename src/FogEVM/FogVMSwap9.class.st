"
Exchange 1st and 9 stack items.
"
Class {
	#name : #FogVMSwap9,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> byteCode [ 
	^'0x98'
]

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> description [ 
	^ 'Exchange 1st and 9 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> expectedPops [
	^ 10
]

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> expectedPushes [
	^ 10
]

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap9 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap9 class >> mnemonic [
	^ 'SWAP9'
]
