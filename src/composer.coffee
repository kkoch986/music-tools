##
# The compser is responsible for actually generating music.
##
notes = require("./notes")

desireableProgression = ["4", "7", "3", "6", "2", "5", "1"]

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
			searchSpace = desireableProgression.slice(currentPosition).concat(desireableProgression.slice(0, currentPosition))
			for s in searchSpace
				if(candidate_tones.indexOf(s) >= 0)
					ret.push candidates[candidate_tones.indexOf(s)]
					currentPosition = desireableProgression.indexOf(s) + 1
					break 

		ret



# Export everything
(exports ? this).Composer = Composer;