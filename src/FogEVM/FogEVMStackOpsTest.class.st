Class {
	#name : #FogEVMStackOpsTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMStackOpsTest >> testDUP1 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP10 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP10.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 10
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP11 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP11.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 11
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP12 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP12.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 12
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP13 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP13.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 13
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP14 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP14.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 14
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP15 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP15.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 15
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP16 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP16.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 16
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP2 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP2.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 2
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP3 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP3.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 3
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP4 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP4.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 4
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP5 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP5.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 5
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP6 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP6.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 6
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP7 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP7.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 7
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP8 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP8.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop unsignedValue equals: 8
]

{ #category : #test }
FogEVMStackOpsTest >> testDUP9 [
	| bytecode |
	"should test over 
		func makeDup(size int64) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.dup(interpreter.intPool, int(size))
		return nil, nil
	}
}

// ma"
	bytecode := self createBytecodeForDUP9.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 9
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP1 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 2
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP10 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP10.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 11
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP11 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP11.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 12
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP12 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP12.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 13
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP13 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP13.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 14
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP14 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP14.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 15
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP15 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP15.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 16
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP16 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP16.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 17
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP2 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP2.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 3
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP3 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP3.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 4
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP4 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP4.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 5
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP5 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP5.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 6
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP6 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP6.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 7
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP7 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP7.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 8
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP8 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP8.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 9
]

{ #category : #test }
FogEVMStackOpsTest >> testSWAP9 [
	| bytecode |
	"should test over 
		func makeSwap(size int64) executionFunc {
	// switch n + 1 otherwise n would be swapped with n
	size++
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		stack.swap(int(size))
		"
	bytecode := self createBytecodeForSWAP9.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 10
]
