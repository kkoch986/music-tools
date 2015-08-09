
allNotes 	= ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]
noteAliases	= [
	["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"]
]

# a mapping from semitones to interval names
intervalNames = [
	"Perfect Unison", 
	"Minor Second", 
	"Major Second", 
	"Minor Third", 
	"Major Third", 
	"Perfect Fourth", 
	"Dimished Fifth", 
	"Perfect Fifth", 
	"Minor Sixth", 
	"Major Sixth", 
	"Minor Seventh", 
	"Major Seventh", 
	"Perfect Octave"
]
intervalSymbols = ["P1", "m2", "M2", "m3", "M3", "P4", "d5", "P5", "m6", "M6", "m7", "M7", "P8"]

# A Basic note, wil laccept a tone and provide some basic functionality on it.
class Note
	# TODO: Validate input into constructor.
	constructor: (@tone, @octave, @duration) ->
		# TODO: Normalize flat tones or double sharp/double flat tones into tones that are in the allNotes array
		@octave = @octave ? 4
		@duration = @duration ? 1 # duration is 1 = whole note
	midiNote: () ->
		21 + (12 * @octave) + allNotes.indexOf(@tone)
	# return the notes
	getNotes: () -> 
		return [ this ]
	toString: () ->
		@tone + @octave
	wholeStepAbove: ->
		index = allNotes.indexOf(@tone)
		octave = if index + 2 < allNotes.length then @octave else @octave + 1
		new Note allNotes[(index + 2) % allNotes.length], octave
	wholeStepBelow: ->
		index = (allNotes.indexOf(@tone) - 2) % allNotes.length
		octave = if allNotes.indexOf(@tone) - 2 >= 0 then @octave else @octave - 1
		new Note allNotes[index..index][0], octave
	halfStepAbove: ->
		index = allNotes.indexOf(@tone)
		octave = if index + 1 < allNotes.length then @octave else @octave + 1
		new Note allNotes[(index + 1) % allNotes.length], octave
	halfStepBelow: ->
		index = (allNotes.indexOf(@tone) - 1) % allNotes.length
		octave = if allNotes.indexOf(@tone) - 1 >= 0 then @octave else @octave - 1
		new Note allNotes[index..index][0], octave

	# Compute the number of semitones needed to get to the given note
	distanceTo: (note) ->
		myIndex = allNotes.indexOf(@tone)
		theirIndex = allNotes.indexOf(note.tone)
		distance = theirIndex - myIndex
		distance += 12 * (note.octave - @octave)
		distance

	# Compute the number of semitones needed to get to the given note
	# ignoring differences in octave
	tonalDistanceTo: (note) ->
		myIndex = allNotes.indexOf(@tone)
		theirIndex = allNotes.indexOf(note.tone)
		distance = theirIndex - myIndex
		distance

	# Tonal distance above is the distance in semitones from this note
	# to the next note above this note with the same tone as the given note.
	# For example,  G3 tonalDistanceAbove A2 would result in 2 (the distance between G3 -> A4)
	tonalDistanceAbove: (note) ->
		distanceA = this.tonalDistanceTo(note)
		if(distanceA >= 0)
			distanceA
		else 
			this.distanceTo(new Note(note.tone, this.octave + 1))

	# Return the result of taking this note and adding the given number of semitones
	# this does not modify the current note.
	add: (semitones) ->
		retNote = new Note(@tone, @octave)
		while(semitones > 0)
			semitones--
			retNote = retNote.halfStepAbove()

		while(semitones < 0)
			semitones++
			retNote = retNote.halfStepBelow()

		retNote

