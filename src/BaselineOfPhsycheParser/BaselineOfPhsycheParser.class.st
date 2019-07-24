Class {
	#name : #BaselineOfPhsycheParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhsycheParser
}

{ #category : #baseline }
BaselineOfPhsycheParser >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		self petitParser: spec.
		spec package: 'Phsyche-Parser'.
  ]
]

{ #category : #baseline }
BaselineOfPhsycheParser >> petitParser: spec [

	spec 
		baseline: 'PetitParser'
		with: [ spec repository: 'https://github.com/moosetechnology/PetitParser' ]
]
