"
Duplicates the item 8 at the stack and push it
"
Class {
	#name : #FogVMDup8,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup8 class >> byteCode [ 
	^'0x87'
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> description [ 
	^ 'Duplicates the item 8 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> expectedPops [ 
	^8
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> expectedPushes [ 
	^9
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup8 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> mnemonic [
	^ 'DUP8'
]
