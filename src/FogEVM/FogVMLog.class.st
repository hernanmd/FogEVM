"
Putting logs together
"
Class {
	#name : #FogVMLog,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #number }
FogVMLog class >> byteCode [
	^ nil
]

{ #category : #'as yet unclassified' }
FogVMLog class >> fetchGoCode [
	| stream lowcaseStream selector bytes goCode |
	stream := 'instructions.go' asFileReference readStream.
	lowcaseStream := stream contents asLowercase readStream.
	selector := 'func makeLog' asLowercase.
	lowcaseStream upToAll: selector.
	stream position: lowcaseStream position - selector size.
	bytes := (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size.
	goCode := stream next: bytes.
	self class
		compile:
			('goCode
	^ ''{1}''' format: {goCode})
		classified: #generated
]

{ #category : #generated }
FogVMLog class >> goCode [
<doc>
	^ 'func makeLog(size int) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		topics := make([]common.Hash, size)
		mStart, mSize := stack.pop(), stack.pop()
		for i := 0; i < size; i++ {
			topics[i] = common.BigToHash(stack.pop())
		}

		d := memory.Get(mStart.Int64(), mSize.Int64())
		interpreter.evm.StateDB.AddLog(&types.Log{
			Address: contract.Address(),
			Topics:  topics,
			Data:    d,
			// This is a non-consensus field, but assigned here because
			// core/state doesnt know the current block number.
			BlockNumber: interpreter.evm.BlockNumber.Uint64(),
		})

		interpreter.intPool.put(mStart, mSize)
		return nil, nil
	}
}

// ma'
]

{ #category : #'as yet unclassified' }
FogVMLog >> logKind [
	^ self binaryBytecode - FogVMLog0 instance binaryBytecode
]
