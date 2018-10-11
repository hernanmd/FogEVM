"
Exchange 1st and 7 stack items.
"
Class {
	#name : #FogVMSwap7,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> byteCode [ 
	^'0x96'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> description [ 
	^ 'Exchange 1st and 7 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> expectedPops [
	^ 8
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> expectedPushes [
	^ 8
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap7 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> mnemonic [
	^ 'SWAP7'
]
