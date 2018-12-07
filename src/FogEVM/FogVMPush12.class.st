"
Place 12 byte item on stack
"
Class {
	#name : #FogVMPush12,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMPush12 class >> byteCode [ 
<doc>
	^'0x6b'
]

{ #category : #'as yet unclassified' }
FogVMPush12 class >> description [ 
<doc>
	^ 'Place 12 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush12 class >> gas [
<doc>
		^ self gasTable at: #gasPush.
]

{ #category : #generated }
FogVMPush12 class >> goCode [
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
FogVMPush12 class >> mnemonic [
<doc>
	^ 'PUSH12'
]

{ #category : #'as yet unclassified' }
FogVMPush12 >> initialize [ 
		super initialize.
		bytes := 12
]
