"
Duplicates the item 1 at the stack and push it
"
Class {
	#name : #FogVMDup1,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup1 class >> byteCode [ 
	^'0x80'
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> description [ 
	^ 'Duplicates the item 1 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> expectedPops [ 
	^1
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> expectedPushes [ 
	^2
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup1 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> mnemonic [
	^ 'DUP1'
]
