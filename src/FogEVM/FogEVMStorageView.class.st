Class {
	#name : #FogEVMStorageView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'storage'
	],
	#category : #'FogEVM-VisualDebugger'
}

{ #category : #specs }
FogEVMStorageView class >> defaultSpec [
	<spec>
	^ SpecLayout composed
]

{ #category : #initialization }
FogEVMStorageView >> initializeWidgets [ 
]

{ #category : #'as yet unclassified' }
FogEVMStorageView >> refresh [
	" "
]
