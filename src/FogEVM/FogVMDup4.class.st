"
Duplicates the item 4 at the stack and push it
"
Class {
	#name : #FogVMDup4,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup4 class >> byteCode [ 
<doc>
	^'0x83'
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> description [ 
<doc>
	^ 'Duplicates the item 4 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> expectedPops [ 
<doc>
	^4
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> expectedPushes [ 
<doc>
	^5
]

{ #category : #'as yet unclassified' }
FogVMDup4 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup4 class >> goCode [
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
FogVMDup4 class >> mnemonic [
<doc>
	^ 'DUP4'
]
