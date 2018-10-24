Class {
	#name : #FogEVMTransactionLogTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMTransactionLogTest >> testLOG0 [
	| bytecode |
	"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
	bytecode := self createBytecodeForLOG: 0 memory: 1 size: 10.
	interpreter bytecode: bytecode.
	interpreter memory store: 'hola mundo' asByteArray at: 1 ensure: 10.
	interpreter run.
	self assert: interpreter logs isNotEmpty.
	1 to: 0 do: [ :i | self assert: (interpreter logs first topics at: i) unsignedValue equals: i ].
	self assert: interpreter logs first content equals: 'hola mundo' asByteArray
]

{ #category : #test }
FogEVMTransactionLogTest >> testLOG1 [
	| bytecode |
	"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
	bytecode := self createBytecodeForLOG: 1 memory: 1 size: 10.
	interpreter bytecode: bytecode.
	interpreter memory store: 'hola mundo' asByteArray at: 1 ensure: 10.
	interpreter run.
	self assert: interpreter logs isNotEmpty.
	1 to: 1 do: [ :i | self assert: (interpreter logs first topics at: i) unsignedValue equals: i ].
	self assert: interpreter logs first content equals: 'hola mundo' asByteArray
]

{ #category : #test }
FogEVMTransactionLogTest >> testLOG2 [
	| bytecode |
	"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
	bytecode := self createBytecodeForLOG: 2 memory: 1 size: 10.
	interpreter bytecode: bytecode.
	interpreter memory store: 'hola mundo' asByteArray at: 1 ensure: 10.
	interpreter run.
	self assert: interpreter logs isNotEmpty.
	1 to: 2 do: [ :i | self assert: (interpreter logs first topics at: i) unsignedValue equals: i ].
	self assert: interpreter logs first content equals: 'hola mundo' asByteArray
]

{ #category : #test }
FogEVMTransactionLogTest >> testLOG3 [
	| bytecode |
	"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
	bytecode := self createBytecodeForLOG: 3 memory: 1 size: 10.
	interpreter bytecode: bytecode.
	interpreter memory store: 'hola mundo' asByteArray at: 1 ensure: 10.
	interpreter run.
	self assert: interpreter logs isNotEmpty.
	1 to: 3 do: [ :i | self assert: (interpreter logs first topics at: i) unsignedValue equals: i ].
	self assert: interpreter logs first content equals: 'hola mundo' asByteArray
]

{ #category : #test }
FogEVMTransactionLogTest >> testLOG4 [
	| bytecode |
	"should test over 
		func makeLog(size int) executionFunc {
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

// ma"
	bytecode := self createBytecodeForLOG: 4 memory: 1 size: 10.
	interpreter bytecode: bytecode.
	interpreter memory store: 'hola mundo' asByteArray at: 1 ensure: 10.
	interpreter run.
	self assert: interpreter logs isNotEmpty.
	1 to: 4 do: [ :i | self assert: (interpreter logs first topics at: i) unsignedValue equals: i ].
	self assert: interpreter logs first content equals: 'hola mundo' asByteArray
]
