"
Place 7 byte item on stack
"
Class {
	#name : #FogVMPush7,
	#superclass : #FogVMPush,
	#category : 'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMPush7 class >> byteCode [ 
	^'0x66'
]

{ #category : #'as yet unclassified' }
FogVMPush7 class >> description [ 
	^ 'Place 7 byte item on stack'
]

{ #category : #'as yet unclassified' }
FogVMPush7 class >> gas [
		^ self gasTable at: #gasPush.

]

{ #category : #generated }
FogVMPush7 class >> goCode [
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
FogVMPush7 class >> mnemonic [
	^ 'PUSH7'
]

{ #category : #'as yet unclassified' }
FogVMPush7 >> initialize [ 
		super initialize.
		bytes := 7
]
