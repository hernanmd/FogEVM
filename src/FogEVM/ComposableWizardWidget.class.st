Class {
	#name : #ComposableWizardWidget,
	#superclass : #ITOptionPanel,
	#instVars : [
		'model'
	],
	#category : #'FogEVM-UIDebugger-Wizard'
}

{ #category : #accessing }
ComposableWizardWidget >> asStep [
	^ ComposableWizardStep new
		widget: self;
		yourself
]

{ #category : #accessing }
ComposableWizardWidget >> build [
	^ model
]

{ #category : #accessing }
ComposableWizardWidget >> isDone [
	^ true
]

{ #category : #accessing }
ComposableWizardWidget >> model [
	^ model
]

{ #category : #accessing }
ComposableWizardWidget >> model: aModel [
	model := aModel
]

{ #category : #accessing }
ComposableWizardWidget >> widgetAsNext [
	^ self 
]

{ #category : #accessing }
ComposableWizardWidget >> widgetAsPrevious [
	^ self 
]
