Class {
	#name : #FogEVMDecompileAndUnifyTransactionLogTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #test }
FogEVMDecompileAndUnifyTransactionLogTest >> testLOG0 [
	| sequence |
	"
	LOG0(MessageAddress, MessageSize, Topic [0..{i}]) ->
	  sequence +
	    msgAddress := MessageAddress.
	    msgSize := MessageSize.
	    msg := MemoryLoad(msgAddress, msgSize);
	    topic0 := Topic[0].
	    ...
		 topic{i} := Topic[{i}].
		 log := Log(msg, topic0 .. topic{i}).
	  stack + 
   "
	sequence := self decompile: (self createBytecodeForLOG: 0 memory: '0x1' size: '0x10').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence allInstructions equals: bytecode instructions.



]

{ #category : #'test - LOG' }
FogEVMDecompileAndUnifyTransactionLogTest >> testLOG1 [
| sequence |
	"
	LOG1(MessageAddress, MessageSize, Topic [0..1]) ->
	  sequence +
	    msgAddress := MessageAddress.
	    msgSize := MessageSize.
	    msg := MemoryLoad(msgAddress, msgSize);
	    topic0 := Topic[0].
	    ...
		 topic1 := Topic[1].
		 log := Log(msg, topic0 .. topic1).
	  stack + 
   "
	sequence := self decompile: (self createBytecodeForDecompileLOG: 1 memory: 1 write0xHexadecimal size: 10 write0xHexadecimal).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence allInstructions equals: bytecode instructions.

]

{ #category : #'test - LOG' }
FogEVMDecompileAndUnifyTransactionLogTest >> testLOG2 [
| sequence |
	"
	LOG2(MessageAddress, MessageSize, Topic [0..2]) ->
	  sequence +
	    msgAddress := MessageAddress.
	    msgSize := MessageSize.
	    msg := MemoryLoad(msgAddress, msgSize);
	    topic0 := Topic[0].
	    ...
		 topic2 := Topic[2].
		 log := Log(msg, topic0 .. topic2).
	  stack + 
   "
	sequence := self decompile: (self createBytecodeForDecompileLOG: 2 memory: 1 write0xHexadecimal size: 10 write0xHexadecimal).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence allInstructions equals: bytecode instructions.

]

{ #category : #'test - LOG' }
FogEVMDecompileAndUnifyTransactionLogTest >> testLOG3 [
| sequence |
	"
	LOG3(MessageAddress, MessageSize, Topic [0..3]) ->
	  sequence +
	    msgAddress := MessageAddress.
	    msgSize := MessageSize.
	    msg := MemoryLoad(msgAddress, msgSize);
	    topic0 := Topic[0].
	    ...
		 topic3 := Topic[3].
		 log := Log(msg, topic0 .. topic3).
	  stack + 
   "
	sequence := self decompile: (self createBytecodeForDecompileLOG: 3 memory: 1 write0xHexadecimal size: 10 write0xHexadecimal).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence allInstructions equals: bytecode instructions.

]

{ #category : #'test - LOG' }
FogEVMDecompileAndUnifyTransactionLogTest >> testLOG4 [
| sequence |
	"
	LOG4(MessageAddress, MessageSize, Topic [0..4]) ->
	  sequence +
	    msgAddress := MessageAddress.
	    msgSize := MessageSize.
	    msg := MemoryLoad(msgAddress, msgSize);
	    topic0 := Topic[0].
	    ...
		 topic4 := Topic[4].
		 log := Log(msg, topic0 .. topic4).
	  stack + 
   "
	sequence := self decompile: (self createBytecodeForDecompileLOG: 4 memory: 1 write0xHexadecimal size: 10 write0xHexadecimal).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence allInstructions equals: bytecode instructions.

]
