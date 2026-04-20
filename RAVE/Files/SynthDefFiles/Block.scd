[ [ 'nntd', {arg bus=1->[1,8,{|val| val.round(1)}], amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var input, highpass, lowpass, key;
	input = SoundIn.ar(bus-1);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key, \forward).ar(lowpass) * amp;
} ], [ 'nnts', {arg bus=1->[1,8,{|val| val.round(1)}], thresh = 0.006->[0,1.0],
	time = 1.152->[0.01,2], amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp],
	hicut= 20000->[200,20000,\exp];
	var input, sig, trig, highpass, lowpass, key;
	input = SoundIn.ar(bus-1);
	trig = (input.abs > thresh);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	sig = [NN(key, \forward).ar(lowpass[0]), NN(key, \forward).ar(lowpass[1])];
	SelectX.ar(trig.lag(time), [DC.ar(0), sig]) * amp;
} ], [ 'nntds', {arg bus=1->[1,8,{|val| val.round(1)}], amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var input, highpass, lowpass, key;
	input = SoundIn.ar(bus-1);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	[NN(key, \forward).ar(lowpass[0]), NN(key, \forward).ar(lowpass[1])] * amp;
} ], [ 'nnt', {arg bus=1->[1,8,{|val| val.round(1)}], thresh = 0.006->[0,1.0],
	time = 1.152->[0.01,2], amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp],
	hicut= 20000->[200,20000,\exp];
	var input, sig, trig, highpass, lowpass, key;
	input = SoundIn.ar(bus-1);
	trig = (input.abs > thresh);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	sig = NN(key, \forward).ar(lowpass);
	SelectX.ar(trig.lag(time), [DC.ar(0), sig]) * amp;
} ] ]