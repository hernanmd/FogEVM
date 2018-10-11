"
Duplicates the item 7 at the stack and push it
"
Class {
	#name : #FogVMDup7,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup7 class >> byteCode [ 
	^'0x86'
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> description [ 
	^ 'Duplicates the item 7 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> expectedPops [ 
	^7
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> expectedPushes [ 
	^8
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> gas [
		^ self gasTable at: #gasDup.

]

{ #category : #generated }
FogVMDup7 class >> goCode [
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> mnemonic [
	^ 'DUP7'
]
