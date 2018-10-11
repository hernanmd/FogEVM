"
Exchange 1st and 10 stack items.
"
Class {
	#name : #FogVMSwap10,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> byteCode [ 
	^'0x99'
]

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> description [ 
	^ 'Exchange 1st and 10 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> expectedPops [
	^ 11
]

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> expectedPushes [
	^ 11
]

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap10 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap10 class >> mnemonic [
	^ 'SWAP10'
]
