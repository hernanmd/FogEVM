"
Duplicates the item 15 at the stack and push it
"
Class {
	#name : #FogVMDup15,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup15 class >> byteCode [ 
<doc>
	^'0x8e'
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> description [ 
<doc>
	^ 'Duplicates the item 15 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> expectedPops [ 
<doc>
	^15
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> expectedPushes [ 
<doc>
	^16
]

{ #category : #'as yet unclassified' }
FogVMDup15 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup15 class >> goCode [
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
FogVMDup15 class >> mnemonic [
<doc>
	^ 'DUP15'
]
