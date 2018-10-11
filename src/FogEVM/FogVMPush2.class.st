"
Place 2 byte item on stack
"
Class {
	#name : #FogVMPush2,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMPush2 class >> byteCode [ 
	^'0x61'
]

{ #category : #'as yet unclassified' }
FogVMPush2 class >> description [ 
	^ 'Place 2 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush2 class >> gas [
		^ self gasTable at: #gasPush.

]

{ #category : #generated }
FogVMPush2 class >> goCode [
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
FogVMPush2 class >> mnemonic [
	^ 'PUSH2'
]

{ #category : #'as yet unclassified' }
FogVMPush2 >> initialize [ 
		super initialize.
		bytes := 2
]
