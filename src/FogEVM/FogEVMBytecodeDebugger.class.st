"
This is the main Presenter of the debugger.

This presenter is divided in 
-------------------------------------------------------------------------------------------------------------------
 #menu                                                                                                            |
-------------------------------------------------------------------------------------------------------------------
|   #leftSideTabs    	|   #bytecode        	|	#stack	 |                    #executed                           	   |
|							|							|			 |						   #preview 											|
|							|							|			 |-------------------------------------------------------------
|							|							|			 |						   #resoruces 										|
-------------------------------------------------------------------------------------------------------------------
|	#downSideTabs																																|
-------------------------------------------------------------------------------------------------------------------
	
The presenter main actions are located in the protocol #actions.
Most of the state of the debugger comes from the interpreter.
"
Class {
	#name : #FogEVMBytecodeDebugger,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context',
		'bytecode',
		'executed',
		'preview',
		'stack',
		'store',
		'memory',
		'interpreter',
		'interpreterView',
		'menu',
		'leftSideTabs',
		'code',
		'resources',
		'downSideTabs',
		'logs',
		'errors'
	],
	#category : #'FogEVM-UIDebugger'
}

{ #category : #specs }
FogEVMBytecodeDebugger class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :g | 
			g
				newRow: #menu height: self toolbarHeight;
				newRow: [ :mainRow | 
					mainRow
						newColumn: [ :col | col newRow: #leftSideTabs ] width: (self defaultFont widthOfString: '16rB4EBF466889C4A0239379125A7D0F9C4E8BF2A14') + 12;
						newColumn: #bytecode width: 250;
						newColumn: #stack width: 150;
						newColumn: [ :secondHalf | 
							secondHalf
								newRow: [ :upperPart | 
									upperPart
										newColumn: [ :previewArea | 
											previewArea
												newRow: #executed;
												newRow: #preview height: 30 ] ];
								newRow: #resources ] ];
				newRow: #downSideTabs height: 100 ];
		yourself
]

{ #category : #specs }
FogEVMBytecodeDebugger class >> generalMenu: aBuilder [
	<worldMenu>
	(aBuilder item: #Solidity)
		order: 2.0;
		target: self;
		help: 'Set of tools to get a better Pharo experience.'
]

{ #category : #specs }
FogEVMBytecodeDebugger class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Debugger)
		parent: #Solidity;
		order: 320;
		action: [ self new openWithSpec
				extent: 1280.0 @ 771.0;
				title: 'Smart-Anvil EVM Debugger' ];
		help: 'Debugging solidity bytecode';
		icon: self taskbarIcon.
	aBuilder withSeparatorAfter
]

{ #category : #convenience }
FogEVMBytecodeDebugger >> bindComponents [
	context activation: interpreter currentActivation.
	bytecode elements: interpreter currentActivation executableMemory.
	bytecode ip: interpreter currentActivation nextInstruction.
	preview
		preview:
			(FogEVMExecutionPreview
				from: interpreter currentActivation nextInstruction
				and: interpreter stack).
	stack stack: interpreter stack.
	store storage: interpreter storage.
	memory memory: interpreter memory.
	logs items: interpreter logs.
	errors items: interpreter errors.
	interpreterView interpreter: interpreter
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> bytecode [
	^ bytecode 
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> context [
	^ context
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> context: anObject [
	context := anObject
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> downSideTabs [
	^ downSideTabs
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> executed [
	^ executed
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> executed: anObject [
	executed := anObject.
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> initializeWidgets [
	bytecode := self instantiate: FogEVMBytecodeList.
	executed := self instantiate: FogEVMBytecodeExecutionPreviewHistoric.
	preview := self instantiate: FogEVMBytecodeExecutionPreview.
	stack := self instantiate: FogEVMStackView.

	self installResources.
	self installContextualdata.
	self installMenu.
	self installLogs.	
	

]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installContextualdata [
	leftSideTabs := self newTabManager.
	context := self instantiate: FogEVMActivationView.
	interpreterView := self instantiate: FogEVMInterpreterView.
	code := self newText.
	leftSideTabs
		addTab: (self newTab: 'Activation context' for: context);
		addTab: (self newTab: 'Interpreter context' for: interpreterView);
		addTab: (self newTab: 'Solidity code' for: code)
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installLogs [
	downSideTabs := self newTabManager.
	logs := self newList.
	errors := self newList.
	downSideTabs addTab: (self newTab: 'Logs' for: logs).
	downSideTabs addTab: (self newTab: 'Errors' for: errors)
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installMenu [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Deploying transaction';
						icon: (self iconNamed: #addIcon);
						action: [ self openSolidityFile ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save session';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self saveSession ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Restart';
						icon: (self iconNamed: #refresh);
						action: [ self restartInterpreter ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Step';
						icon: (self iconNamed: #glamorousInto);
						action: [ self stepOneInstructionOnInterpreter ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Execute';
						icon: (self iconNamed: #smallDoIt);
						action: [ self runInterpreter ] ] ].
	menu applyTo: self
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installResources [
	resources := self newTabManager.
	store := self instantiate: FogEVMStorageView.
	memory := self instantiate: FogEVMMemoryView.
	resources
		addTab: (self newTab: 'Memory' for: memory);
		addTab: (self newTab: 'Store' for: store)
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> interpreter [
	^ interpreter
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> interpreter: anInterpreter [
	interpreter := anInterpreter .
	self bindComponents.
	
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> interpreterView [
	^ interpreterView
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> leftSideTabs [
	^ leftSideTabs
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> memory [
	^ memory
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> menu [
	^ menu
]

{ #category : #convenience }
FogEVMBytecodeDebugger >> newTab: aTitle for: aWidget [
	| tab |
	tab := self newTab.
	tab closeable: false.
	tab
		label: aTitle;
		presenter: aWidget.
	^ tab
]

{ #category : #notifications }
FogEVMBytecodeDebugger >> noteBreakpoint [
	self transferData.
	self inform: 'Breakpoint reached'
]

{ #category : #actions }
FogEVMBytecodeDebugger >> openSolidityFile [
	| wizard steps activationBranch deployBranch |
	wizard := ComposableWizard new.
	steps := wizard addStep: FogEVMBuildingClassSettings new.
	activationBranch := steps on: [ :widget :model | model isActivation ] stepTo: [ FogEVMInputGenerationForActivation new ].
	(activationBranch addStep: [ FogEVMActivationForActivation new ]) addStep: [ FogEVMInterpreterEdit new ].
	deployBranch := steps on: [ :widget :model | model isDeploy ] stepTo: [ FogEVMInputGenerationForDeploy new ].
	(deployBranch addStep: [ FogEVMActivationForDeploy new ]) addStep: [ FogEVMInterpreterEdit new ].
	steps on: [ :widget :model | model isTransference ] stepTo: [ FogEVMEtherTransferSettings new ].
	(wizard openOnModel: FogEVMInterpreterBuilder new) title: ' Contract opening wizard'.
	wizard
		onAcceptDo: [ :builder | 
			self interpreter: builder build.
			memory showColumns: builder columnsToShow.
			code text: builder sourceCode ]
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> preview [
	^ preview
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> resources [
	^ resources
]

{ #category : #actions }
FogEVMBytecodeDebugger >> restartInterpreter [
	interpreter restart.
	executed restart.
	memory refresh . 
	self bindComponents.
]

{ #category : #actions }
FogEVMBytecodeDebugger >> runInterpreter [
	| firstIteration |
	firstIteration := true. 
	[ interpreter currentActivation isFinished ]
		whileFalse: [ 
			(interpreter shouldBreakNow and: [firstIteration not])
				ifTrue: [ self noteBreakpoint.
					^ self ].
			firstIteration := false.
			self stepOne ].
	self transferData.
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> stack [
	^ stack
]

{ #category : #convenience }
FogEVMBytecodeDebugger >> stepOne [
	interpreter currentActivation isFinished
		ifFalse: [ interpreter executeNextInstruction ].
	self transferPreview
]

{ #category : #actions }
FogEVMBytecodeDebugger >> stepOneInstructionOnInterpreter [
	interpreter currentActivation isFinished
		ifTrue: [ ^ self ].
	self stepOne.
	self transferData
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> store [
	^ store
]

{ #category : #convenience }
FogEVMBytecodeDebugger >> transferData [
	context activation: interpreter currentActivation.
	bytecode ip: interpreter currentActivation nextInstruction.
	bytecode refresh.
	executed refresh.
	stack refresh.
	store storage: interpreter storage.
	logs items: interpreter logs.
	errors items: interpreter errors.
	store refresh.
	memory refresh
]

{ #category : #convenience }
FogEVMBytecodeDebugger >> transferPreview [
	preview preview loadResultFrom: interpreter stack.
	executed register: preview preview.
	interpreter currentActivation isFinished
		ifFalse: [ preview preview: (FogEVMExecutionPreview from: interpreter currentActivation nextInstruction and: interpreter stack) ]
		ifTrue: [ preview preview: nil ]
]
