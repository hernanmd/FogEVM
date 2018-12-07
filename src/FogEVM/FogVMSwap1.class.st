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
<doc>
	^'0x90'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> description [ 
<doc>
	^ 'Exchange 1st and 1 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> expectedPops [
<doc>
	^ 2
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> expectedPushes [
<doc>
	^ 2
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap1 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap1 class >> mnemonic [
<doc>
	^ 'SWAP1'
]
