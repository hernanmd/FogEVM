"
Duplicates the item 6 at the stack and push it
"
Class {
	#name : #FogVMDup6,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup6 class >> byteCode [ 
<doc>
	^'0x85'
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> description [ 
<doc>
	^ 'Duplicates the item 6 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> expectedPops [ 
<doc>
	^6
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> expectedPushes [ 
<doc>
	^7
]

{ #category : #'as yet unclassified' }
FogVMDup6 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup6 class >> goCode [
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
FogVMDup6 class >> mnemonic [
<doc>
	^ 'DUP6'
]
