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
<doc>
	^'0x92'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> description [ 
<doc>
	^ 'Exchange 1st and 3 stack items.'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> expectedPops [
<doc>
	^ 4
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> expectedPushes [
<doc>
	^ 4
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap3 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'as yet unclassified' }
FogVMSwap3 class >> mnemonic [
<doc>
	^ 'SWAP3'
]
