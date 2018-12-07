"
Append log record with four topics
"
Class {
	#name : #FogVMLog4,
	#superclass : #FogVMLog,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMLog4 class >> byteCode [
<doc>
		^'0xa4'.
	
]

{ #category : #'as yet unclassified' }
FogVMLog4 class >> description [ 
<doc>
	^ 'Append log record with four topics'
]

{ #category : #generated }
FogVMLog4 class >> expectedPops [
<doc>
		^6.
	
]

{ #category : #'as yet unclassified' }
FogVMLog4 class >> expectedPushes [
<doc>
	^ 0
]

{ #category : #'as yet unclassified' }
FogVMLog4 class >> gas [
<doc>
		^ self gasTable at: #makeGasLog.
]

{ #category : #generated }
FogVMLog4 class >> goCode [
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
FogVMLog4 class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryLog.
]

{ #category : #generated }
FogVMLog4 class >> mnemonic [
<doc>
		^'LOG4'.
	
]

{ #category : #'as yet unclassified' }
FogVMLog4 class >> writes [
<doc>
		^ true.
]
