"
Append log record with 3 topic
"
Class {
	#name : #FogVMLog3,
	#superclass : #FogVMLog,
	#category : #'FogEVM-ByteCode'
}

{ #category : #'as yet unclassified' }
FogVMLog3 class >> byteCode [
	^ '0xa3'
]

{ #category : #'as yet unclassified' }
FogVMLog3 class >> expectedPops [
	^ 5
]

{ #category : #'as yet unclassified' }
FogVMLog3 class >> expectedPushes [
	^ 0
]

{ #category : #'as yet unclassified' }
FogVMLog3 class >> gas [
		^ self gasTable at: #makeGasLog.

]

{ #category : #generated }
FogVMLog3 class >> goCode [
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
FogVMLog3 class >> memoryUsage [
		^ self memoryTable at: #memoryLog.

]

{ #category : #accessing }
FogVMLog3 class >> mnemonic [
	^ 'LOG3'
]

{ #category : #'as yet unclassified' }
FogVMLog3 class >> writes [
		^ true.

]
