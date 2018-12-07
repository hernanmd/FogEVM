"
Place 19 byte item on stack
"
Class {
	#name : #FogVMPush19,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMPush19 class >> byteCode [ 
<doc>
	^'0x72'
]

{ #category : #'as yet unclassified' }
FogVMPush19 class >> description [ 
<doc>
	^ 'Place 19 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush19 class >> gas [
<doc>
		^ self gasTable at: #gasPush.
]

{ #category : #generated }
FogVMPush19 class >> goCode [
<doc>
	^ 'func makePush(size uint64, pushByteSize int) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		codeLen := len(contract.Code)

		startMin := codeLen
		if int(*pc+1) < startMin {
			startMin = int(*pc + 1)
		}

		endMin := codeLen
		if startMin+pushByteSize < endMin {
			endMin = startMin + pushByteSize
		}

		integer := interpreter.intPool.get()
		stack.push(integer.SetBytes(common.RightPadBytes(contract.Code[startMin:endMin], pushByteSize)))

		*pc += size
		return nil, nil
	}
}

// '
]

{ #category : #'as yet unclassified' }
FogVMPush19 class >> mnemonic [
<doc>
	^ 'PUSH19'
]

{ #category : #'as yet unclassified' }
FogVMPush19 >> initialize [ 
		super initialize.
		bytes := 19
]
