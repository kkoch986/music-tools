



help = require('midi-help');
midi = require('midi');
parser = new help.MidiParser();
output = new midi.output();

channel = 0;
port = 0;

try 
  console.log("port count: ", output.getPortCount());
  console.log("port name: ", output.getPortName(port));
  output.openPort(1);

  playNotes = (notes, callback = null) ->
    note = null
    nextNote = () ->
      if(notes.length != 0)
        if note
            output.sendMessage(help.noteOff(note.midiNote(), 100, channel))
        note = notes.shift()
        output.sendMessage(help.noteOn(note.midiNote(), 100, channel))
        setTimeout nextNote, 200
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
        setTimeout nextChord, 500
      else
        if callback
          callback()
    nextChord()
catch ex
  console.log("[MIDI ERROR]", ex);

(exports ? this).Midi = { "playNotes":playNotes, "playChords":playChords }