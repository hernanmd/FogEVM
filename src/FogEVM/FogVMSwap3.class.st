"
Exchange 1st and 3 stack items.
"
Class {
	#name : #FogVMSwap3,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> byteCode [ 
	^'0x92'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> description [ 
	^ 'Exchange 1st and 3 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> expectedPops [
	^ 4
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> expectedPushes [
	^ 4
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> gas [
		^ self gasTable at: #gasSwap.

]

{ #category : #generated }
FogVMSwap3 class >> goCode [
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> mnemonic [
	^ 'SWAP3'
]
