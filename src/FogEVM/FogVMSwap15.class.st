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
<doc>
	^'0x9e'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> description [ 
<doc>
	^ 'Exchange 1st and 15 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> expectedPops [
<doc>
	^ 16
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> expectedPushes [
<doc>
	^ 16
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap15 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap15 class >> mnemonic [
<doc>
	^ 'SWAP15'
]
