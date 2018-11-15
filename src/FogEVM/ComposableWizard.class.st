Class {
	#name : #ComposableWizard,
	#superclass : #ComposablePresenter,
	#instVars : [
		'model',
		'view',
		'stepsDone',
		'previousButton',
		'nextOrAccept',
		'cancel',
		'iterator',
		'onAcceptDo',
		'lastAdded',
		'chain'
	],
	#category : #'FogEVM-UIDebugger-Wizard'
}

{ #category : #specs }
ComposableWizard class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				newRow: #view;
				newRow: [ :r | 
					r
						add: #previousButton;
						add: #nextOrAccept;
						add: #cancel ] height: 30 ]
]

{ #category : #actions }
ComposableWizard >> acceptAction [
	onAcceptDo value: self build. 
	
]

{ #category : #adding }
ComposableWizard >> addStep: aStep [
	| asStep |
	asStep := aStep asStep. 
	chain ifNil: [ chain := asStep ] ifNotNil: [ lastAdded addStep: asStep ].
	lastAdded := asStep.
	^ asStep
]

{ #category : #build }
ComposableWizard >> build [
	^ model
]

{ #category : #accessing }
ComposableWizard >> cancel [
	^ cancel
]

{ #category : #actions }
ComposableWizard >> cancelAction [
	self delete.
]

{ #category : #accessing }
ComposableWizard >> cancelText [
	^ 'Cancel'
]

{ #category : #initialization }
ComposableWizard >> initializeWidgets [
	stepsDone := OrderedCollection new.
	previousButton := self newButton.
	previousButton action: [ self previousAction ].
	nextOrAccept := self newButton.
	nextOrAccept action: [ self nextOrAcceptAction ].
	cancel := self newButton.
	cancel action: [ self cancelAction ].
	self setLabels.
	onAcceptDo := [ :val |  ]
]

{ #category : #accessing }
ComposableWizard >> iterator [
	^ iterator ifNil: [ iterator := chain ].
]

{ #category : #actions }
ComposableWizard >> nextAction [
	iterator isDone
		ifFalse: [ ^ self ].
	iterator build.
	stepsDone addLast: iterator.
	iterator := iterator next.
	iterator model: model.
	view := iterator widgetAsNext.
	self refresh
]

{ #category : #accessing }
ComposableWizard >> nextOrAccept [
	^ nextOrAccept
]

{ #category : #actions }
ComposableWizard >> nextOrAcceptAction [
	self iterator atEnd
		ifTrue: [ self acceptAction ]
		ifFalse: [ self nextAction ].
	self setLabels.
]

{ #category : #accessing }
ComposableWizard >> nextOrAcceptText [
	self iterator ifNil: [ ^ 'Wizard not configured' ].
	^ self iterator atEnd
		ifTrue: [ 'Confirm' ]
		ifFalse: [ 'Next' ]
]

{ #category : #adding }
ComposableWizard >> on: aTwoOptionalParametersBlock addStep: aStep [
	aStep setCriteria: aTwoOptionalParametersBlock.
	^ self addStep: aStep
]

{ #category : #api }
ComposableWizard >> openOnModel: aModel [
	^ self openOnModel: aModel withSpec: self defaultSpecSelector.
]

{ #category : #api }
ComposableWizard >> openOnModel: aModel withSpec: aSpec [
 	model := aModel.
	^ super openWithSpec: aSpec
]

{ #category : #api }
ComposableWizard >> openWithSpec: aSpec [
	self error:'Wizard needs to be opened with a model. please use #openOnModel: aModel / #openOnModel: aModel withSpec: aSpec '.
]

{ #category : #actions }
ComposableWizard >> previousAction [
	iterator := stepsDone removeLast.
	view := iterator widgetAsPrevious.
	self setLabels.
	self refresh.
]

{ #category : #accessing }
ComposableWizard >> previousButton [
	^ previousButton
]

{ #category : #accessing }
ComposableWizard >> previousLabelText [
	^ 'Back'
]

{ #category : #actions }
ComposableWizard >> refresh [
	self needRebuild.
	window value rebuildWithSpecLayout: self defaultSpec.
	self updatePresenter
]

{ #category : #accessing }
ComposableWizard >> setLabels [
	previousButton label: self previousLabelText.
	previousButton enabled: stepsDone isNotEmpty.
	
	nextOrAccept label: self nextOrAcceptText.
	cancel label: self cancelText
]

{ #category : #accessing }
ComposableWizard >> view [
	self setLabels.
	^ view ifNil:[ view := self iterator widget ]
]
