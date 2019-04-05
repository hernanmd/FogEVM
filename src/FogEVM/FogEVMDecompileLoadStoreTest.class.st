Class {
	#name : #FogEVMDecompileLoadStoreTest,
	#superclass : #FogEVMUnitaryTest,
	#traits : 'DecompilerAssertions',
	#classTraits : 'DecompilerAssertions classTrait',
	#instVars : [
		'generator',
		'value',
		'memoryStart'
	],
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #test }
FogEVMDecompileLoadStoreTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> generator: aGenerator [
	| hex |
	hex := Hexadecimal new.
	value := hex write0xHexadecimal: 128 + (aGenerator nextInt: 256 * 31).
	memoryStart := hex write0xHexadecimal: 1 + (aGenerator nextInt: 10).
	generator := aGenerator
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testMLOAD [
	| sequence |
	"MLOAD(Address)->
	   sequence + 
	    address := Address.
	    value := MemoryLoad(address, WordSize)
	   stack +
	    value
	"
	sequence := self decompile: (self createBytecodeForMLOAD: memoryStart).
	self assert: sequence statements size equals: 2.
	self assert: sequence instructions size equals: 3.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assert: (sequence statements last value isKindOf: FogEVMAstMemoryLoad).
	self assert: sequence statements first variable equals: sequence statements last value fromAddress.
	self assert: sequence statements last value amountOfBytes read equals: FogEVMAbstractInterpreter wordSize.
	self assert: decompiler scope stack size equals: 1.
	self assert: decompiler scope stack pop equals: sequence statements last variable
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testMSIZE [
	| sequence |
	"MSIZE->
	  sequence + 
	   runtime := Runtime
	   size := runtime memorySize. 
	  stack +
	   size
	"
	sequence := self decompile: self createBytecodeForMSIZE.
	self assert: sequence statements size equals: 2.
	self assert: sequence instructions size equals: 2.
	self assertIsAssignment: sequence statements first.
	self assertIsMessageSend: sequence statements last value.
	self assert: sequence statements last value receiver equals: sequence statements first variable.
	self assertIsRuntimeGlobal: sequence statements first value . 
	self assert: sequence statements last variable equals: decompiler scope stack pop.

]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testMSTORE [
	| sequence |
	"MSTORE(Value, Address)->
	  sequence + 
	   value := Value.
	   address := Address.
	   MemoryStore(value, address, WordSize).
	  stack + 
	"
	sequence := self decompile: (self createBytecodeForMSTORE: value at: memoryStart).
	self assert: sequence statements size equals: 3.
	self assert: sequence instructions size equals: 4.
	self assert: decompiler scope stack isEmpty.
	self assert: (sequence statements last isKindOf: FogEVMAstMemoryStore).
	self assert: sequence statements last address equals: sequence statements second variable.
	self assert: sequence statements last value equals: sequence statements first variable.
	self assert: sequence statements last amount read equals: FogEVMAbstractInterpreter wordSize
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testMSTORE8 [
	| sequence |
	"MSTORE(Value, Address)->
	  sequence + 
	   value := Value.
	   address := Address.
	   MemoryStore(value, address, ByteSize).
	  stack + 
	"
	sequence := self decompile: (self createBytecodeForMSTORE8: value at: memoryStart).
	self assert: sequence statements size equals: 3.
	self assert: sequence instructions size equals: 4.
	self assert: decompiler scope stack isEmpty.
	self assert: (sequence statements last isKindOf: FogEVMAstMemoryStore).
	self assert: sequence statements last address equals: sequence statements second variable.
	self assert: sequence statements last value equals: sequence statements first variable.
	self assert: sequence statements last amount read equals: FogEVMAbstractInterpreter byteSize
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testSHA3 [
	| sequence |
	"
	SHA3(Address, Size) ->
	 sequence +
	  address := Address.
	  size := Size.
	  value := MemoryLoad(address, size).
	  runtime := Runtime.
	  sha := runtime sha3: value. 
	 stack +
	  sha
	"
	sequence := self decompile: (self createBytecodeForSHA3: memoryStart to: '0x20').
	self assert: sequence statements size equals: 5.
	self assert: sequence instructions size equals: 4.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assertIsRuntimeGlobal: sequence statements fourth value.
	self assert: sequence statements second variable equals: sequence statements third value fromAddress.
	self assert: sequence statements first variable equals: sequence statements third value amountOfBytes.
	self assertIsBinaryOperation: sequence statements last value selector: #sha3:.
	self assert: decompiler scope stack size equals: 1.
	self assert: decompiler scope stack pop equals: sequence statements last variable
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testSLOAD [
	| sequence |
	"SLOAD(Address)->
	   sequence + 
	    address := Address.
	    value := StorageLoad(address, WordSize)
	   stack +
	    value
	"
	sequence := self decompile: (self createBytecodeForSLOAD: memoryStart).
	self assert: sequence statements size equals: 2.
	self assert: sequence instructions size equals: 3.
	sequence statements do: [ :s | self assertIsAssignment: s ].
	self assert: (sequence statements last value isKindOf: FogEVMAstStorageLoad).
	self assert: sequence statements first variable equals: sequence statements last value address.
	self assert: sequence statements last value amount read equals: FogEVMAbstractInterpreter wordSize.
	self assert: decompiler scope stack size equals: 1.
	self assert: decompiler scope stack pop equals: sequence statements last variable
]

{ #category : #test }
FogEVMDecompileLoadStoreTest >> testSSTORE [
	| sequence |
	"SSTORE(Value, Address)->
	  sequence + 
	   value := Value.
	   address := Address.
	   MemoryStore(value, address).
	  stack + 
	"
	sequence := self decompile: (self createBytecodeForSSTORE: value at: memoryStart).
	self assert: sequence statements size equals: 3.
	self assert: sequence instructions size equals: 4.
	self assert: decompiler scope stack isEmpty.
	self assert: (sequence statements last isKindOf: FogEVMAstStorageStore).
	self assert: sequence statements last address equals: sequence statements second variable.
	self assert: sequence statements last value equals: sequence statements first variable
]
