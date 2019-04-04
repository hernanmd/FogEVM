Class {
	#name : #FogEVMDecompileStackOpsTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #assertion }
FogEVMDecompileStackOpsTest >> assert: sequence dups: anInteger [ 
		self assert: sequence statements size equals: anInteger.
	self assert: sequence instructions size equals: anInteger + 2.
	self assert: decompiler stack size equals: anInteger + 1.
	self assert: decompiler scope stack pop equals: (decompiler scope stack at: anInteger)
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP1 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP1.
	self assert: sequence dups:1.

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP10 [
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
	self assert: interpreter stack pop unsignedValue equals: 10
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP11 [
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
	self assert: interpreter stack pop unsignedValue equals: 11
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP12 [
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
	self assert: interpreter stack pop unsignedValue equals: 12
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP13 [
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
	self assert: interpreter stack pop unsignedValue equals: 13
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP14 [
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
	self assert: interpreter stack pop unsignedValue equals: 14
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP15 [
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
	self assert: interpreter stack pop unsignedValue equals: 15
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP16 [
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
	self assert: interpreter stack pop unsignedValue equals: 16
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP2 [
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
	self assert: interpreter stack pop unsignedValue equals: 2
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP3 [
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
	self assert: interpreter stack pop unsignedValue equals: 3
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP4 [
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
	self assert: interpreter stack pop unsignedValue equals: 4
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP5 [
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
	self assert: interpreter stack pop unsignedValue equals: 5
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP6 [
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
	self assert: interpreter stack pop unsignedValue equals: 6
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP7 [
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
	self assert: interpreter stack pop unsignedValue equals: 7
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP8 [
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

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP9 [
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
	self assert: interpreter stack pop unsignedValue equals: 9
			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP1 [
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
	self assert: interpreter stack pop unsignedValue equals: 2

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP10 [
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
	self assert: interpreter stack pop unsignedValue equals: 11

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP11 [
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
	self assert: interpreter stack pop unsignedValue equals: 12

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP12 [
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
	self assert: interpreter stack pop unsignedValue equals: 13

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP13 [
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
	self assert: interpreter stack pop unsignedValue equals: 14

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP14 [
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
	self assert: interpreter stack pop unsignedValue equals: 15

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP15 [
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
	self assert: interpreter stack pop unsignedValue equals: 16

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP16 [
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
	self assert: interpreter stack pop unsignedValue equals: 17

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP2 [
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
	self assert: interpreter stack pop unsignedValue equals: 3

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP3 [
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
	self assert: interpreter stack pop unsignedValue equals: 4

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP4 [
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
	self assert: interpreter stack pop unsignedValue equals: 5

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP5 [
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
	self assert: interpreter stack pop unsignedValue equals: 6

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP6 [
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
	self assert: interpreter stack pop unsignedValue equals: 7

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP7 [
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
	self assert: interpreter stack pop unsignedValue equals: 8

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP8 [
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
	self assert: interpreter stack pop unsignedValue equals: 9

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testSWAP9 [
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
	self assert: interpreter stack pop unsignedValue equals: 10

]
