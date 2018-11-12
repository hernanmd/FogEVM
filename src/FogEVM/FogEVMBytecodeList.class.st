Class {
	#name : #FogEVMBytecodeList,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list',
		'ip'
	],
	#category : #'FogEVM-UIDebugger'
}

{ #category : #specs }
FogEVMBytecodeList class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: #list;
		yourself
]

{ #category : #accessing }
FogEVMBytecodeList >> elements: aFogEVMByteCode [
	list morph elements: aFogEVMByteCode
]

{ #category : #initialization }
FogEVMBytecodeList >> initializeWidgets [
	list := FTSmartTableMorph new.
	list
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	(list
		add: ' IP '
		display: [ :m | 
			m shouldBreak
				ifTrue: [ self iconNamed: #testRed ]
				ifFalse: [ m = ip
						ifTrue: [ self iconNamed: #forward ]
						ifFalse: [ '' ] ] ]) width: 30.
	(list add: '#' display: [ :m | m byteNumber hex asString ]) width: 50.
	list
		onAnnouncement: FTStrongSelectionChanged
		do: [ :ann | 
			(list widget elements at: ann selectedRowIndex) toggleBreakpoint.
			self refresh ].
	list
		add: #instruction;
		beResizable.
	list := list asSpecAdapter
]

{ #category : #accessing }
FogEVMBytecodeList >> ip: anInstruction [ 
	ip := anInstruction.
	list widget selectRowIndex: (list widget dataSource elements indexOf: anInstruction).
	list widget refresh.
	
]

{ #category : #accessing }
FogEVMBytecodeList >> list [
	^ list
]

{ #category : #refresh }
FogEVMBytecodeList >> refresh [
	list widget refresh
]
