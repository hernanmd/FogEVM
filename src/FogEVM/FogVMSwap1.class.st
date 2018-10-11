"
Exchange 1st and 1 stack items.
"
Class {
	#name : #FogVMSwap1,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> byteCode [ 
	^'0x90'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> description [ 
	^ 'Exchange 1st and 1 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> expectedPops [
	^ 2
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> expectedPushes [
	^ 2
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap1 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> mnemonic [
	^ 'SWAP1'
]
