Class {
	#name : #FogEVMDecompileStackOpsTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #assertion }
FogEVMDecompileStackOpsTest >> assert: sequence dups: anInteger [ 
		self assert: sequence statements size equals: anInteger.
	self assert: sequence allInstructions size equals: anInteger + 2.
	self assert: decompiler stack size equals: anInteger + 1.
	self assert: decompiler scope stack pop equals: (decompiler scope stack at: anInteger)
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> assert: sequence swaps: anInt [
	self assert: sequence statements size equals: 1 + anInt.
	self assert: sequence allInstructions size equals: 3 + anInt.
	self assert: sequence statements first variable equals: decompiler scope stack first .
	self assert: sequence statements last variable equals: decompiler scope stack last
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
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP10.
	self assert: sequence dups:10.

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP11 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP11.
	self assert: sequence dups:11.


]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP12 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP12.
	self assert: sequence dups:12.

	
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP13 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP13.
	self assert: sequence dups: 13
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP14 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP14.
	self assert: sequence dups:14.


]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP15 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP15.
	self assert: sequence dups:15.

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP16 [
		| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP16.
	self assert: sequence dups:16.

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP2 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP2.
	self assert: sequence dups: 2
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP3 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP3.
	self assert: sequence dups: 3
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP4 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP4.
	self assert: sequence dups:4.

			

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP5 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP5.
	self assert: sequence dups: 5
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP6 [
		| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP6.
	self assert: sequence dups:6.

]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP7 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP7.
	self assert: sequence dups: 7
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP8 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP8.
	self assert: sequence dups: 8
]

{ #category : #generated }
FogEVMDecompileStackOpsTest >> testDUP9 [
	| sequence |
	"
	DUP1(V)
	 sequence +
	 stack +
	  V
	
	"
	sequence := self decompile: self createBytecodeForDUP9.
	self assert: sequence dups: 9
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP1 [
	| sequence |
	"
	SWAP11
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[1] 
	"
	sequence := self decompile: self createBytecodeForSWAP1.
	self assert: sequence swaps: 1.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP10 [
	| sequence |
	"
	SWAP110
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[10] 
	"
	sequence := self decompile: self createBytecodeForSWAP10.
	self assert: sequence swaps: 10.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP11 [
	| sequence |
	"
	SWAP111
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[11] 
	"
	sequence := self decompile: self createBytecodeForSWAP11.
	self assert: sequence swaps: 11.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP12 [
	| sequence |
	"
	SWAP112
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[12] 
	"
	sequence := self decompile: self createBytecodeForSWAP12.
	self assert: sequence swaps: 12.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP13 [
	| sequence |
	"
	SWAP113
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[13] 
	"
	sequence := self decompile: self createBytecodeForSWAP13.
	self assert: sequence swaps: 13.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP14 [
	| sequence |
	"
	SWAP114
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[14] 
	"
	sequence := self decompile: self createBytecodeForSWAP14.
	self assert: sequence swaps: 14.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP15 [
	| sequence |
	"
	SWAP115
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[15] 
	"
	sequence := self decompile: self createBytecodeForSWAP15.
	self assert: sequence swaps: 15.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP16 [
	| sequence |
	"
	SWAP116
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[16] 
	"
	sequence := self decompile: self createBytecodeForSWAP16.
	self assert: sequence swaps: 16.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP2 [
	| sequence |
	"
	SWAP12
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[2] 
	"
	sequence := self decompile: self createBytecodeForSWAP2.
	self assert: sequence swaps: 2.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP3 [
	| sequence |
	"
	SWAP13
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[3] 
	"
	sequence := self decompile: self createBytecodeForSWAP3.
	self assert: sequence swaps: 3.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP4 [
	| sequence |
	"
	SWAP14
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[4] 
	"
	sequence := self decompile: self createBytecodeForSWAP4.
	self assert: sequence swaps: 4.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP5 [
	| sequence |
	"
	SWAP15
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[5] 
	"
	sequence := self decompile: self createBytecodeForSWAP5.
	self assert: sequence swaps: 5.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP6 [
	| sequence |
	"
	SWAP16
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[6] 
	"
	sequence := self decompile: self createBytecodeForSWAP6.
	self assert: sequence swaps: 6.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP7 [
	| sequence |
	"
	SWAP17
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[7] 
	"
	sequence := self decompile: self createBytecodeForSWAP7.
	self assert: sequence swaps: 7.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP8 [
	| sequence |
	"
	SWAP18
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[8] 
	"
	sequence := self decompile: self createBytecodeForSWAP8.
	self assert: sequence swaps: 8.
]

{ #category : #'test swap' }
FogEVMDecompileStackOpsTest >> testSWAP9 [
	| sequence |
	"
	SWAP19
	 sequence +
	 stack +
	dstack
	  v[1] <=> v[9] 
	"
	sequence := self decompile: self createBytecodeForSWAP9.
	self assert: sequence swaps: 9.
]
