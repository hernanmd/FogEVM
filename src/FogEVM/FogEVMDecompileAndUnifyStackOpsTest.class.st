Class {
	#name : #FogEVMDecompileAndUnifyStackOpsTest,
	#superclass : #FogEVMDecompileAndUnifyTest,
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #assertion }
FogEVMDecompileAndUnifyStackOpsTest >> assert: sequence dups: anInteger [ 
		self assert: sequence statements size equals: anInteger.
	self assert: sequence allInstructions size equals: anInteger + 2.
	self assert: decompiler stack size equals: anInteger + 1.
	self assert: decompiler scope stack pop equals: (decompiler scope stack at: anInteger)
]

{ #category : #generated }
FogEVMDecompileAndUnifyStackOpsTest >> assert: sequence swaps: anInt [
	self assert: sequence statements size equals: 1 + anInt.
	self assert: sequence allInstructions size equals: 3 + anInt.
	self assert: sequence statements first variable equals: decompiler scope stack first .
	self assert: sequence statements last variable equals: decompiler scope stack last
]

{ #category : #generated }
FogEVMDecompileAndUnifyStackOpsTest >> testDUP1 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP10 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP11 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP12 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP13 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP14 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP15 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP16 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP2 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP3 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP4 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP5 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP6 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP7 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP8 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testDUP9 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP1 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP10 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP11 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP12 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP13 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP14 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP15 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP16 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP2 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP3 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP4 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP5 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP6 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP7 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP8 [
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
FogEVMDecompileAndUnifyStackOpsTest >> testSWAP9 [
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
