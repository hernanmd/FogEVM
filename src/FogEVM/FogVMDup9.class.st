"
Duplicates the item 9 at the stack and push it
"
Class {
	#name : #FogVMDup9,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup9 class >> byteCode [ 
	^'0x88'
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> description [ 
	^ 'Duplicates the item 9 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> expectedPops [ 
	^9
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> expectedPushes [ 
	^10
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup9 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> mnemonic [
	^ 'DUP9'
]
