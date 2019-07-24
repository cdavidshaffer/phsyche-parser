"
Unit tests for PParser.
"
Class {
	#name : #PParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Phsyche-Parser'
}

{ #category : #tests }
PParserTest >> setUp [ 

	super setUp.
	parser := PParser new.
	
]

{ #category : #tests }
PParserTest >> testParseBoolean [

	self assert: (parser parse: 'true').
	self deny: (parser parse: 'false')
]

{ #category : #tests }
PParserTest >> testParseEmptyIsError [

	self assert: ((parser parse: '') isKindOf: PPFailure).
	self assert: ((parser parse: '   ') isKindOf: PPFailure)
]

{ #category : #tests }
PParserTest >> testParseFloat [

	self assert: (parser parse: '3.1415') equals: 3.1415.
	self assert: (parser parse: '-8.221') equals: -8.221.
	self assert: (parser parse: '0.0') equals: 0.0.
	self assert: (parser parse: '0.131') equals: 0.131.

]

{ #category : #tests }
PParserTest >> testParseInteger [

	self assert: (parser parse: '123') equals: 123.
	self assert: (parser parse: '-8') equals: -8.
	self assert: (parser parse: '0') equals: 0
]

{ #category : #tests }
PParserTest >> testParseList [

	self assert: (parser parse: '()') equals: #().
	self assert: (parser parse: '(1 -1 15 22 -18 true false)')
			equals: #(1 -1 15 22 -18 true false).
	self assert: (parser parse: '(())') equals: #(()).
	self assert: (parser parse: '((0 -3) ((-1 1)))') equals: #((0 -3) ((-1 1))).
	self assert: (parser parse: '((0 -3) ((-1 1 ())) ((())))')
			equals: #((0 -3) ((-1 1 ())) ((()))).
	self
		assert: (parser parse: '(12.33 (19.2 85.111) 3.5 3.14)')
		equals: #(12.33 (19.2 85.111) 3.5 3.14).
]

{ #category : #tests }
PParserTest >> testParseListWithSymbols [

	self assert: (parser parse: '(a b (c) d) ') equals: #(a b (c) d).

]

{ #category : #tests }
PParserTest >> testParseSymbol [

	self assert: (parser parse: 'x') equals: #x.
	self assert: (parser parse: 'monkey') equals: #monkey.
	self assert: (parser parse: '-') equals: #-.
	self assert: (parser parse: '#foo') equals: #foo
]
