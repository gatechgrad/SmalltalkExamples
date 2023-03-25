Object subclass: #NumberGuess
	instanceVariableNames: 'secret_number guess_number guesses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-Number-Guess'!

!NumberGuess methodsFor: 'as yet unclassified' stamp: 'LDS 8/31/2019 01:41'!
guessNumber
	"called when the player should guess the number"
	| number_guess |

	number_guess := FillInTheBlankMorph request: 'Guess'.
	number_guess := number_guess asNumber.
	
	guesses := guesses + 1.
	
^number_guess.! !

!NumberGuess methodsFor: 'as yet unclassified' stamp: 'LDS 8/31/2019 01:48'!
initialize
	"comment stating purpose of message"

	secret_number := (1 to: 100)  atRandom.
	guesses := 0.
	
	[ (guess_number ~= secret_number)]
	whileTrue: [
		guess_number := self guessNumber.
		
		(guess_number > secret_number)
		ifTrue: [
			Transcript show: 'Lower'.
			Transcript cr.
			].
		
		(guess_number < secret_number) 
		ifTrue: [
			Transcript show: 'Higher'.
			Transcript cr.
			].
		
		(guess_number = secret_number) 
		ifTrue: [
			Transcript show: 'You win'.
			Transcript cr.
			Transcript show: guesses.
			Transcript show: ' Total Guesses'.
			Transcript cr.
			].
		
		].! !

!NumberGuess methodsFor: 'as yet unclassified' stamp: 'LDS 8/31/2019 01:23'!
showSecretNumber
	"displays the secret number"

	Transcript show: secret_number.! !
