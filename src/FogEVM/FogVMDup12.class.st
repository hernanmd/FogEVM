"
Duplicates the item 12 at the stack and push it
"
Class {
	#name : #FogVMDup12,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup12 class >> byteCode [ 
	^'0x8b'
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> description [ 
	^ 'Duplicates the item 12 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> expectedPops [ 
	^12
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> expectedPushes [ 
	^13
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup12 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> mnemonic [
	^ 'DUP12'
]
