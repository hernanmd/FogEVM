"
This screen allows to execute configure the transference of money from an account to an other one.
"
Class {
	#name : #FogEVMEtherTransferSettings,
	#superclass : #ComposablePresenter,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#instVars : [
		'from',
		'to',
		'unit',
		'empty',
		'amount'
	],
	#category : #'FogEVM-UIDebugger-OpenWizard'
}

{ #category : #specs }
FogEVMEtherTransferSettings class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :left | 
					left
						newRow: #from height: 25;
						newRow: #to height: 25;
						newRow: [ :q | 
							q
								add: #amount;
								add: #unit ]
							height: 25;
						add: #empty ];
				newColumn: #empty width: 10 ]
]

{ #category : #'as yet unclassified' }
FogEVMEtherTransferSettings >> amount [
	^ amount
]

{ #category : #initialization }
FogEVMEtherTransferSettings >> empty [
	^ empty
]

{ #category : #accessing }
FogEVMEtherTransferSettings >> from [
	^ from
]

{ #category : #initialization }
FogEVMEtherTransferSettings >> initializeWidgets [
	from := self instantiate: LabelledDropList.
	from label: 'From'.
	to := self instantiate: LabelledDropList.
	to label: 'To'.
	amount := self instantiate: LabelledTextInput.
	amount label: 'Amount'.
	unit := self instantiate: LabelledDropList.
	unit label: 'Unit'.
	unit items: { #Wei }.
	empty := self newLabel.
	empty label: ''
]

{ #category : #accessing }
FogEVMEtherTransferSettings >> to [
	^ to
]

{ #category : #accessing }
FogEVMEtherTransferSettings >> unit [
	^ unit
]
