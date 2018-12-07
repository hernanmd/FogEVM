"
Duplicates the item 10 at the stack and push it
"
Class {
	#name : #FogVMDup10,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup10 class >> byteCode [ 
<doc>
	^'0x89'
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> description [ 
<doc>
	^ 'Duplicates the item 10 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> expectedPops [ 
<doc>
	^10
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> expectedPushes [ 
<doc>
	^11
]

{ #category : #'as yet unclassified' }
FogVMDup10 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup10 class >> goCode [
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
FogVMDup10 class >> mnemonic [
<doc>
	^ 'DUP10'
]
