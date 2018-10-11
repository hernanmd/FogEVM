"
Duplicates the item 2 at the stack and push it
"
Class {
	#name : #FogVMDup2,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMDup2 class >> byteCode [ 
	^'0x81'
]

{ #category : #'as yet unclassified' }
FogVMDup2 class >> description [ 
	^ 'Duplicates the item 2 at the stack and push it'
]

{ #category : #generated }
FogVMDup2 class >> expectedPops [ 
	^2
]

{ #category : #generated }
FogVMDup2 class >> expectedPushes [ 
	^3
]

{ #category : #'as yet unclassified' }
FogVMDup2 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup2 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #generated }
FogVMDup2 class >> mnemonic [
	^ 'DUP2'
]
