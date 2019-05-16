Class {
	#name : #FogEVMDecompileAndUnifyLoadStoreTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#instVars : [
		'generator',
		'value',
		'memoryStart'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> generator: aGenerator [
	| hex |
	hex := Hexadecimal new.
	value := hex write0xHexadecimal: 128 + (aGenerator nextInt: 256 * 31).
	memoryStart := hex write0xHexadecimal: 1 + (aGenerator nextInt: 10).
	generator := aGenerator
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testMLOAD [
	| sequence |
	"MLOAD(Address)->
	   sequence + 
	    value := MemoryLoad(Address, WordSize)
	   stack +
	    value
	"
	sequence := self
		decompile: (self createBytecodeForMLOAD: memoryStart).
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assert: (sequence statements last value isKindOf: FogEVMAstMemoryLoad).
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testMSIZE [
	| sequence |
	"MSIZE->
	  sequence + 
	   size := runtime memorySize. 
	  stack +
	   size
	"
	sequence := self decompile: self createBytecodeForMSIZE.
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testMSTORE [
	| sequence |
	"MSTORE(Value, Address)->
	  sequence + 
	   MemoryStore(Value, Address, WordSize).
	  stack + 
	"
	sequence := self
		decompile: (self createBytecodeForMSTORE: value at: memoryStart).
	self assert: sequence statements size equals: 1.
	self assertIsMemoryWrite: sequence statements first.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testMSTORE8 [
	| sequence |
	"MSTORE(Value, Address)->
	  sequence + 
	   MemoryStore(value, address, ByteSize).
	  stack + 
	"
	sequence := self
		decompile: (self createBytecodeForMSTORE8: value at: memoryStart).
	self assert: sequence statements size equals: 1.
	self assertIsMemoryWrite: sequence statements first.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testSHA3 [
	| sequence |
	"
	SHA3(Address, Size) ->
	 sequence +
	  sha := runtime sha3: ( MemoryLoad(address, size)). 
	 stack +
	  sha
	"
	sequence := self
		decompile: (self createBytecodeForSHA3: memoryStart to: '0x20').
	self assert: sequence statements size equals: 1.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testSLOAD [
	| sequence |
	"SLOAD(Address)->
	   sequence + 
	    value := StorageLoad(address, WordSize)
	   stack +
	    value
	"
	sequence := self
		decompile: (self createBytecodeForSLOAD: memoryStart).
	self assert: sequence statements size equals: 1.
	self
		assert: (sequence statements first value isKindOf: FogEVMAstStorageLoad).
	self assert: sequence allInstructions equals: bytecode instructions
]

{ #category : #test }
FogEVMDecompileAndUnifyLoadStoreTest >> testSSTORE [
	| sequence |
	"SSTORE(Value, Address)->
	  sequence + 
	   MemoryStore(value, address).
	  stack + 
	"
	sequence := self
		decompile: (self createBytecodeForSSTORE: value at: memoryStart).
	self assert: sequence statements size equals: 1.
	self
		assert: (sequence statements first  isKindOf: FogEVMAstStorageStore).
	self assert: sequence allInstructions equals: bytecode instructions
]
