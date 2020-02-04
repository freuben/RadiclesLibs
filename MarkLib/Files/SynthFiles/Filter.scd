[ [ 'lpc', {arg p=64 ;
	LPCError.ar(\in, p);
} ], [ 'dec', {arg rate=44100 , bits=24 ;
	Decimator.ar(\in, rate, bits);
} ], [ 'wnl', {arg mix=0 , ratex=1.0 , ratey=1.0 , alpha=0.002 ;
	var sig = WeaklyNonlinear2.ar(\in, ratex, ratey, alpha);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'cod', {arg mix=0 , freq=0 , numharm=0 ;
	var sig = CrossoverDistortion.ar(\in * Blip.ar(freq, numharm));
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'log', {arg mix=0 , chaosParam=2.0 ;
	var freq = Pitch.kr(\in);
	var sig = Logistic.ar(chaosParam, freq:freq);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'lpc2', {arg mix=0 , p=64 ;
	var sig = LPCError.ar(\in, p);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'dec2', {arg mix=0 , rate=44100 , bits=24 ;
	var sig = Decimator.ar(\in, rate, bits);
	((sig*mix.linlin(0, 1, 0, 1)) + (\in*mix.linlin(0, 1, 1, 0)))
} ], [ 'grain1', {arg freq=10 , dur=0.1 ;
	var trigger = Impulse.kr(freq);
	GrainIn.ar(1, trigger, dur, \in);
} ], [ 'grain2', {arg freq=10 , dur=0.1 ;
	var trigger = Dust.kr(freq);
	GrainIn.ar(1, trigger, dur, \in);
} ], [ 'grain1_stereo', {arg freq=10 , dur=0.1 ;
	var trigger;
	trigger = Impulse.kr(freq);
	GrainIn.ar(2, trigger, dur, \in);
} ], [ 'grain2_stereo', {arg freq=10 , dur=0.1 ;
	var trigger = Dust.kr(freq);
	GrainIn.ar(2, trigger, dur, \in);
} ] ]