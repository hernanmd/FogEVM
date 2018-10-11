"
Duplicates the item 11 at the stack and push it
"
Class {
	#name : #FogVMDup11,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup11 class >> byteCode [ 
	^'0x8a'
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> description [ 
	^ 'Duplicates the item 11 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> expectedPops [ 
	^11
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> expectedPushes [ 
	^12
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup11 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> mnemonic [
	^ 'DUP11'
]
