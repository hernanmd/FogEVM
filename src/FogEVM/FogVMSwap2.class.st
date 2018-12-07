"
Exchange 1st and 2 stack items.
"
Class {
	#name : #FogVMSwap2,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSwap2 class >> byteCode [ 
<doc>
	^'0x91'
]

{ #category : #'as yet unclassified' }
FogVMSwap2 class >> description [ 
<doc>
	^ 'Exchange 1st and 2 stack items.'
]

{ #category : #generated }
FogVMSwap2 class >> expectedPops [
<doc>
	^ 3
]

{ #category : #generated }
FogVMSwap2 class >> expectedPushes [
<doc>
	^ 3
]

{ #category : #'as yet unclassified' }
FogVMSwap2 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap2 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #generated }
FogVMSwap2 class >> mnemonic [
<doc>
	^ 'SWAP2'
]
