Class {
	#name : #BaselineOfPhsycheParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhsycheParser
}

{ #category : #baseline }
BaselineOfPhsycheParser >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec package: 'Phsyche-Parser' with:
			[ spec requires:  ''] 
  ]
]

{ #category : #baseline }
BaselineOfPhsycheParser >> petitParser: spec [

	spec 
		baseline: 'PetitParser'
		with: [ spec repository: 'https://github.com/moosetechnology/PetitParser' ]
]
