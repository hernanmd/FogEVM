Class {
	#name : #FogEVMMemoryView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'table'
	],
	#category : #'FogEVM-UIDebugger-View'
}

{ #category : #specs }
FogEVMMemoryView class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :row | row add: #table ];
		yourself
]

{ #category : #initialization }
FogEVMMemoryView >> initializeWidgets [
	table := FGGridMorph new.
	table
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	table dataSource: FogEVMMemorySource new.
	table := table asSpecAdapter
]

{ #category : #initialization }
FogEVMMemoryView >> memory: aMemoryObject [
	table morph dataSource memory: aMemoryObject 
]

{ #category : #refresh }
FogEVMMemoryView >> refresh [
	table widget refresh 
]

{ #category : #accessing }
FogEVMMemoryView >> showColumns: anAmount [
	table widget dataSource showColumns: anAmount
]

{ #category : #accessing }
FogEVMMemoryView >> table [
	^ table
]
