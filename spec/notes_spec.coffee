

notes = require("../src/notes")
Note = notes.Note

describe "Notes", ->

  # ----------------------------------------------------------------------
  # Test halfStepAbove
  # ----------------------------------------------------------------------
  it 'should find notes one half step above', ->
    expect((new Note("A", 3)).halfStepAbove()).toEqual(new Note("A#", 3))
    expect((new Note("C#", 3)).halfStepAbove()).toEqual(new Note("D", 3))
    expect((new Note("G", 3)).halfStepAbove()).toEqual(new Note("G#", 3))
    expect((new Note("B", 3)).halfStepAbove()).toEqual(new Note("C", 3))
    expect((new Note("E", 3)).halfStepAbove()).toEqual(new Note("F", 3))
    expect((new Note("G#", 3)).halfStepAbove()).toEqual(new Note("A", 4))

  # ----------------------------------------------------------------------
  # Test halfStepBelow
  # ----------------------------------------------------------------------
  it 'should find notes one half step below', ->
    expect((new Note("A", 3)).halfStepBelow()).toEqual(new Note("G#", 2))
    expect((new Note("C#", 3)).halfStepBelow()).toEqual(new Note("C", 3))
    expect((new Note("G", 3)).halfStepBelow()).toEqual(new Note("F#", 3))
    expect((new Note("C", 3)).halfStepBelow()).toEqual(new Note("B", 3))
    expect((new Note("F", 3)).halfStepBelow()).toEqual(new Note("E", 3))
    expect((new Note("E", 3)).halfStepBelow()).toEqual(new Note("D#", 3))

  # ----------------------------------------------------------------------
  # Test wholeStepAbove
  # ----------------------------------------------------------------------
  it 'should find notes one whole step above', ->
    expect((new Note("A", 3)).wholeStepAbove()).toEqual(new Note("B", 3))
    expect((new Note("C#", 3)).wholeStepAbove()).toEqual(new Note("D#", 3))
    expect((new Note("G", 3)).wholeStepAbove()).toEqual(new Note("A", 4))
    expect((new Note("B", 3)).wholeStepAbove()).toEqual(new Note("C#", 3))
    expect((new Note("E", 3)).wholeStepAbove()).toEqual(new Note("F#", 3))

  # ----------------------------------------------------------------------
  # Test wholeStepBelow
  # ----------------------------------------------------------------------
  it 'should find notes one whole step below', ->
    expect((new Note("A", 3)).wholeStepBelow()).toEqual(new Note("G", 2))
    expect((new Note("C#", 3)).wholeStepBelow()).toEqual(new Note("B", 3))
    expect((new Note("G", 3)).wholeStepBelow()).toEqual(new Note("F", 3))
    expect((new Note("B", 3)).wholeStepBelow()).toEqual(new Note("A", 3))
    expect((new Note("F", 3)).wholeStepBelow()).toEqual(new Note("D#", 3))
    expect((new Note("C", 3)).wholeStepBelow()).toEqual(new Note("A#", 3))

  # ----------------------------------------------------------------------
  # Test distanceTo
  # ----------------------------------------------------------------------
  it 'should find the positive distance between two notes', ->
    expect((new Note("A", 3).distanceTo(new Note("A", 4)))).toEqual(12)
    expect((new Note("A", 3).distanceTo(new Note("A", 5)))).toEqual(24)
    expect((new Note("A", 3).distanceTo(new Note("A#", 3)))).toEqual(1)
    expect((new Note("B", 3).distanceTo(new Note("C", 3)))).toEqual(1)
    expect((new Note("B", 3).distanceTo(new Note("C#", 3)))).toEqual(2)
    expect((new Note("E", 3).distanceTo(new Note("F", 3)))).toEqual(1)
    expect((new Note("E", 3).distanceTo(new Note("F#", 3)))).toEqual(2)
    expect((new Note("E", 3).distanceTo(new Note("E", 3)))).toEqual(0)

  it 'should find the negative distance between two notes', ->
    expect((new Note("F", 3).distanceTo(new Note("E", 3)))).toEqual(-1)
    expect((new Note("F#", 3).distanceTo(new Note("E", 3)))).toEqual(-2)
    expect((new Note("A", 4).distanceTo(new Note("A", 3)))).toEqual(-12)

  # ----------------------------------------------------------------------
  # Test tonalDistanceTo
  # ----------------------------------------------------------------------
  it 'should find the positive distance between two notes', ->
    expect((new Note("A", 3).tonalDistanceTo(new Note("A", 4)))).toEqual(0)
    expect((new Note("A", 3).tonalDistanceTo(new Note("A", 5)))).toEqual(0)
    expect((new Note("A", 3).tonalDistanceTo(new Note("A#", 4)))).toEqual(1)
    expect((new Note("B", 3).tonalDistanceTo(new Note("C", 3)))).toEqual(1)
    expect((new Note("B", 3).tonalDistanceTo(new Note("C#", 4)))).toEqual(2)
    expect((new Note("E", 3).tonalDistanceTo(new Note("F", 3)))).toEqual(1)
    expect((new Note("E", 3).tonalDistanceTo(new Note("F", 4)))).toEqual(1)
    expect((new Note("E", 3).tonalDistanceTo(new Note("E", 3)))).toEqual(0)

  it 'should find the negative distance between two notes', ->
    expect((new Note("F", 3).tonalDistanceTo(new Note("E", 3)))).toEqual(-1)
    expect((new Note("F#", 3).tonalDistanceTo(new Note("E", 3)))).toEqual(-2)
    expect((new Note("A", 4).tonalDistanceTo(new Note("A", 3)))).toEqual(0)

  # ----------------------------------------------------------------------
  # Test tonalDistanceAbove
  # ----------------------------------------------------------------------
  it 'should find the tonal distance to the next note above the given note', ->
    expect((new Note("G", 3).tonalDistanceAbove(new Note("B", 5)))).toEqual(4)
    expect((new Note("G", 3).tonalDistanceAbove(new Note("B", 4)))).toEqual(4)
    expect((new Note("G", 3).tonalDistanceAbove(new Note("B", 3)))).toEqual(4)
    expect((new Note("G", 3).tonalDistanceAbove(new Note("B", 2)))).toEqual(4)


  # ----------------------------------------------------------------------
  # Test add
  # ----------------------------------------------------------------------
  it 'should find the result of adding X semitones to a note', ->
    expect((new Note("A", 3)).add(2)).toEqual(new Note("B", 3));
    expect((new Note("B", 3)).add(2)).toEqual(new Note("C#", 3));
    expect((new Note("E", 3)).add(1)).toEqual(new Note("F", 3));
    expect((new Note("G", 3)).add(3)).toEqual(new Note("A#", 4));
    expect((new Note("G", 3)).add(12)).toEqual(new Note("G", 4));
