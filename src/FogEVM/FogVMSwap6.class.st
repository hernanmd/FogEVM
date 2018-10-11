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
	^'0x95'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> description [ 
	^ 'Exchange 1st and 6 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> expectedPops [
	^ 7
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> expectedPushes [
	^ 7
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap6 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap6 class >> mnemonic [
	^ 'SWAP6'
]
