"
Duplicates the item 8 at the stack and push it
"
Class {
	#name : #FogVMDup8,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup8 class >> byteCode [ 
<doc>
	^'0x87'
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> description [ 
<doc>
	^ 'Duplicates the item 8 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> expectedPops [ 
<doc>
	^8
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> expectedPushes [ 
<doc>
	^9
]

{ #category : #'as yet unclassified' }
FogVMDup8 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup8 class >> goCode [
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
FogVMDup8 class >> mnemonic [
<doc>
	^ 'DUP8'
]
