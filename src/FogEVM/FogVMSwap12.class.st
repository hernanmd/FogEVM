"
Exchange 1st and 12 stack items.
"
Class {
	#name : #FogVMSwap12,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> byteCode [ 
<doc>
	^'0x9b'
]

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> description [ 
<doc>
	^ 'Exchange 1st and 12 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> expectedPops [
<doc>
	^ 13
]

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> expectedPushes [
<doc>
	^ 13
]

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap12 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap12 class >> mnemonic [
<doc>
	^ 'SWAP12'
]