# A Chord Class which can determine what type of chord it is...
class Chord 
	constructor: (@rootNote, @notes, @duration) -> 
		@duration = @duration ? 1
	toString: () ->
		@rootNote.tone + " " + this.getType() + " (" + @notes.join(",") + ")"	
	inspect: () ->
		this.toString()

	# return the notes
	getNotes: () -> 
		@notes

	# Return true if the given tone is found i nthis chord
	toneExists: (note) ->
		for n of @notes
			if(@notes[n].tone == note.tone)
				return true
		return false

	# Identify the chord type.
	# TODO: More complex chord identification, ie inversions missing tones etc...
	getType: () ->
		# sort notes by tone
		notes = @notes.slice(0)
		rootNoteIndex = allNotes.indexOf(@rootNote.tone)
		notes.sort (a, b) ->
			return b.distanceTo(a)

		# identify the core triad type
		interval1 = @rootNote.tonalDistanceAbove(notes[1])
		interval2 = @rootNote.tonalDistanceAbove(notes[2])
		triadType = "Unkown"
		
		# Major triads contain a major third and perfect fifth interval, symbolized: R 3 5 (or 0-4-7 as semitones)
		if(interval1 == 4 && interval2 == 7) 
			triadType = "Major"

		# minor triads contain a minor third, and perfect fifth, symbolized: R b3 5 (or 0-3-7)
		else if(interval1 == 3 && interval2 == 7) 
			triadType = "Minor"

		# diminished triads contain a minor third, and diminished fifth, symbolized: R b3 b5 (or 0-3-6)
		else if(interval1 == 3 && interval2 == 6)
			triadType = "Diminished"

		# augmented triads contain a major third, and augmented fifth, symbolized: R 3 #5 (or 0-4-8)
		else if(interval1 == 4 && interval2 == 8)
			triadType = "Augmented"

		# Seventh chord identification			
		if(notes.length > 3) 
			interval3 = @rootNote.tonalDistanceAbove(notes[3])
			seventhType = "Unknown Seventh"

			# Major 7th
			if(interval3 == 11) 
				if(triadType == "Major") 
					# Major seventh is a Major Triad with a Major 7th
					seventhType = "Major Seventh"
				else if(triadType == "Minor")
					# Min-Maj seventh is a Minor Triad with a Major 7th
					seventhType = "Minor-Major Seventh"
				else if(triadType == "Augmented")
					# Augmented Major Seventh, aug triad maj 7th
					seventhType = "Augmented Major Seventh"
			# Minor 7th
			else if(interval3 == 10)
				if(triadType == "Major")
					# Major triad, minor 7th = dominant 7th
					seventhType = "Seventh"
				else if(triadType == "Minor")
					# Minor triad, minor 7th = minor 7th
					seventhType = "Minor Seventh"
				else if(triadType == "Diminished")
					# dim triad, minor 7th = half-diminished 7th
					seventhType = "Half-Diminished Seventh"
			# Diminished 7
			else if interval3 == 9
				if(triadType == "Diminshed")
					seventhType = "Diminished Seventh"

			seventhType
		else
			triadType

# A chromatic scale is used as the root, automatically jsut returns all the notes
class Scale
	constructor: (@rootNote) ->
	getNotes: (octaves = 1, direction = "asc") ->
		startIndex = allNotes.indexOf(@rootNote.tone)
		notes = [];
		numberOfNotes = octaves * allNotes.length
		currentNote = @rootNote
		while notes.length < numberOfNotes
			if(direction == "asc")
				notes.push(currentNote)
			else if(direction == "desc")
				notes.unshift(currentNote)
			else
				throw "Unrecognized direction. Use one of 'asc' or 'desc'"
			currentNote = currentNote.halfStepAbove();
		notes


	# return all diatonic triads in this scale
	getAllDiatonicTriads: (octave = @rootNote.octave) ->
		ret = []
		c = 1
		for note in this.getNotes()
			ret.push(this.getDiatonicTriad(c++, octave))
		ret

	# return all diatonic sevenths in this scale
	getAllDiatonicSevenths: (octave = @rootNote.octave) ->
		ret = []
		c = 1
		for note in this.getNotes()
			ret.push(this.getDiatonicSeventh(c++, octave))
		ret

	# return the scale tone for the given note
	getScaleToneForNote: (note) ->
		# loop over all the notes and and find the closest one
		c = 0
		notes = this.getNotes()
		minDistance = 100000
		index = -1
		matchedNote = null
		for scaleNote in notes
			c++
			distance = Math.abs(scaleNote.tonalDistanceTo(note))
			if(distance < minDistance)
				minDistance = distance
				matchedNote = scaleNote
				index = c

		distance = matchedNote.tonalDistanceTo(note)
		new ScaleTone(index, distance)

# Scale tone class which holds a numeric index and a modifier.
class ScaleTone
	constructor: (@index, @distance) ->
		@modifier = ""

		x = @distance
		while x > 0
			@modifier += "#"
			x--

		while x < 0
			@modifier += "b"
			x++

	toString: () ->
		@modifier + "" + @index
	inspect: () ->
		this.toString()

	# return the correct note for the given scale
	getNoteFromScale: (scale) ->
		notes = scale.getNotes()
		arrayIndex = @index - 1
		if(arrayIndex < 0)
			arrayIndex = notes.length + arrayIndex
		retNote = notes[arrayIndex]
		retNote.add(@distance)

