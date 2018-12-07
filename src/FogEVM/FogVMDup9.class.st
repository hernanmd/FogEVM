"
Duplicates the item 9 at the stack and push it
"
Class {
	#name : #FogVMDup9,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup9 class >> byteCode [ 
<doc>
	^'0x88'
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> description [ 
<doc>
	^ 'Duplicates the item 9 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> expectedPops [ 
<doc>
	^9
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> expectedPushes [ 
<doc>
	^10
]

{ #category : #'as yet unclassified' }
FogVMDup9 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup9 class >> goCode [
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
FogVMDup9 class >> mnemonic [
<doc>
	^ 'DUP9'
]
