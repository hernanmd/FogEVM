Class {
	#name : #FogEVMBuildingClassSettings,
	#superclass : #ComposablePresenter,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#instVars : [
		'kind',
		'interpreterSelector',
		'memorySelector',
		'storageSelector',
		'empty',
		'memoryColumns',
		'fogUrl'
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
						newRow: #storageSelector height: 25;
						newRow: #memoryColumns height: 25;
						newRow: #fogUrl  height: 25;
						newRow: #kind height: 25;
						newRow: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> build [ 	
	self setUp: model
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> empty [
	^ empty
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> fogUrl [
	^ fogUrl
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> initializeWidgets [
	interpreterSelector := self instantiate: LabelledDropList.
	interpreterSelector label: 'Interpreter:'.
	interpreterSelector displayBlock: [ :item | item name ].
	memoryColumns := self instantiate: LabelledDropList.
	memoryColumns label: 'Memory visualization columns'.
	memoryColumns items: {8 . 16 . 32 . 64 . 128}.
	memorySelector := self instantiate: LabelledDropList.
	memorySelector label: 'Memory Layout'.
	memorySelector displayBlock: [ :item | item name ].
	storageSelector := self instantiate: LabelledDropList.
	storageSelector label: 'Storage '.
	storageSelector displayBlock: [ :item | item name ].
	empty := self newLabel.
	empty label: ''.
	fogUrl := self instantiate: LabelledTextInput.
	fogUrl label: 'GETH RPC'.
	fogUrl autoAccept: true.
	fogUrl text: 'http://localhost:8545'.
	kind := self instantiate: LabelledDropList.
	kind items: {#Deploy . #Activate . #Transfer}.
	kind label: 'Transaction'.
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

{ #category : #initialization }
FogEVMBuildingClassSettings >> kind [
	^ kind
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> memoryColumns [
	^ memoryColumns
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> memorySelector [
	^ memorySelector
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> model: aModel [
	model := aModel.
	storageSelector items: aModel availableStorage.
	memorySelector items: aModel availableMemory.
	interpreterSelector items: aModel availableInterpreters.
	interpreterSelector setSelectedItem: aModel defaultInterpreter.
	memorySelector setSelectedItem: aModel defaultMemory.
	storageSelector setSelectedItem: aModel defaultStorage
]

{ #category : #initialization }
FogEVMBuildingClassSettings >> setDefaults [
	memoryColumns setSelectedItem: 32
]

{ #category : #building }
FogEVMBuildingClassSettings >> setUp: aFogEVMInterpreterBuilder [
	aFogEVMInterpreterBuilder
		interpreterClass: interpreterSelector selectedItem
		memoryClass: memorySelector selectedItem
		storageClass: storageSelector selectedItem.
	aFogEVMInterpreterBuilder columnsToShow: memoryColumns selectedItem.
	aFogEVMInterpreterBuilder setKindOfTrasaction: kind selectedItem asSymbol.
	aFogEVMInterpreterBuilder fogURL: fogUrl text.
]

{ #category : #accessing }
FogEVMBuildingClassSettings >> storageSelector [
	^ storageSelector
]
