"
Duplicates the item 13 at the stack and push it
"
Class {
	#name : #FogVMDup13,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup13 class >> byteCode [ 
	^'0x8c'
]

{ #category : #'as yet unclassified' }
FogVMDup13 class >> description [ 
	^ 'Duplicates the item 13 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup13 class >> expectedPops [ 
	^13
]

{ #category : #'as yet unclassified' }
FogVMDup13 class >> expectedPushes [ 
	^14
]

{ #category : #'as yet unclassified' }
FogVMDup13 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup13 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup13 class >> mnemonic [
	^ 'DUP13'
]
