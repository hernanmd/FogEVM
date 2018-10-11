"
Exchange 1st and 5 stack items.
"
Class {
	#name : #FogVMSwap5,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> byteCode [ 
	^'0x94'
]

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> description [ 
	^ 'Exchange 1st and 5 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> expectedPops [
	^ 6
]

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> expectedPushes [
	^ 6
]

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap5 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap5 class >> mnemonic [
	^ 'SWAP5'
]
