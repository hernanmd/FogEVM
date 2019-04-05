Class {
	#name : #FogEVMDecompileTransactionLogTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #test }
FogEVMDecompileTransactionLogTest >> testLOG0 [
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
	self assert: sequence statements size equals: 4 + 0.
	self assert: sequence instructions size equals: 4 + 0.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assert: (sequence statements third value isKindOf: FogEVMAstMemoryLoad).
	self assert: sequence statements second variable equals: sequence statements third value fromAddress.
	self assert: sequence statements first variable equals: sequence statements third value amountOfBytes.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence statements last value topics size equals: 0.
	self assert: sequence statements last value message equals: sequence statements third variable.
	





]

{ #category : #'test - LOG' }
FogEVMDecompileTransactionLogTest >> testLOG1 [
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
	self assert: sequence statements size equals: 4 + 1.
	self assert: sequence instructions size equals: 4 + 1.
	sequence statements do: [ :s | self assertIsAssignment: s ].

	self assert: (sequence statements nextToLast value isKindOf: FogEVMAstMemoryLoad).
	self assert: (sequence statements at: 2 + 1) variable equals: sequence statements nextToLast value fromAddress.
	self assert: (sequence statements at: 1 + 1) variable equals: sequence statements nextToLast value amountOfBytes.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence statements last value topics size equals: 1.
	self assert: sequence statements last value message equals: sequence statements nextToLast variable.
	

]

{ #category : #'test - LOG' }
FogEVMDecompileTransactionLogTest >> testLOG2 [
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
	self assert: sequence statements size equals: 4 + 2.
	self assert: sequence instructions size equals: 4 + 2.
	sequence statements do: [ :s | self assertIsAssignment: s ].

	self assert: (sequence statements nextToLast value isKindOf: FogEVMAstMemoryLoad).
	self assert: (sequence statements at: 2 + 2) variable equals: sequence statements nextToLast value fromAddress.
	self assert: (sequence statements at: 1 + 2) variable equals: sequence statements nextToLast value amountOfBytes.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence statements last value topics size equals: 2.
	self assert: sequence statements last value message equals: sequence statements nextToLast variable.
	

]

{ #category : #'test - LOG' }
FogEVMDecompileTransactionLogTest >> testLOG3 [
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
	self assert: sequence statements size equals: 4 + 3.
	self assert: sequence instructions size equals: 4 + 3.
	sequence statements do: [ :s | self assertIsAssignment: s ].

	self assert: (sequence statements nextToLast value isKindOf: FogEVMAstMemoryLoad).
	self assert: (sequence statements at: 2 + 3) variable equals: sequence statements nextToLast value fromAddress.
	self assert: (sequence statements at: 1 + 3) variable equals: sequence statements nextToLast value amountOfBytes.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence statements last value topics size equals: 3.
	self assert: sequence statements last value message equals: sequence statements nextToLast variable.
	

]

{ #category : #'test - LOG' }
FogEVMDecompileTransactionLogTest >> testLOG4 [
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
	self assert: sequence statements size equals: 4 + 4.
	self assert: sequence instructions size equals: 4 + 4.
	sequence statements do: [ :s | self assertIsAssignment: s ].

	self assert: (sequence statements nextToLast value isKindOf: FogEVMAstMemoryLoad).
	self assert: (sequence statements at: 2 + 4) variable equals: sequence statements nextToLast value fromAddress.
	self assert: (sequence statements at: 1 + 4) variable equals: sequence statements nextToLast value amountOfBytes.
	self assert: (sequence statements last value isKindOf: FogEVMAstLog).
	self assert: sequence statements last value topics size equals: 4.
	self assert: sequence statements last value message equals: sequence statements nextToLast variable.
	

]
