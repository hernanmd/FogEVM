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
<doc>
	^'0x86'
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> description [ 
<doc>
	^ 'Duplicates the item 7 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> expectedPops [ 
<doc>
	^7
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> expectedPushes [ 
<doc>
	^8
]

{ #category : #'as yet unclassified' }
FogVMDup7 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup7 class >> goCode [
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
FogVMDup7 class >> mnemonic [
<doc>
	^ 'DUP7'
]
