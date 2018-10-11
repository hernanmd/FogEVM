"
Place 11 byte item on stack
"
Class {
	#name : #FogVMPush11,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMPush11 class >> byteCode [ 
	^'0x6a'
]

{ #category : #'as yet unclassified' }
FogVMPush11 class >> description [ 
	^ 'Place 11 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush11 class >> gas [
		^ self gasTable at: #gasPush.

]

{ #category : #generated }
FogVMPush11 class >> goCode [
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
FogVMPush11 class >> mnemonic [
	^ 'PUSH11'
]

{ #category : #'as yet unclassified' }
FogVMPush11 >> initialize [ 
		super initialize.
		bytes := 11
]
