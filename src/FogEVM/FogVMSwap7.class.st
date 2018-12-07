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
<doc>
	^'0x96'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> description [ 
<doc>
	^ 'Exchange 1st and 7 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> expectedPops [
<doc>
	^ 8
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> expectedPushes [
<doc>
	^ 8
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap7 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap7 class >> mnemonic [
<doc>
	^ 'SWAP7'
]
