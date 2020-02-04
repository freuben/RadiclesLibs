[ [ 'pch_test1', {arg pitchRatio=1.0 -> [ -12, 12, {|val| val.round(0.4).midiratio }], pitchDispertion=0.0 -> [ 0.01, 2.01, \exp, {|val| (val-0.01)} ], timeDispersion=0.0001
 -> [ 0.01, 2.01, \exp, {|val| (val-0.01)} ], winSize=0.02
 -> [ 0.01, 3 ];
		PitchShift.ar(\in, winSize, pitchRatio, pitchDispertion, timeDispersion)*Saw.ar;
} ], [ 'myfx', {arg volume= 0 -> [-20, 20];
	\in * volume.dbamp;
} ] ]