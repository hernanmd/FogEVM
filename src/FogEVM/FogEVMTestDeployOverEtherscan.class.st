Class {
	#name : #FogEVMTestDeployOverEtherscan,
	#superclass : #FogTestCase,
	#instVars : [
		'interpreter',
		'contract'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'building suites' }
FogEVMTestDeployOverEtherscan class >> contractsWithParameterlessConstructors [
	| selectors contents session contracts |
	selectors := SmGContractsContents selectors reject: [ :s | s beginsWith: 'base64' ].
	contents := SmGContractsContents new.
	session := FogConnection createDefaultConnection nonCachedSession.
	contracts := selectors flatCollect: [ :s | (session loadPackageForCode: (contents perform: s) named: s) descriptions ].
	^ contracts select: [ :d | d mirror constructor parameters isEmpty ]
]

{ #category : #'building suites' }
FogEVMTestDeployOverEtherscan class >> testParameters [
	^ super testParameters
		forSelector: #contract
		addOptions: self contractsWithParameterlessConstructors
]

{ #category : #accessing }
FogEVMTestDeployOverEtherscan >> contract: aContract [
	contract := aContract.
]

{ #category : #running }
FogEVMTestDeployOverEtherscan >> setUp [
	| builder |
	super setUp.
	builder := FogEVMInterpreterBuilder new.
	builder
		interpreterClass: builder defaultInterpreter
		memoryClass: builder defaultMemory
		storageClass: builder defaultStorage.
	builder
		blockDifficulty: (FogEVMRegistry forValue: 999 bytesLength: 32)
		startedAt: DateAndTime now
		timestamp: DateAndTime now
		gasLimit: (FogEVMRegistry forValue: 999 bytesLength: 32)
		blockNumber: (FogEVMRegistry forValue: 999 bytesLength: 32)
		blockHash: (FogEVMRegistry forValue: 999 bytesLength: 32).
	builder fogURL: 'http://localhost:8545'.
	builder
		from: (FogEVMRegistry forValue: 999 bytesLength: 32)
		to: nil
		contract: nil
		context: nil
		input: #[]
		value: FogEVMRegistry zero
		gas: (FogEVMRegistry forValue: 999 bytesLength: 32)
		gasPrice: (FogEVMRegistry forValue: 999 bytesLength: 32).
	builder
		input: (contract mirror constructor encodeUsing: builder session for: contract with: {})
		returningType: nil.
	builder useFogValues: false.
	interpreter := builder build
]
