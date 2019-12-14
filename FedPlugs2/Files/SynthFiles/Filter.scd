[ [ 'pch_testfilter', {arg pitchRatio=1.0 , pitchDispertion=0.0 , timeDispersion=0.0001
 , winSize=0.02
 ;
		PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion);
} ] ]