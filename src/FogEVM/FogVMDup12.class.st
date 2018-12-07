"
Duplicates the item 12 at the stack and push it
"
Class {
	#name : #FogVMDup12,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup12 class >> byteCode [ 
<doc>
	^'0x8b'
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> description [ 
<doc>
	^ 'Duplicates the item 12 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> expectedPops [ 
<doc>
	^12
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> expectedPushes [ 
<doc>
	^13
]

{ #category : #'as yet unclassified' }
FogVMDup12 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup12 class >> goCode [
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
FogVMDup12 class >> mnemonic [
<doc>
	^ 'DUP12'
]
