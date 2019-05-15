Class {
	#name : #FogEVMBytecodeAndStackVisualizer,
	#superclass : #ComposablePresenter,
	#instVars : [
		'bytecode',
		'stack'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #specs }
FogEVMBytecodeAndStackVisualizer class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: #bytecode width: 250;
				newColumn: #stack width: 150 ]
]

{ #category : #accessing }
FogEVMBytecodeAndStackVisualizer >> bytecode [
	^ bytecode
]

{ #category : #initialization }
FogEVMBytecodeAndStackVisualizer >> initializeWidgets [
	bytecode := self instantiate: FogEVMBytecodeList.
	stack := self instantiate: FogEVMStackView
]

{ #category : #accessing }
FogEVMBytecodeAndStackVisualizer >> stack [
	^ stack
]
