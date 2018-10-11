"
Duplicates the item 3 at the stack and push it
"
Class {
	#name : #FogVMDup3,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup3 class >> byteCode [ 
	^'0x82'
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> description [ 
	^ 'Duplicates the item 3 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> expectedPops [ 
	^3
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> expectedPushes [ 
	^4
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup3 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> mnemonic [
	^ 'DUP3'
]
