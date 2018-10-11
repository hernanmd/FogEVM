"
Place 1 byte item on stack
"
Class {
	#name : #FogVMDup,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup class >> byteCode [
	^ 'no-apply '
]

{ #category : #'as yet unclassified' }
FogVMDup class >> description [ 
	^ 'Place 1 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMDup class >> fetchGoCode [
	| stream lowcaseStream selector bytes goCode |
	stream := 'instructions.go' asFileReference readStream.
	lowcaseStream := stream contents asLowercase readStream.
	selector := 'func makeDup' asLowercase.
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
FogVMDup class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #generated }
FogVMDup class >> validateStack: aString [
	| stream pushes |
	stream := aString readStream.
	stream upTo: $(.
	pushes := (stream upTo: $)) trimBoth asNumber.
	self assert: self expectedPops equals: pushes.
	self assert: self expectedPushes equals: pushes + 1
]
