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
		'empty',
		'restart',
		'execute',
		'stepControl',
		'interpreterView',
		'menu',
		'sideTabs'
	],
	#category : #'FogEVM-UIDebugger'
}

{ #category : #specs }
FogEVMBytecodeDebugger class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :g | 
			g newRow: #menu height: self toolbarHeight;
			  newRow: [ :mainRow | 
					mainRow
						newColumn: [ :col | 
							col
								newRow: #sideTabs";
								newRow: #interpreterView "]
							width: (self defaultFont widthOfString: 'Hexa:[16rB4EBF466889C4A0239379125A7D0F9C4E8BF2A14]') + 12;
						newColumn: #bytecode width: 250;
						newColumn: #stack width: 150;
						newColumn: [ :secondHalf | 
							secondHalf
								newRow: [ :upperPart | 
									upperPart
										newColumn: [ :previewArea | 
											previewArea
												newRow: #executed;
												newRow: [ :p | 
													p
														newColumn: #stepControl width: 30;
														newColumn: #execute width: 30;
														newColumn: #restart width: 30;
														newColumn: #preview ]
													height: 30 ] ]
									height: 100;
								newRow: #memory height: 250;
								newRow: #store ] ] ];
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
		action: [ self new openWithSpec extent: 1280.0 @ 771.0 ];
		help: 'Debugging solidity bytecode';
		icon: self taskbarIcon.
	aBuilder withSeparatorAfter
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> bindComponents [
	context activation: interpreter currentActivation.
	bytecode elements: interpreter currentActivation executableMemory.
	bytecode ip: interpreter currentActivation nextInstruction.
	preview preview: (FogEVMExecutionPreview from: interpreter currentActivation nextInstruction and: interpreter stack).
	stack stack: interpreter stack.
	store storage: interpreter storage.
	memory memory: interpreter memory.
	"	interpreterView := (GTInspector new openOn: interpreter)
		close;
		extent: 300.0 @ 400.0;
		asSpecAdapter	"
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

{ #category : #weirdos }
FogEVMBytecodeDebugger >> empty [
	^ empty ifNil: [ empty := FogEVMEmpty new ]
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> execute [
	^ execute
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
	store := self instantiate: FogEVMStorageView.
	memory := self instantiate: FogEVMMemoryView.
	self installContextualdata.
	self installButtons.
	self installMenu.
	
	

]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installButtons [
	restart := self newButton
		icon: (self iconNamed: #refresh);
		action: [ self restartInterpreter ];
		yourself.
	stepControl := self newButton
		icon: (self iconNamed: #glamorousInto);
		action: [ self stepOneInstructionOnInterpreter ].
	execute := self newButton
		icon: (self iconNamed: #smallDoIt);
		action: [ self runInterpreter ]
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installContextualdata [
	| tab |
	sideTabs := self newTabManager. 
	context := self instantiate: FogEVMActivationView.
	interpreterView := self instantiate: FogEVMInterpreterView.
	
	tab := self newTab.
	tab closeable: false.
	tab
		label: 'Activation context';
		presenter: context.
	sideTabs addTab: tab. 
	
	tab := self newTab.
	tab closeable: false.
	tab
		label: 'Interpreter context';
		presenter: interpreterView.
	sideTabs addTab: tab. 
	
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> installMenu [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Open file';
						icon: (self iconNamed: #openIcon);
						action: [ self openSolidityFile ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Save File';
						icon: (self iconNamed: #smallSaveIcon);
						action: [ self saveSolidityFile ] ] ];
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
FogEVMBytecodeDebugger >> installToolbars [
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> interpreter [
	^ interpreter
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> interpreter: anInterpreter [
	interpreter := anInterpreter .
	self bindComponents.
	
]

{ #category : #accssing }
FogEVMBytecodeDebugger >> interpreterView [
	^ interpreterView
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> memory [
	^ memory
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> menu [
	^ menu
]

{ #category : #notifications }
FogEVMBytecodeDebugger >> noteBreakpoint [
	self inform: 'Breakpoint reached'
]

{ #category : #opening }
FogEVMBytecodeDebugger >> openSolidityFile [
	| dialog |
	dialog := FogEVMDebuggerSessionEdit new.
	dialog whenConfirmed: [ :built | self interpreter: built ].
	dialog openWithSpec
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> preview [
	^ preview
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> restart [
	^ restart
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> restartInterpreter [
	interpreter restart.
	executed restart.
	memory refresh . 
	self bindComponents.
]

{ #category : #running }
FogEVMBytecodeDebugger >> runInterpreter [
	| firstIteration |
	firstIteration := true. 
	[ interpreter currentActivation isFinished ]
		whileFalse: [ 
			(interpreter currentActivation nextInstruction shouldBreak and: [firstIteration not])
				ifTrue: [ self noteBreakpoint.
					^ self ].
			firstIteration := false.
			self stepOneInstructionOnInterpreter ]
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> sideTabs [
	^ sideTabs
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> stack [
	^ stack
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> stepControl [
	^ stepControl
]

{ #category : #'interpreter actions' }
FogEVMBytecodeDebugger >> stepOneInstructionOnInterpreter [
	interpreter executeNextInstruction .
	self transferData
]

{ #category : #accessing }
FogEVMBytecodeDebugger >> store [
	^ store
]

{ #category : #initialization }
FogEVMBytecodeDebugger >> transferData [
	context activation: interpreter currentActivation.
	preview preview loadResultFrom: interpreter stack.
	executed register: preview preview.
	preview preview: (FogEVMExecutionPreview from: interpreter currentActivation nextInstruction and: interpreter stack).

	bytecode ip: interpreter currentActivation nextInstruction .
	
	bytecode refresh.
	executed refresh.	
	stack refresh.
	store refresh.
	memory refresh.
]
