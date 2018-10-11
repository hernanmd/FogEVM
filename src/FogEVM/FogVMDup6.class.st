"
Duplicates the item 6 at the stack and push it
"
Class {
	#name : #FogVMDup6,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup6 class >> byteCode [ 
	^'0x85'
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> description [ 
	^ 'Duplicates the item 6 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> expectedPops [ 
	^6
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> expectedPushes [ 
	^7
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup6 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> mnemonic [
	^ 'DUP6'
]
