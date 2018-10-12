Class {
	#name : #FogEVMLogicGateTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMLogicGateTest >> testAND [
	| bytecode |
	"should test over 
		func opAnd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	stack.push(x.And(x, y))

	interpreter.intPool.put(y)
	return ni"
	bytecode := self createBytecodeForAND: 1 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	bytecode := self createBytecodeForAND: 1 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0.
	bytecode := self createBytecodeForAND: 0 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0.
	bytecode := self createBytecodeForAND: 0 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0
]

{ #category : #test }
FogEVMLogicGateTest >> testNOT [
	| bytecode |
	"should test over 
		func opNot(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x := stack.peek()
	math.U256(x.Not(x))
	return ni"
	bytecode := self createBytecodeForNOT: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0.
	
	bytecode := self createBytecodeForNOT: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1
]

{ #category : #test }
FogEVMLogicGateTest >> testOR [
		|  bytecode  |
		
		"should test over 
		func opOr(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	y.Or(x, y)

	interpreter.intPool.put(x)
	return nil"
	bytecode := self createBytecodeForOR: 1 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	
	bytecode := self createBytecodeForOR: 1 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	
	bytecode := self createBytecodeForOR: 0 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	
	bytecode := self createBytecodeForOR: 0 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0
]

{ #category : #test }
FogEVMLogicGateTest >> testXOR [
		|  bytecode  |
		
		"should test over 
		func opXor(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	y.Xor(x, y)

	interpreter.intPool.put(x)
	return ni"
	bytecode := self createBytecodeForXOR: 1 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0.
	
	bytecode := self createBytecodeForXOR: 1 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	
	bytecode := self createBytecodeForXOR: 0 and: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	
	bytecode := self createBytecodeForXOR: 0 and: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0
]
