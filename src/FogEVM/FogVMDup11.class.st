"
Duplicates the item 11 at the stack and push it
"
Class {
	#name : #FogVMDup11,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup11 class >> byteCode [ 
<doc>
	^'0x8a'
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> description [ 
<doc>
	^ 'Duplicates the item 11 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> expectedPops [ 
<doc>
	^11
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> expectedPushes [ 
<doc>
	^12
]

{ #category : #'as yet unclassified' }
FogVMDup11 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup11 class >> goCode [
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
FogVMDup11 class >> mnemonic [
<doc>
	^ 'DUP11'
]
