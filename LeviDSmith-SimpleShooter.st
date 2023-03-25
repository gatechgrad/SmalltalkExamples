EllipseMorph subclass: #Bullet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-SimpleShooter'!

!Bullet methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 03:15'!
checkCollision
| enemy listEnemies |

	(owner ~= nil)
	ifTrue: [
		listEnemies := owner getEnemies.
		1 to: listEnemies size do: [:i | 
			enemy := listEnemies at: i.
			((self intersects:  enemy bounds) & (enemy getAlive))
			ifTrue: [
				enemy color: Color red.
				enemy setDead.
				owner addScore: 100.
				enemy delete.
				self delete.
				].
			].
		
		"
	enemy := owner getEnemies at: 1.
	(self intersects: enemy bounds)
	ifTrue: [
		enemy color: Color red.
		].
	"
	].   ! !

!Bullet methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 23:39'!
initialize
   	"comment stating purpose of message"
  
	super initialize.
	self width: 16.
	 self height: 16 .           ! !

!Bullet methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 00:22'!
move
	"comment stating purpose of message"
	| p |
	p := self position.
	
	p setX: self position x setY: p y - 5.
	self width: 16.
	self height: 16.
	
	(self position y < owner position y)
	ifTrue: [
		"destroy bullet"
		self color: Color green.
		self delete.            
  		].
! !

!Bullet methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 00:52'!
step
	self move.
	self checkCollision     .          
	 ! !

!Bullet methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 23:51'!
stepTime
^33! !


TextMorph subclass: #DebugText
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-SimpleShooter'!


RectangleMorph subclass: #Enemy
	instanceVariableNames: 'isAlive moveVelX directionDelay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-SimpleShooter'!

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 00:51'!
getAlive
^isAlive! !

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 02:40'!
initialize
	super initialize.
	isAlive := true.
	self color: Color green.
	self borderColor: Color lightGreen.

	self width: 32.
	self height: 32.
	
	moveVelX = 10.
	directionDelay = 1000.! !

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 03:03'!
move

| p newX|

(moveVelX == nil)
ifTrue: [
	moveVelX := 10.
].




	p := self position.

(p x > (owner left + 300))
ifTrue: [
	moveVelX := -10.
	].

(p x < (owner left + 100))
ifTrue: [
	moveVelX := 10.
	].

"	newX := p x + 10."
"		Transcript show: p x asString.
		Transcript show: moveVelX asString."

	
	newX := p x + moveVelX.

	
"	self setX: self position x + moveVelX setY: self position y."
		p setX: newX setY: p y.

	self width: 32.
	self height: 32.
	
	owner changed. "This need to be called for the enemy artifacts to be cleared"
! !

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 02:01'!
setDead
isAlive := false.
	self color: Color red.
	self borderColor: Color lightRed.
! !

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 02:16'!
step
	self move.
"	directionDelay := directionDelay - 33."! !

!Enemy methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 02:29'!
stepTime
^1000! !


RectangleMorph subclass: #SimpleShip
	instanceVariableNames: 'shootDelay shipImage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-SimpleShooter'!

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 01:24'!
handleKeyboardEvent: anEvent

	| keypressed |
"	Transcript show: 'key pressed'.
	Transcript show: anEvent keyString asLowercase.
	Transcript cr."
	keypressed := anEvent keyString asLowercase.

	(keypressed = '<left>')
	ifTrue: [ self moveShip: -5@0 ].
	
	(keypressed = '<right>')
	ifTrue: [ self moveShip: 5@0 ].

	(keypressed = '<up>')
	ifTrue: [ self moveShip: 0@ -5 ].

	(keypressed = '<down>')
	ifTrue: [ self moveShip: 0@ 5 ].

	(keypressed = '<space>')
	ifTrue: [ self shoot. ].
	
	(keypressed = 'r')
	ifTrue: [ owner restartGame. ].

	
"
      p := self position.
	(keypressed = '<left>')
	ifTrue: [ self position: -5@0 + p ].
	
	(keypressed = '<right>')
	ifTrue: [ self position: 5@0 + p ].

	(keypressed = '<up>')
	ifTrue: [ self position: 0@ -5 + p ].

	(keypressed = '<down>')
	ifTrue: [ self position: 0@ 5 + p ].

	(keypressed = '<space>')
	ifTrue: [ Transcript show: 'Fire' ].
"	
	"
	(keypressed = '<left>')
	ifTrue: [ Transcript show: 'Move Left' ].
	
	(keypressed = '<right>')
	ifTrue: [ Transcript show: 'Move Right' ].

	(keypressed = '<up>')
	ifTrue: [ Transcript show: 'Move Up' ].

	(keypressed = '<down>')
	ifTrue: [ Transcript show: 'Move Down' ].

	(keypressed = '<space>')
	ifTrue: [ Transcript show: 'Fire' ]."
! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:07'!
handleListenEvent: anEvent
	anEvent isMouse
		ifTrue: [self handleMouseEvent: anEvent]
		ifFalse: [self handleKeyboardEvent: anEvent]! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:08'!
handleMouseEvent: anEvent
	"comment stating purpose of message"

! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 00:37'!
initialize
	"comment stating purpose of message"
	| c |
	
	super initialize.
	
	c := Color r: 0.8 g: 0.8 b: 0.8.
	
	self color: c.
	self borderColor: Color white.
	self extent: 32@32.
	
	shootDelay := 0.
	
"	shipImage = ImageMorph new.
	shipImage image: (ImageReadWriter formFromFileNamed: 'e:/ldsmith/presentations/smalltalk/ship.png')."! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:15'!
intoWorld: aWorld
	super intoWorld: aWorld.
	self registerToEvents.! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 20:36'!
moveShip: point
"Move the ship by the specified number of pixels"

| p |
   p := self position.
   self position: point + p.

  (self left < owner left)
  ifTrue: [
	self position setX: owner left setY: self position y.
	self width: 32.

	].

  (self right > owner right)
  ifTrue: [
	self position setX: owner right - 32 setY: self position y.
	self width: 32.
	].

  (self top < owner top)
ifTrue: [
	self position setX: self position x setY: owner top.
	self height: 32.
	].

  (self bottom > owner bottom)
ifTrue: [
	self position setX: self position x setY: owner bottom -32.
	self height: 32.
	].
! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:17'!
outOfWorld: aWorld
	self unregisterToEvents.
	super outOfWorld: aWorld.
! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:17'!
registerToEvents
	self currentHand
		addKeyboardListener: self;
		addMouseListener: self! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 00:26'!
shoot
	"comment stating purpose of message"

	| bullet |
	
	(shootDelay <= 0)
	ifTrue: [
 	bullet := Bullet new.
	owner  addMorph: bullet.           
"	bullet position setX: self position x setY: self position y."  
	bullet color: Color red.
"	bullet position: 100@100."
	bullet position: self position.
"	Transc ript show: 'shoot'."
	shootDelay := 1000.
   ].    ! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 00:25'!
step
	"comment stating purpose of message"

	(shootDelay > 0)
	ifTrue: [
		shootDelay := shootDelay - self stepTime.
		].
! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 00:23'!
stepTime
^33! !

!SimpleShip methodsFor: 'as yet unclassified' stamp: 'LDS 9/1/2019 19:17'!
unregisterToEvents
	self currentHand
		removeKeyboardListener: self;
		removeMouseListener: self! !


Morph subclass: #SimpleShooter
	instanceVariableNames: 'listEnemies score debugtext'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LeviDSmith-SimpleShooter'!

!SimpleShooter methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 01:07'!
addScore: points
	"comment stating purpose of message"

	score := score + 100.

	debugtext string: score printString fontName: #Atlanta size: 22.
"	debugtext extent: 200@200."
"	debugtext contents: score printString."! !

!SimpleShooter methodsFor: 'as yet unclassified' stamp: 'LDS 9/2/2019 01:01'!
getEnemies
^listEnemies! !

!SimpleShooter methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 01:56'!
initialize
	"comment stating purpose of message"

| p ship  |
"self := Morph new openInWorld."
super initialize.

score := 0.

self position: 100@100.
self extent: 640@480.
self color: Color black.
self setNameTo: 'Simple Shooter'.

ship := SimpleShip new.
self addMorph: ship.
p := self position.
ship position: 420@400 + p.



debugtext := DebugText new.
self addMorph: debugtext.
debugtext textColor: Color green.
debugtext position: 100@150.
debugtext width: 320.
debugtext height: 150.

debugtext string: score asString fontName: #Atlanta size: 22.
"debugtext extent: 320 @ 150."
"debugtext text: Text fromString: 'hello'."

self restartGame.! !

!SimpleShooter methodsFor: 'as yet unclassified' stamp: 'LDS 9/8/2019 02:09'!
restartGame
|enemy p|


	(listEnemies ~= nil)
	ifTrue: [

		1 to: listEnemies size do: [:i | 
			enemy := listEnemies at: i.
			enemy delete.
			].
		].



p := self position.

listEnemies := Array new: 3.

enemy := Enemy new.
self addMorph: enemy.
enemy position: 320@64 + p.
listEnemies at: 1 put: enemy.

enemy := Enemy new.
self addMorph: enemy.
enemy position: 220@128 + p.
listEnemies at: 2 put: enemy.

enemy := Enemy new.
self addMorph: enemy.
enemy position: 420@256 + p.
listEnemies at: 3 put: enemy.
! !
