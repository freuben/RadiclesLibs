[ [ 'pch_testfilter2', {arg pitchRatio=1.0 , pitchDispertion=0.0 , timeDispersion=0.0001
 , winSize=0.02
 ;
	PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion)*SinOsc.ar;
} ], [ 'pch_testfilter3', {arg pitchRatio=1.0 , pitchDispertion=0.0 , timeDispersion=0.0001
 , winSize=0.02
 ;
		PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion);
} ], [ 'pch_testfilter4', {arg pitchRatio=1.0 , pitchDispertion=0.0 , timeDispersion=0.0001
 , winSize=0.02
 ;
		PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion);
} ] ]