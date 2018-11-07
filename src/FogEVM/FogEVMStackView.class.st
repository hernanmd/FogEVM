Class {
	#name : #FogEVMStackView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'table'
	],
	#category : #'FogEVM-VisualDebugger'
}

{ #category : #specs }
FogEVMStackView class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :row | row add: #table ];
		yourself
]

{ #category : #accessing }
FogEVMStackView >> initializeWidgets [
	table := FTSmartTableMorph new.
	table
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	table add: 'stack' display: #printString.
	table := table asSpecAdapter
]

{ #category : #refresh }
FogEVMStackView >> refresh [
	table widget refresh
]

{ #category : #accessing }
FogEVMStackView >> stack: aStack [
	table morph elements: aStack .
]

{ #category : #accessing }
FogEVMStackView >> table [
	^ table
]
