Class {
	#name : #FogEVMMemorySource,
	#superclass : #FGGridDataSource,
	#instVars : [
		'memory',
		'assignedColors',
		'showColumns'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #sizes }
FogEVMMemorySource >> assignedColors [
	^ assignedColors ifNil: [ assignedColors := Dictionary new  ]
]

{ #category : #sizes }
FogEVMMemorySource >> cellColumn: colIndex row: rowIndex [
	| dataId |
	colIndex = 0
		ifTrue: [ ^ self rowHeader: rowIndex ].
	rowIndex = 0
		ifTrue: [ ^ self columnHeader: colIndex ].
	dataId := ((rowIndex - 1) * self columns + colIndex) - 1.
	memory
		ifNil: [ ^ FGGridCell new
				row: rowIndex;
				column: colIndex;
				addMorph: 'NON' asMorph;
				width: (self columnWidth: colIndex);
				height: (self rowHeight: rowIndex);
				yourself ].
	^ dataId < memory storeSize
		ifTrue: [ FGGridCell new
				row: rowIndex;
				column: colIndex;
				addMorph: (memory loadFrom: dataId bytes: 1) hex asMorph;
				color: (self colorFor: dataId);
				width: (self columnWidth: colIndex);
				height: (self rowHeight: rowIndex);
				setBalloonText: (memory tagFor: dataId) printString;
				yourself ]
		ifFalse: [ FGGridCell new
				row: rowIndex;
				column: colIndex;
				addMorph: 'NON' asMorph;
				width: (self columnWidth: colIndex);
				height: (self rowHeight: rowIndex);
				yourself ]
]

{ #category : #sizes }
FogEVMMemorySource >> colorFor: aDataId [
	^ (memory tagFor: aDataId) inject: Color transparent into: [ :acc :each | acc + (self assignedColors at: each ifAbsentPut: [ Color random  ]) ]
]

{ #category : #sizes }
FogEVMMemorySource >> columnHeader: anIndex [
	^ FGGridCell header
		addMorph: ('+' , ((anIndex - 1) hex asString copyReplaceAll: '16r' with: '')) asMorph;
		width: (self columnWidth: anIndex);
		height: (self rowHeight: 0);
		column: anIndex yourself
]

{ #category : #sizes }
FogEVMMemorySource >> columnWidth: anIndex [
	anIndex = 0 ifTrue: [ ^ 30 ].
	^ 30
	
 
]

{ #category : #sizes }
FogEVMMemorySource >> columns [
	^  showColumns
]

{ #category : #sizes }
FogEVMMemorySource >> initialize [
	super initialize.
	showColumns := 1
]

{ #category : #sizes }
FogEVMMemorySource >> memory: aMemoryObjecy [
	
	memory := aMemoryObjecy. 
	
]

{ #category : #sizes }
FogEVMMemorySource >> rowHeader: rowIndex [
	^ rowIndex = 0
		ifTrue: [ ^ FGGridCell header
				addMorph: '' asMorph;
				row: rowIndex;
				width: (self columnWidth: 0);
				height: (self rowHeight: rowIndex);
				yourself ]
		ifFalse: [ FGGridCell header
				addMorph: (((rowIndex - 1) * self columns) hex asString copyReplaceAll: '16r' with: '') asMorph;
				row: rowIndex;
				width: (self columnWidth: 0);
				height: (self rowHeight: rowIndex);
				yourself ]
]

{ #category : #sizes }
FogEVMMemorySource >> rows [
	^ memory ifNil: [ 0 ] ifNotNil: [ (memory storeSize / self columns) ceiling ]
]

{ #category : #sizes }
FogEVMMemorySource >> showColumns: anAmount [
	showColumns := anAmount
]