# A class which creatse scales based on step patterns like WWHWWWH
class StepBasedScale extends Scale
	constructor: (@rootNote, @steps) ->
		super @rootNote

	getNotes: (octaves = 1, direction = "asc") ->
		currentNote = @rootNote
		notes = [@rootNote];
		for octave in [0...octaves]
			for step of @steps
				currentNote = if @steps[step] == "W" then currentNote.wholeStepAbove() else currentNote.halfStepAbove()
				if(direction == "asc")
					notes.push(currentNote)
				else if(direction == "desc")
					notes.unshift(currentNote)
				else
					throw "Unrecognized direction. Use one of 'asc' or 'desc'"

		# dont include the final octave note, scale shoud start at root and end at the last note before the next octave of the root.
		if(currentNote.tone == @rootNote.tone) 
			if(direction == "asc") 
				notes.pop()
			else 
				notes.shift()
		notes

	getDiatonicTriad: (scaleTone, octave = @rootNote.octave) -> 
		scaleTone -= 1
		notes = this.getNotes()
		rootNote = new Note(notes[scaleTone % notes.length].tone, octave)
		thirdNote = new Note(notes[(scaleTone + 2) % notes.length].tone, octave)
		fifthNote = new Note(notes[(scaleTone + 4) % notes.length].tone, octave)
		
		if(rootNote.distanceTo(thirdNote) < 0) 
			thirdNote.octave += 1
			fifthNote.octave += 1

		if(thirdNote.distanceTo(fifthNote) < 0)
			fifthNote.octave += 1

		new Chord(rootNote, [ rootNote, thirdNote, fifthNote ])

	# TODO: This should just call getDiatonicTriad and add the fourth note...
	getDiatonicSeventh: (scaleTone, octave = @rootNote.octave) -> 
		scaleTone -= 1
		notes = this.getNotes()
		rootNote = new Note(notes[scaleTone % notes.length].tone, octave)
		thirdNote = new Note(notes[(scaleTone + 2) % notes.length].tone, octave)
		fifthNote = new Note(notes[(scaleTone + 4) % notes.length].tone, octave)
		seventhNote = new Note(notes[(scaleTone + 6) % notes.length].tone, octave)
		
		if(rootNote.distanceTo(thirdNote) < 0) 
			thirdNote.octave += 1
			fifthNote.octave += 1
			seventhNote.octave += 1

		if(thirdNote.distanceTo(fifthNote) < 0)
			fifthNote.octave += 1
			seventhNote.octave += 1

		if(fifthNote.distanceTo(seventhNote) < 0)
			seventhNote.octave += 1

		new Chord(rootNote, [ rootNote, thirdNote, fifthNote, seventhNote ])

class MajorScale extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["W", "W", "H", "W", "W", "W", "H"]

class MinorScale extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["W", "H", "W", "W", "H", "W", "W"]

class DorianMode extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["W", "H", "W", "W", "W", "H", "W"]

class PhrygianMode extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["H", "W", "W", "W", "H", "W", "W"]

class LydianMode extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["W", "W", "W", "H", "W", "W", "H"]

class MixolydianMode extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["W", "W", "H", "W", "W", "H", "W"]

class LocrianMode extends StepBasedScale
	constructor: (@rootNote) ->
		super @rootNote, ["H", "W", "W", "H", "W", "W", "W"]

# Export everything
Note.WHOLE 		= 1.0;
Note.HALF 		= 1.0 / 2.0;
Note.QUARTER 	= 1.0 / 4.0;
Note.EIGTH		= 1.0 / 8.0;
Note.SIXTEENTH	= 1.0 / 16.0;
Note.DOTTED = (value) -> value * 1.5

(exports ? this).Note = Note
(exports ? this).Chord = Chord
(exports ? this).ScaleTone = ScaleTone
(exports ? this).Scales = {
	"Scale":Scale,
	"StepBasedScale":StepBasedScale,
	"MajorScale":MajorScale,
	"MinorScale":MinorScale,
	"DorianMode":DorianMode,
	"PhrygianMode":PhrygianMode,
	"LydianMode":LydianMode,
	"MixolydianMode":MixolydianMode,
	"LocrianMode":LocrianMode
}
