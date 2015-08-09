

help = require('midi-help');
midi = require('midi');
parser = new help.MidiParser();
output = new midi.output();

channel = 0
port = 0
tempo_bpm = 80

compute_delay = (duration, tempo_bpm) ->
  (1.0 / (tempo_bpm / duration)) * (60.0 * 1000.0)

try 
  console.log("port count: ", output.getPortCount());
  console.log("port name: ", output.getPortName(port));
  output.openPort(port);

  playSequence = (things, callback = null) ->
    things = things.slice(0)
    current = null
    next = () ->
      if(current)
        for note in current.getNotes()
            output.sendMessage(help.noteOff(note.midiNote(), 100, channel))
      if(things.length != 0)
        current = things.shift()
        for note in current.getNotes()
          output.sendMessage(help.noteOn(note.midiNote(), 100, channel))
        setTimeout next, compute_delay(current.duration, tempo_bpm)
    next()

  playNotes = (notes, callback = null) ->
    note = null
    nextNote = () ->
      if(notes.length != 0)
        if note
            output.sendMessage(help.noteOff(note.midiNote(), 100, channel))
        note = notes.shift()
        output.sendMessage(help.noteOn(note.midiNote(), 100, channel))
        setTimeout nextNote, compute_delay(note.duration, tempo_bpm)
      else
        if callback
          callback()
    nextNote()


  playChords = (chords, callback = null) ->
    chord = null
    nextChord = () ->
      if(chords.length != 0)
        if chord
          for note in chord.getNotes()
            output.sendMessage(help.noteOff(note.midiNote(), 100, channel))
        chord = chords.shift()
        for note in chord.getNotes()
          output.sendMessage(help.noteOn(note.midiNote(), 100, channel))
        setTimeout nextChord, compute_delay(chord.duration, tempo_bpm)
      else
        if callback
          callback()
    nextChord()
catch ex
  console.log("[MIDI ERROR]", ex);

(exports ? this).Midi = { "playNotes":playNotes, "playChords":playChords , "playSequence":playSequence }