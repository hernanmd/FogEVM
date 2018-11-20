"
This object allows to visualiza all the previously executed instructions
"
Class {
	#name : #FogEVMBytecodeExecutionPreviewHistoric,
	#superclass : #ComposablePresenter,
	#instVars : [
		'table',
		'stack',
		'previews'
	],
	#category : #'FogEVM-UIDebugger-View'
}

{ #category : #specs }
FogEVMBytecodeExecutionPreviewHistoric class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :row | row newColumn: #table ];
		yourself
]

{ #category : #initialization }
FogEVMBytecodeExecutionPreviewHistoric >> initializeWidgets [
	previews := OrderedCollection new.
	table := FTSmartTableMorph new.
	table
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	table add: 'Result' accessing: #resultString.
	(table add: 'instructions' accessing: #mnemonic) width: 200.
	1 to: 7 do: [ :idx | 
		table
			add: '#'
			display: [ :preview | 
				preview args size >= idx
					ifTrue: [ preview args at: idx ]
					ifFalse: [ '' ] ] ].
	table beResizable.
	table elements: previews.
	table := table asSpecAdapter
]

{ #category : #refresh }
FogEVMBytecodeExecutionPreviewHistoric >> refresh [
	table widget selectRowIndex: previews size.
	table widget refresh.
]

{ #category : #accessing }
FogEVMBytecodeExecutionPreviewHistoric >> register: aFogEVMExecutionPreview [ 
	previews add: aFogEVMExecutionPreview.


]

{ #category : #refresh }
FogEVMBytecodeExecutionPreviewHistoric >> restart [
	previews removeAll.
	table widget refresh
]

{ #category : #accessing }
FogEVMBytecodeExecutionPreviewHistoric >> table [
	^ table
]
