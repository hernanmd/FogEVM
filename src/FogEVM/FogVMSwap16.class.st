"
Exchange 1st and 16 stack items.
"
Class {
	#name : #FogVMSwap16,
	#superclass : #FogVMSwap,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSwap16 class >> byteCode [ 
<doc>
	^'0x9f'
]

{ #category : #'as yet unclassified' }
FogVMSwap16 class >> description [ 
<doc>
	^ 'Exchange 1st and 16 stack items.'
]

{ #category : #generated }
FogVMSwap16 class >> expectedPops [
<doc>
	^ 17
]

{ #category : #generated }
FogVMSwap16 class >> expectedPushes [
<doc>
	^ 17
]

{ #category : #'as yet unclassified' }
FogVMSwap16 class >> gas [
<doc>
		^ self gasTable at: #gasSwap.
]

{ #category : #generated }
FogVMSwap16 class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #generated }
FogVMSwap16 class >> mnemonic [
<doc>
	^ 'SWAP16'
]
