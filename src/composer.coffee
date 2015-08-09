##
# The compser is responsible for actually generating music.
##
notes = require("./notes")
Chord = notes.Chord

desireableProgression = ["4", "7", "3", "6", "2", "5", "1"]
# desireableProgression = ["1", "4", "5"]
# desireableProgression = ["6", "2", "5", "1"]

class Composer

	# A utility function to find the potential 
	# diatonic chords the given note would be found in 
	# for the given scale
	getDiatonicChordOptionsForNote: (note, scale) ->
		triads = scale.getAllDiatonicTriads()
		sevenths = scale.getAllDiatonicSevenths()
		results = []

		for t,triad of triads
			if(triad.toneExists(note))
				results.push(triad)

		for s,seventh of sevenths
			if(seventh.toneExists(note))
				results.push(seventh)
		
		results

	# given a sequence of notes, harmonize them
	harmonize: (notes, scale) ->
		currentPosition = desireableProgression.length - 1
		ret = []

		for n,note of notes 
			candidates = this.getDiatonicChordOptionsForNote(note, scale)
			candidate_tones = for c,candidate of candidates
				scale.getScaleToneForNote(candidate.getNotes()[0]) + ""
			
			# pick the candidate tone closest to the current position
			searchSpace = desireableProgression.slice(currentPosition).concat(desireableProgression.slice(0, currentPosition)).sort( (a,b) -> Math.random() - Math.random() )
			# TODO: fix this, we want to look at the search space in random order but still pick the closest chrod in the desired progression out of all of them.
			for s in searchSpace
				if(candidate_tones.indexOf(s) >= 0)
					console.log s
					reference = candidates[candidate_tones.indexOf(s)]
					ret.push new Chord(reference.rootNote, reference.notes, note.duration);
					currentPosition = desireableProgression.indexOf(s) + 1
					break 

		ret



# Export everything
(exports ? this).Composer = Composer;