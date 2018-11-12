Class {
	#name : #FogEVMBuildingSettings,
	#superclass : #ComposablePresenter,
	#instVars : [
		'interpreterSelector',
		'memorySelector',
		'storageSelector',
		'fileSelector',
		'chooseFileButton',
		'empty',
		'bytecodes',
		'contractSelector'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMBuildingSettings class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :left | 
					left
						newRow: #interpreterSelector height: 25;
						newRow: #memorySelector height: 25;
						newRow: #storageSelector height: 25;
						newRow: [ :ff | 
							ff
								add: #fileSelector;
								add: #chooseFileButton width: 25 ]
							height: 25;
						newRow: #contractSelector height: 25;
						add: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #initialization }
FogEVMBuildingSettings >> availableInterpreters [
	^ {FogEVMInterpreter} , FogEVMInterpreter allSubclasses
]

{ #category : #initialization }
FogEVMBuildingSettings >> availableMemory [
	^ {FogEVMMemory} , FogEVMMemory allSubclasses
]

{ #category : #initialization }
FogEVMBuildingSettings >> availableStorage [
		^ {FogEVMBucketStorage} , FogEVMBucketStorage allSubclasses
]

{ #category : #initialization }
FogEVMBuildingSettings >> chooseFileButton [
	^ chooseFileButton
]

{ #category : #accessing }
FogEVMBuildingSettings >> contractSelector [
	^ contractSelector
]

{ #category : #accessing }
FogEVMBuildingSettings >> data [
	| interpreter |
	bytecodes isNil
		ifTrue: [ ^ self error: 'You must provide a valid solidity file' ].
	interpreter := interpreterSelector selectedItem new.
	interpreter installMemory: memorySelector selectedItem new.
	interpreter installStorage: storageSelector selectedItem new.
	^ interpreter
]

{ #category : #accessing }
FogEVMBuildingSettings >> empty [
	^ empty
]

{ #category : #accessing }
FogEVMBuildingSettings >> fileSelector [
	^ fileSelector
]

{ #category : #initialization }
FogEVMBuildingSettings >> initializeWidgets [
	interpreterSelector := self instantiate: LabelledDropList.
	interpreterSelector label: 'Interpreter:'.
	interpreterSelector
		items: self availableInterpreters;
		displayBlock: [ :item | item name ].
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
	contractSelector := self instantiate: LabelledDropList.
	contractSelector label: 'Contract'.
	contractSelector
		items: {};
		displayBlock: [ :item | item asString ].
	fileSelector := self instantiate: LabelledTextInput.
	fileSelector label: ' Solidity File '.
	fileSelector enabled: false.
	chooseFileButton := self newButton.
	chooseFileButton
		icon: (self iconNamed: #smallOpen);
		action: [ self openFileDialog ].
	empty := self newLabel.
	empty label: ''.
	self setDefaults.
]

{ #category : #accessing }
FogEVMBuildingSettings >> interpreterSelector [
	^ interpreterSelector
]

{ #category : #accessing }
FogEVMBuildingSettings >> memorySelector [
	^ memorySelector
]

{ #category : #initialization }
FogEVMBuildingSettings >> openFileDialog [
	| file |
	file := FDOpenFileDialog new
		extensionFilters:
			{('Solidity' -> #(sol)).
			('All files' -> #())};
		openModal.
	fileSelector text: file asString.
	bytecodes := FogUtils new compileSolidity: file.
	contractSelector items: bytecodes keys
]

{ #category : #initialization }
FogEVMBuildingSettings >> setDefaults [

	interpreterSelector setSelectedItem: FogEVMDebuggingInterpreter.  
	memorySelector setSelectedItem: FogEVMTraceableMemory.
	storageSelector setSelectedItem: FogEVMBucketStorage.
]

{ #category : #building }
FogEVMBuildingSettings >> setUp: aFogEVMInterpreterBuilder [
	bytecodes isNil
		ifTrue: [ ^ self error: 'You must provide a valid solidity file' ].
	aFogEVMInterpreterBuilder interpreterClass: interpreterSelector selectedItem memoryClass: memorySelector selectedItem storageClass: storageSelector selectedItem.
	aFogEVMInterpreterBuilder contractBytecode: (bytecodes at: contractSelector selectedItem) named: contractSelector selectedItem deploying: #binary.
]

{ #category : #accessing }
FogEVMBuildingSettings >> storageSelector [
	^ storageSelector
]
