"
Duplicates the item 3 at the stack and push it
"
Class {
	#name : #FogVMDup3,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup3 class >> byteCode [ 
<doc>
	^'0x82'
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> description [ 
<doc>
	^ 'Duplicates the item 3 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> expectedPops [ 
<doc>
	^3
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> expectedPushes [ 
<doc>
	^4
]

{ #category : #'as yet unclassified' }
FogVMDup3 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup3 class >> goCode [
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
FogVMDup3 class >> mnemonic [
<doc>
	^ 'DUP3'
]
