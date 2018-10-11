"
Duplicates the item 15 at the stack and push it
"
Class {
	#name : #FogVMDup15,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup15 class >> byteCode [ 
	^'0x8e'
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> description [ 
	^ 'Duplicates the item 15 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> expectedPops [ 
	^15
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> expectedPushes [ 
	^16
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup15 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> mnemonic [
	^ 'DUP15'
]
