"
Exchange 1st and 15 stack items.
"
Class {
	#name : #FogVMSwap15,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> byteCode [ 
	^'0x9e'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> description [ 
	^ 'Exchange 1st and 15 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> expectedPops [
	^ 16
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> expectedPushes [
	^ 16
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap15 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> mnemonic [
	^ 'SWAP15'
]
