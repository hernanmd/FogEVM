"
This component allow to see an object execution preview. 
"
Class {
	#name : #FogEVMBytecodeExecutionPreview,
	#superclass : #ComposablePresenter,
	#instVars : [
		'instruction',
		'args',
		'preview'
	],
	#category : #'FogEVM-UIDebugger-View'
}

{ #category : #specs }
FogEVMBytecodeExecutionPreview class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :row | 
			row
				newColumn: #instruction width: 100;
				newColumn: #args ]
			height: 30;
		yourself
]

{ #category : #initialization }
FogEVMBytecodeExecutionPreview >> args [
	^ args
]

{ #category : #initialization }
FogEVMBytecodeExecutionPreview >> initializeWidgets [
	args := self newLabel.
	instruction := self newLabel.

]

{ #category : #initialization }
FogEVMBytecodeExecutionPreview >> instruction [
	^ instruction
]

{ #category : #initialization }
FogEVMBytecodeExecutionPreview >> preview [
	^ preview
]

{ #category : #initialization }
FogEVMBytecodeExecutionPreview >> preview: aPreview [
	preview := aPreview.
	preview
		ifNil: [ instruction label: ' '.
			args label: 'Finished' ]
		ifNotNil: [ instruction label: aPreview instruction instruction mnemonic.
			aPreview instruction instruction isPush
				ifTrue: [ args label: aPreview instruction instruction parameter printString ]
				ifFalse: [ args label: ('[{1}]' format: {('][' join: (aPreview args collect: #printString))}) ] ]
]
