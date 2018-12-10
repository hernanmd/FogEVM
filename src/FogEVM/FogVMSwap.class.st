"
Exchange 1st and 2nd stack items
"
Class {
	#name : #FogVMSwap,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSwap class >> byteCode [
	<doc>
	^ nil
]

{ #category : #'as yet unclassified' }
FogVMSwap class >> description [ 
<doc>
	^ 'Exchange 1st and 2nd stack items'
]

{ #category : #generated }
FogVMSwap class >> fetchGoCode [
<doc>
| stream lowcaseStream selector bytes goCode |
	stream := 'instructions.go' asFileReference readStream.
	lowcaseStream := stream contents asLowercase readStream.
	selector := 'func makeSwap' asLowercase.
	lowcaseStream upToAll: selector.
	stream position: lowcaseStream position - selector size.
	bytes := (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size.
	goCode := stream next: bytes.
	self class
		compile:
			('goCode
	^ ''{1}''' format: {goCode})
		classified: #generated
]

{ #category : #generated }
FogVMSwap class >> goCode [
<doc>
	^ 'func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		'
]

{ #category : #'go configuration' }
FogVMSwap class >> validateStack: aString [
<doc>
	| stream pushes |
	stream := aString readStream.
	stream upTo: $(.
	pushes := (stream upTo: $)) trimBoth asNumber.
	self assert: self expectedPops equals: pushes.
	self assert: self expectedPushes equals: pushes 
]
