Class {
	#name : #FogEVMBuildingClassSettings,
	#superclass : #ComposableWizardWidget,
	#instVars : [
		'kind',
		'interpreterSelector',
		'memorySelector',
		'storageSelector',
		'chooseFileButton',
		'empty',
		'memoryColumns'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMBuildingClassSettings class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :left | 
					left
						newRow: #interpreterSelector height: 25;
						newRow: #memorySelector height: 25;
						newRow: #memoryColumns height: 25;
						newRow: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> availableInterpreters [
	^ {FogEVMAbstractInterpreter} , FogEVMAbstractInterpreter allSubclasses
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> availableMemory [
	^ {FogEVMMemory} , FogEVMMemory allSubclasses
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> availableStorage [
		^ {FogEVMMemoryStorage} , FogEVMMemoryStorage allSubclasses
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> chooseFileButton [
	^ chooseFileButton
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> empty [
	^ empty
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> initializeWidgets [
	interpreterSelector := self instantiate: LabelledDropList.
	interpreterSelector label: 'Interpreter:'.
	interpreterSelector
		items: self availableInterpreters;
		displayBlock: [ :item | item name ].
	memoryColumns := self instantiate: LabelledDropList.
	memoryColumns label: 'Memory visualization columns'.
	memoryColumns items: {8 . 16 . 32 . 64 . 128}.
	memorySelector := self instantiate: LabelledDropList.
	memorySelector label: 'Memory Layout'.
	memorySelector
		items: self availableMemory;
		displayBlock: [ :item | item name ].
	storageSelector := self instantiate: LabelledDropList.
	storageSelector label: 'Storage '.
	storageSelector
		items: self availableStorage;
		displayBlock: [ :item | item name ].
	empty := self newLabel.
	empty label: ''.
	kind := self instantiate: LabelledDropList.
	kind items: {'Deploy contract' . 'Activate method' . 'Transfer money'}.
	kind label: 'Kind of transaction'.
	self setDefaults
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> interpreterSelector [
	^ interpreterSelector
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> isDeploy [
	^ kind selectedItem beginsWith: 'Deploy'
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> memoryColumns [
	^ memoryColumns
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> memorySelector [
	^ memorySelector
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> setDefaults [
	interpreterSelector setSelectedItem: FogEVMSimulatorInterpreter .
	memorySelector setSelectedItem: FogEVMTraceableMemory.
	storageSelector setSelectedItem: FogEVMMemoryStorage.
	memoryColumns setSelectedItem: 32
]

{ #category : #building }
FogEVMBuildingClassSettings >> setUp: aFogEVMInterpreterBuilder [
	aFogEVMInterpreterBuilder
		interpreterClass: interpreterSelector selectedItem
		memoryClass: memorySelector selectedItem
		storageClass: storageSelector selectedItem.
	aFogEVMInterpreterBuilder columnsToShow: memoryColumns selectedItem
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> storageSelector [
	^ storageSelector
]
