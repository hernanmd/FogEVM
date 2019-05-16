Class {
	#name : #FogEVMDecompileAndUnifyTest,
	#superclass : #FogEVMUnitaryTest,
	#instVars : [
		'bytecode'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #'bytecode generation' }
FogEVMDecompileAndUnifyTest >> decompile: aSequence [
	| unifier decompiled |
	bytecode := aSequence.
	unifier := FogEVMAstVariableReadWriteDetector new.
	decompiled := super decompile: aSequence.
	unifier unify: decompiled.
	^ decompiled 
]
