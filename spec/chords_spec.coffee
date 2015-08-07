

notes = require("../src/notes")
Note = notes.Note
Chord = notes.Chord

describe "Chords", ->

	# try identifying major triads
	it 'should identify major triads', ->
    	expect( new Chord( new Note("C", 3), [ new Note("C", 3), new Note("E", 3), new Note("G", 3) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("D", 3), [ new Note("D", 3), new Note("F#", 3), new Note("A", 4) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("E", 3), [ new Note("E", 3), new Note("G#", 3), new Note("B", 4) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("F", 3), [ new Note("F", 3), new Note("A", 4), new Note("C", 4) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("G", 3), [ new Note("G", 3), new Note("B", 4), new Note("D", 4) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("A", 3), [ new Note("A", 3), new Note("C#", 3), new Note("E", 3) ] ).getType()).toBe("Major");
    	expect( new Chord( new Note("B", 3), [ new Note("B", 3), new Note("D#", 3), new Note("F#", 3) ] ).getType()).toBe("Major");

	# try identifying minor triads
	it 'should identify minor triads', ->
    	expect( new Chord( new Note("C", 3), [ new Note("C", 3), new Note("D#", 3), new Note("G", 3) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("D", 3), [ new Note("D", 3), new Note("F", 3), new Note("A", 4) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("E", 3), [ new Note("E", 3), new Note("G", 3), new Note("B", 4) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("F", 3), [ new Note("F", 3), new Note("G#", 3), new Note("C", 4) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("G", 3), [ new Note("G", 3), new Note("A#", 4), new Note("D", 4) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("A", 3), [ new Note("A", 3), new Note("C", 3), new Note("E", 3) ] ).getType()).toBe("Minor");
    	expect( new Chord( new Note("B", 3), [ new Note("B", 3), new Note("D", 3), new Note("F#", 3) ] ).getType()).toBe("Minor");

	# try identifying augmented triads
	it 'should identify augmented triads', ->
    	expect( new Chord( new Note("C", 3), [ new Note("C", 3), new Note("E", 3), new Note("G#", 3) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("D", 3), [ new Note("D", 3), new Note("F#", 3), new Note("A#", 4) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("E", 3), [ new Note("E", 3), new Note("G#", 3), new Note("C", 4) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("F", 3), [ new Note("F", 3), new Note("A", 4), new Note("C#", 4) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("G", 3), [ new Note("G", 3), new Note("B", 4), new Note("D#", 4) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("A", 3), [ new Note("A", 3), new Note("C#", 3), new Note("F", 3) ] ).getType()).toBe("Augmented");
    	expect( new Chord( new Note("B", 3), [ new Note("B", 3), new Note("D#", 3), new Note("G", 3) ] ).getType()).toBe("Augmented");

	# try identifying diminished triads
	it 'should identify diminished triads', ->
    	expect( new Chord( new Note("C", 3), [ new Note("C", 3), new Note("D#", 3), new Note("F#", 3) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("D", 3), [ new Note("D", 3), new Note("F", 3), new Note("G#", 3) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("E", 3), [ new Note("E", 3), new Note("G", 3), new Note("A#", 4) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("F", 3), [ new Note("F", 3), new Note("G#", 3), new Note("B", 4) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("G", 3), [ new Note("G", 3), new Note("A#", 4), new Note("C#", 4) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("A", 3), [ new Note("A", 3), new Note("C", 3), new Note("D#", 3) ] ).getType()).toBe("Diminished");
    	expect( new Chord( new Note("B", 3), [ new Note("B", 3), new Note("D", 3), new Note("F", 3) ] ).getType()).toBe("Diminished");