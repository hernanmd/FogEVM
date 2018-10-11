"
Place 1 byte item on stack
"
Class {
	#name : #FogVMPush1,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMPush1 class >> byteCode [ 
	^'0x60'
]

{ #category : #'as yet unclassified' }
FogVMPush1 class >> description [ 
	^ 'Place 1 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush1 class >> gas [
		^ self gasTable at: #gasPush.

]

{ #category : #generated }
FogVMPush1 class >> goCode [
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
FogVMPush1 class >> mnemonic [
	^ 'PUSH1'
]

{ #category : #'as yet unclassified' }
FogVMPush1 >> initialize [ 
		super initialize.
		bytes := 1
]
