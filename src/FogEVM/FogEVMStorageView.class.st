Class {
	#name : #FogEVMStorageView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'storageTable'
	],
	#category : #'FogEVM-UIDebugger-View'
}

{ #category : #specs }
FogEVMStorageView class >> defaultSpec [
	<spec>
	^ SpecLayout composed add: #storageTable
]

{ #category : #initialization }
FogEVMStorageView >> initializeWidgets [
	storageTable := FTTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter
]

{ #category : #accessing }
FogEVMStorageView >> refresh [
	" "
]

{ #category : #initialization }
FogEVMStorageView >> storage: aStorage [
	| dataSource |
	dataSource := FTTreeDataSource roots: {aStorage} children: [ :data | data entries ].
	storageTable widget dataSource: dataSource
]

{ #category : #accessing }
FogEVMStorageView >> storageTable [
	^ storageTable
]
