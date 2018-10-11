"
Exchange 1st and 14 stack items.
"
Class {
	#name : #FogVMSwap14,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> byteCode [ 
	^'0x9d'
]

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> description [ 
	^ 'Exchange 1st and 14 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> expectedPops [
	^ 15
]

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> expectedPushes [
	^ 15
]

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap14 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap14 class >> mnemonic [
	^ 'SWAP14'
]
