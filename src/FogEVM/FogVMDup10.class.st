"
Duplicates the item 10 at the stack and push it
"
Class {
	#name : #FogVMDup10,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup10 class >> byteCode [ 
	^'0x89'
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> description [ 
	^ 'Duplicates the item 10 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> expectedPops [ 
	^10
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> expectedPushes [ 
	^11
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup10 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> mnemonic [
	^ 'DUP10'
]
