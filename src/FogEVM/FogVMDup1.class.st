"
Duplicates the item 1 at the stack and push it
"
Class {
	#name : #FogVMDup1,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup1 class >> byteCode [ 
<doc>
	^'0x80'
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> description [ 
<doc>
	^ 'Duplicates the item 1 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> expectedPops [ 
<doc>
	^1
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> expectedPushes [ 
<doc>
	^2
]

{ #category : #'as yet unclassified' }
FogVMDup1 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup1 class >> goCode [
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
FogVMDup1 class >> mnemonic [
<doc>
	^ 'DUP1'
]
