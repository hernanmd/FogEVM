"
Duplicates the item 14 at the stack and push it
"
Class {
	#name : #FogVMDup14,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup14 class >> byteCode [ 
<doc>
	^'0x8d'
]

{ #category : #'as yet unclassified' }
FogVMDup14 class >> description [ 
<doc>
	^ 'Duplicates the item 14 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup14 class >> expectedPops [ 
<doc>
	^14
]

{ #category : #'as yet unclassified' }
FogVMDup14 class >> expectedPushes [ 
<doc>
	^15
]

{ #category : #'as yet unclassified' }
FogVMDup14 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup14 class >> goCode [
<doc>
	^ 'func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMDup14 class >> mnemonic [
<doc>
	^ 'DUP14'
]
