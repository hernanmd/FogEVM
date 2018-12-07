"
Duplicates the item 5 at the stack and push it
"
Class {
	#name : #FogVMDup5,
	#superclass : #FogVMDup,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMDup5 class >> byteCode [ 
<doc>
	^'0x84'
]

{ #category : #'as yet unclassified' }
FogVMDup5 class >> description [ 
<doc>
	^ 'Duplicates the item 5 at the stack and push it'
]

{ #category : #'as yet unclassified' }
FogVMDup5 class >> expectedPops [ 
<doc>
	^5
]

{ #category : #'as yet unclassified' }
FogVMDup5 class >> expectedPushes [ 
<doc>
	^6
]

{ #category : #'as yet unclassified' }
FogVMDup5 class >> gas [
<doc>
		^ self gasTable at: #gasDup.
]

{ #category : #generated }
FogVMDup5 class >> goCode [
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
FogVMDup5 class >> mnemonic [
<doc>
	^ 'DUP5'
]
