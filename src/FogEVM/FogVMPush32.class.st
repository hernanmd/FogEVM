"
Place 32 byte item on stack
"
Class {
	#name : #FogVMPush32,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMPush32 class >> byteCode [ 
<doc>
	^'0x7f'
]

{ #category : #'as yet unclassified' }
FogVMPush32 class >> description [ 
<doc>
	^ 'Place 32 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush32 class >> gas [
<doc>
		^ self gasTable at: #gasPush.
]

{ #category : #generated }
FogVMPush32 class >> goCode [
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

{ #category : #generated }
FogVMPush32 class >> mnemonic [
<doc>
	^ 'PUSH32'
]

{ #category : #'as yet unclassified' }
FogVMPush32 >> initialize [ 
		super initialize.
		bytes := 32
]
