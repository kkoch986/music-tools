

notes = require("./notes")
midi = require("./midi").Midi
composer = require("./composer")

Note = notes.Note
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

Composer = composer.Composer


# Test it out
console.log (new Note "A").wholeStepAbove()
console.log (new Note "A").wholeStepBelow()
console.log (new Note "A").halfStepAbove()
console.log (new Note "A").halfStepBelow()

# Flat Keys
console.log "F Major: " + (new MajorScale(new Note "F")).getNotes()

# C Major (no alterations)
console.log "C Major: " + (new MajorScale(new Note "C")).getNotes()

# Sharp Keys
console.log "G Major: " + (new MajorScale(new Note "G")).getNotes()
console.log "D Major: " + (new MajorScale(new Note "D")).getNotes()
console.log "A Major: " + (new MajorScale(new Note "A")).getNotes()
console.log "E Major: " + (new MajorScale(new Note "E")).getNotes()
console.log "B Major: " + (new MajorScale(new Note "B")).getNotes()
console.log "F# Major: " + (new MajorScale(new Note "F#")).getNotes()

# try out some minor scales
console.log "A Minor: " + (new MinorScale(new Note "A")).getNotes()
console.log "E Minor: " + (new MinorScale(new Note "E")).getNotes()

# some modal action
console.log "Modes:"
console.log "C Major: " + (new MajorScale(new Note "C")).getNotes()
console.log "D Dorian: " + (new DorianMode(new Note "D")).getNotes()
console.log "E Phrygian: " + (new PhrygianMode(new Note "E")).getNotes()
console.log "F Lydian: " + (new LydianMode(new Note "F")).getNotes()
console.log "G Mixolydian: " + (new MixolydianMode(new Note "G")).getNotes()
console.log "A Minor: " + (new MinorScale(new Note "A")).getNotes()
console.log "B Locrian: " + (new LocrianMode(new Note "B")).getNotes()

# Midi!
# midi.playNotes(
#   (new MajorScale(new Note "C", 3)).getNotes(1, "desc"),
#   () ->
#     midi.playNotes((new MajorScale(new Note "C", 3)).getNotes(1, "asc"))
# )

# midi.playChords(
#   (
#     new MajorScale(new Note("A", 3)).getAllDiatonicSevenths()
#   )
# );

# note distance
console.log "Distance:"
console.log (new Note("B", 1)).distanceTo(new Note("C", 1))
console.log (new Note("B", 1)).distanceTo(new Note("D", 1))

# chords.
console.log "Chords:"
console.log (new MajorScale(new Note("G", 3))).getDiatonicTriad(1)
console.log (new MajorScale(new Note("G", 3))).getDiatonicTriad(2)
console.log (new MajorScale(new Note("G", 3))).getDiatonicSeventh(1)

# scale tone identification
scale = new MajorScale(new Note("A", 3))
console.log "Scale tone for A in A Major: " + scale.getScaleToneForNote(new Note("A", 4))
console.log "Scale tone for A# in A Major: " + scale.getScaleToneForNote(new Note("A#", 4))
console.log "Scale tone for B in A Major: " + scale.getScaleToneForNote(new Note("B", 4))
console.log "Scale tone for C# in A Major: " + scale.getScaleToneForNote(new Note("C#", 4))
console.log "Scale tone for G# in A Major: " + scale.getScaleToneForNote(new Note("G#", 4))

# retrieve scale tones from different scales
scaleTone = new ScaleTone(4, 0)
scaleTone2 = new ScaleTone(6, 1)
scale1 = new MajorScale(new Note("A", 3))
scale2 = new MajorScale(new Note("C", 3))

console.log "Scale tone 4 in A Major: " + scaleTone.getNoteFromScale(scale1)
console.log "Scale tone 4 in C Major: " + scaleTone.getNoteFromScale(scale2)
console.log "Scale tone #6 in A Major: " + scaleTone2.getNoteFromScale(scale1)
console.log "Scale tone #6 in C Major: " + scaleTone2.getNoteFromScale(scale2)

# Find chords for note and key
composer = new Composer();
console.log composer.getDiatonicChordOptionsForNote(new Note("G", 3), new MajorScale(new Note("G", 3)));

melody = [ 
  new Note("G", 3, Note.HALF), 
  new Note("D", 4, Note.HALF), 
  new Note("D", 4, Note.HALF), 
  new Note("E", 3, Note.HALF), 
  new Note("G", 4, Note.DOTTED(Note.HALF)), 
  new Note("G", 4, Note.QUARTER), 
  new Note("D", 5, Note.HALF), 
  new Note("G", 4, Note.HALF),
]
scale = new MajorScale( new Note("G", 3) )
harmonized = composer.harmonize(melody, scale)

# add a nice cadence to the end V - I
harmonized.push(scale.getAllDiatonicSevenths()[4])
harmonized.push(scale.getAllDiatonicTriads(scale.rootNote.octave - 1)[0])
console.log harmonized

midi.playSequence(melody.slice(0).concat(harmonized))


