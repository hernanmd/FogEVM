"
Exchange 1st and 11 stack items.
"
Class {
	#name : #FogVMSwap11,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> byteCode [ 
	^'0x9a'
]

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> description [ 
	^ 'Exchange 1st and 11 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> expectedPops [
	^ 12
]

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> expectedPushes [
	^ 12
]

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap11 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap11 class >> mnemonic [
	^ 'SWAP11'
]
