[ [ 'lpc', {arg p=64 -> [2, 64, {|val| val.round(1)}];
	LPCError.ar(\in, p);
} ], [ 'dec', {arg rate=44100 -> [10, 44100, \exp, {|val|val.round}], bits=24 -> [0, 31, {|val|val.round}];
	Decimator.ar(\in, rate, bits);
} ], [ 'wnl', {arg mix=0 -> [0,1], ratex=1.0 -> [0.0, 2.0, {|val|val.round(0.01)}], ratey=1.0 -> [0.0, 2.0, {|val|val.round(0.01)}], alpha=0.002 -> [0.002, 0.5, {|val|val.round(0.001)}];
	var sig = WeaklyNonlinear2.ar(\in, ratex, ratey, alpha);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'cod', {arg mix=0 -> [0,1], freq=0 -> [0, 10000, {|val|val.round(1)}], numharm=0 -> [0, 70, {|val|val.round(1)}];
	var sig = CrossoverDistortion.ar(\in * Blip.ar(freq, numharm));
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'log', {arg mix=0 -> [0,1], chaosParam=2.0 -> [0.0, 4.0, {|val|val.round(0.1)}];
	var freq = Pitch.kr(\in);
	var sig = Logistic.ar(chaosParam, freq:freq);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'lpc2', {arg mix=0 -> [0,1], p=64 -> [2, 64, {|val|val.round(1)}];
	var sig = LPCError.ar(\in, p);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'dec2', {arg mix=0 -> [0,1], rate=44100 -> [10, 44100, \exp, {|val|val.round}], bits=24 -> [0, 31, {|val|val.round}];
	var sig = Decimator.ar(\in, rate, bits);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'grain1', {arg impulse=10 -> [0.1, 50, {|val|val.round(0.1)}], dur=1 -> [0.0001, 0.1, {|val|val.round(0.0001)}];
	var trigger = Impulse.kr(impulse);
	GrainIn.ar(1, trigger, dur, \in);
} ] ]