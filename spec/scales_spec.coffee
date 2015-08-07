

notes = require("../src/notes")
Note = notes.Note
Chord = notes.Chord
ScaleTone = notes.ScaleTone
{
  Scale,
  MajorScale,
  DorianMode,
  MinorScale,
  PhrygianMode,
  LydianMode,
  MixolydianMode,
  LocrianMode
} = notes.Scales


describe "Scales", ->
	
	it "should generate a Chromatic scales from various roots and ranges", ->

		expect(new Scale(new Note("A", 3)).getNotes()).toEqual([
			new Note("A", 3),
			new Note("A#", 3),
			new Note("B", 3),
			new Note("C", 3),
			new Note("C#", 3),
			new Note("D", 3),
			new Note("D#", 3),
			new Note("E", 3),
			new Note("F", 3),
			new Note("F#", 3),
			new Note("G", 3),
			new Note("G#", 3)
		])

		expect(new Scale(new Note("A", 3)).getNotes(2)).toEqual([
			new Note("A", 3),
			new Note("A#", 3),
			new Note("B", 3),
			new Note("C", 3),
			new Note("C#", 3),
			new Note("D", 3),
			new Note("D#", 3),
			new Note("E", 3),
			new Note("F", 3),
			new Note("F#", 3),
			new Note("G", 3),
			new Note("G#", 3),
			new Note("A", 4),
			new Note("A#", 4),
			new Note("B", 4),
			new Note("C", 4),
			new Note("C#", 4),
			new Note("D", 4),
			new Note("D#", 4),
			new Note("E", 4),
			new Note("F", 4),
			new Note("F#", 4),
			new Note("G", 4),
			new Note("G#", 4)
		])

		expect(new Scale(new Note("C", 3)).getNotes()).toEqual([
			new Note("C", 3),
			new Note("C#", 3),
			new Note("D", 3),
			new Note("D#", 3),
			new Note("E", 3),
			new Note("F", 3),
			new Note("F#", 3),
			new Note("G", 3),
			new Note("G#", 3)
			new Note("A", 4),
			new Note("A#", 4),
			new Note("B", 4)
		])

		expect(new Scale(new Note("E", 3)).getNotes()).toEqual([
			new Note("E", 3),
			new Note("F", 3),
			new Note("F#", 3),
			new Note("G", 3),
			new Note("G#", 3)
			new Note("A", 4),
			new Note("A#", 4),
			new Note("B", 4)
			new Note("C", 4),
			new Note("C#", 4),
			new Note("D", 4),
			new Note("D#", 4),
		])

	# IONIAN
	it "should generate Major Scales", ->
		expect((new MajorScale(new Note "C", 3)).getNotes()).toEqual([
			new Note("C", 3),
			new Note("D", 3),
			new Note("E", 3),
			new Note("F", 3),
			new Note("G", 3),
			new Note("A", 4),
			new Note("B", 4)
		])

		expect((new MajorScale(new Note "C", 3)).getNotes(1, "desc")).toEqual([
			new Note("B", 4),
			new Note("A", 4),
			new Note("G", 3),
			new Note("F", 3),
			new Note("E", 3),
			new Note("D", 3),
			new Note("C", 3)
		])

		expect((new MajorScale(new Note "E", 3)).getNotes(2)).toEqual([
			new Note("E", 3),
			new Note("F#", 3),
			new Note("G#", 3),
			new Note("A", 4),
			new Note("B", 4)
			new Note("C#", 4),
			new Note("D#", 4),
			new Note("E", 4),
			new Note("F#", 4),
			new Note("G#", 4),
			new Note("A", 5),
			new Note("B", 5)
			new Note("C#", 5),
			new Note("D#", 5)
		])

	# DORIAN
	it "should generate Dorian Scales", ->
		expect((new DorianMode(new Note "C", 3)).getNotes()).toEqual([
			new Note("C", 3),
			new Note("D", 3),
			new Note("D#", 3),
			new Note("F", 3),
			new Note("G", 3),
			new Note("A", 4),
			new Note("A#", 4)
		])

		expect((new DorianMode(new Note "D", 3)).getNotes(1, "desc")).toEqual([
			new Note("C", 4)
			new Note("B", 4),
			new Note("A", 4),
			new Note("G", 3),
			new Note("F", 3),
			new Note("E", 3),
			new Note("D", 3),
		])

		expect((new DorianMode(new Note "E", 3)).getNotes(2)).toEqual([
			new Note("E", 3),
			new Note("F#", 3),
			new Note("G", 3),
			new Note("A", 4),
			new Note("B", 4)
			new Note("C#", 4),
			new Note("D", 4),
			new Note("E", 4),
			new Note("F#", 4),
			new Note("G", 4),
			new Note("A", 5),
			new Note("B", 5)
			new Note("C#", 5),
			new Note("D", 5)
		])

	# PHRYGIAN
	it "should generate Phrygian Scales", ->
		expect((new PhrygianMode(new Note "C", 3)).getNotes()).toEqual([
			new Note("C", 3),
			new Note("C#", 3),
			new Note("D#", 3),
			new Note("F", 3),
			new Note("G", 3),
			new Note("G#", 3),
			new Note("A#", 4)
		])

		expect((new PhrygianMode(new Note "D", 3)).getNotes(1, "desc")).toEqual([
			new Note("C", 4)
			new Note("A#", 4),
			new Note("A", 4),
			new Note("G", 3),
			new Note("F", 3),
			new Note("D#", 3),
			new Note("D", 3),
		])

		expect((new PhrygianMode(new Note "E", 3)).getNotes(2)).toEqual([
			new Note("E", 3),
			new Note("F", 3),
			new Note("G", 3),
			new Note("A", 4),
			new Note("B", 4)
			new Note("C", 4),
			new Note("D", 4),
			new Note("E", 4),
			new Note("F", 4),
			new Note("G", 4),
			new Note("A", 5),
			new Note("B", 5)
			new Note("C", 5),
			new Note("D", 5)
		])


	## TODO: test the rest of the modes.
	## TODO: test the diatonic triads