"
Exchange 1st and 4 stack items.
"
Class {
	#name : #FogVMSwap4,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> byteCode [ 
	^'0x93'
]

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> description [ 
	^ 'Exchange 1st and 4 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> expectedPops [
	^ 5
]

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> expectedPushes [
	^ 5
]

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap4 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap4 class >> mnemonic [
	^ 'SWAP4'
]
