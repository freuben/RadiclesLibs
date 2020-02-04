[ [ 'pch_test1', {arg pitchRatio=1.0 , pitchDispertion=0.0 , timeDispersion=0.0001
 , winSize=0.02
 ;
		PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion)*Saw.ar;
} ], [ 'myfx', {arg volume= 0 ;
	\in * volume.dbamp;
} ] ]