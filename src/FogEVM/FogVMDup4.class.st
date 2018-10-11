"
Duplicates the item 4 at the stack and push it
"
Class {
	#name : #FogVMDup4,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup4 class >> byteCode [ 
	^'0x83'
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> description [ 
	^ 'Duplicates the item 4 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> expectedPops [ 
	^4
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> expectedPushes [ 
	^5
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup4 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> mnemonic [
	^ 'DUP4'
]
