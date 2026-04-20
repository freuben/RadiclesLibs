[ [ 'nnt', {arg amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var highpass, lowpass, key;
	highpass = HPF.ar(\in,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key, \forward).ar(lowpass) * amp;
} ], [ 'nnts', {arg amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var highpass, lowpass, key;
	highpass = HPF.ar(\in,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	[NN(key, \forward).ar(lowpass[0]), NN(key, \forward).ar(lowpass[1])] * amp;
} ], [ 'nnt4D', {arg amp = 1->[0.1,2], which1=0 ->[0,1, {|val| val.round(1)}], which2=0 ->[0,1,{|val| val.round(1)}], which3=0 ->[0,1,{|val| val.round(1)}], which4=0 ->[0,1,{|val| val.round(1)}];
var input, sig, encoder, sigDim, dimSize, key;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	encoder = NN(key, \encode).ar(input);
	sigDim = [
	Select.ar(which1, [encoder[0], \sig1.ar(0,0.1)]),
	Select.ar(which2, [encoder[1], \sig2.ar(0,0.1)]),
	Select.ar(which3, [encoder[2], \sig3.ar(0,0.1)]),
	Select.ar(which4, [encoder[3], \sig4.ar(0,0.1)]),
	];
	if(dimSize > 4, {
		sig = sigDim ++ encoder.copyRange(4, dimSize-1);
	}, {
		if(dimSize < 4, {
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});
NN(key, \decode).ar(sig) * amp;
} ], [ 'nnt8D', {arg amp = 1->[0.1,2],
	which1=0 ->[0,1, {|val| val.round(1)}], which2=0 ->[0,1,{|val| val.round(1)}],
	which3=0 ->[0,1,{|val| val.round(1)}], which4=0 ->[0,1,{|val| val.round(1)}],
	which5=0 ->[0,1, {|val| val.round(1)}], which6=0 ->[0,1,{|val| val.round(1)}],
	which7=0 ->[0,1,{|val| val.round(1)}], which8=0 ->[0,1,{|val| val.round(1)}];
	var input, sig, encoder, sigDim, dimSize, key;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	encoder = NN(key, \encode).ar(input);
	sigDim = [
		Select.ar(which1, [encoder[0], \sig1.ar(0,0.1)]),
		Select.ar(which2, [encoder[1], \sig2.ar(0,0.1)]),
		Select.ar(which3, [encoder[2], \sig3.ar(0,0.1)]),
		Select.ar(which4, [encoder[3], \sig4.ar(0,0.1)]),
		Select.ar(which5, [encoder[4], \sig5.ar(0,0.1)]),
		Select.ar(which6, [encoder[5], \sig6.ar(0,0.1)]),
		Select.ar(which7, [encoder[6], \sig7.ar(0,0.1)]),
		Select.ar(which8, [encoder[7], \sig8.ar(0,0.1)]),
	];
	if(dimSize > 8, {
		sig = sigDim ++ encoder.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});
	NN(key, \decode).ar(sig) * amp;
} ], [ 'nntvg', {arg thresh = 0.006->[0,1.0], time = 1.152->[0.01,2],
	amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var input, sig, trig, highpass, lowpass, key;
	input = \in;
	trig = (input.abs > thresh);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	sig = NN(key, \forward).ar(lowpass);
	SelectX.ar(trig.lag(time), [DC.ar(0), sig]) * amp;
} ], [ 'nntvgs', {arg thresh = 0.006->[0,1.0],
	time = 1.152->[0.01,2], amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp],
	hicut= 20000->[200,20000,\exp];
	var input, sig, trig, highpass, lowpass, key;
	input = \in;
	trig = (input.abs > thresh);
	highpass = HPF.ar(input,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	sig = [NN(key, \forward).ar(lowpass[0]), NN(key, \forward).ar(lowpass[1])];
	SelectX.ar(trig.lag(time), [DC.ar(0), sig]) * amp;
} ], [ 'nntng', {arg thresh = 0.006->[0,1.0], amp = 1->[0.1,2],
	atk = 0.01->[0,0.5], rel = 0.1 -> [0.01,2],
	lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var input, noisegate, highpass, lowpass, key;
	input = \in;
	noisegate = Compander.ar(input, input, thresh, 10, 1, atk, rel);
	highpass = HPF.ar(noisegate,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key, \forward).ar(lowpass) * amp;
} ], [ 'nntngs', {arg thresh = 0.006->[0,1.0], amp = 1->[0.1,2],
	atk = 0.01->[0,0.5], rel = 0.1 -> [0.01,2],
	lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var input, noisegate, highpass, lowpass, key;
	input = \in;
	noisegate = Compander.ar(input, input, thresh, 10, 1, atk, rel);
	highpass = HPF.ar(noisegate,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	[NN(key, \forward).ar(lowpass[0]), NN(key, \forward).ar(lowpass[1])] * amp;
} ], [ 'nnt2ch', {arg amp = 1->[0.1,2], lowcut= 20->[20,2000,\exp], hicut= 20000->[200,20000,\exp];
	var highpass, lowpass, key;
	highpass = HPF.ar(\in,lowcut);
	lowpass = LPF.ar(highpass, hicut);
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key, \forward).ar(lowpass[0]) * amp;
} ], [ 'nnprior8D', {arg amp = 1->[0.1,2],
	which1=0 ->[0,1, {|val| val.round(1)}], which2=0 ->[0,1,{|val| val.round(1)}],
	which3=0 ->[0,1,{|val| val.round(1)}], which4=0 ->[0,1,{|val| val.round(1)}],
	which5=0 ->[0,1, {|val| val.round(1)}], which6=0 ->[0,1,{|val| val.round(1)}],
	which7=0 ->[0,1,{|val| val.round(1)}], which8=0 ->[0,1,{|val| val.round(1)}],
	temp=98 -> [0,100], reset=1->[0,1,{|val| val.round(1)}],
	listen=1 ->[0,1,{|val| val.round(1)}];
	var input, sig, encoder, sigDim, dimSize, key, key2, prior;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	key2 = ("prior" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	encoder = NN(key, \encode).ar(input);
	sigDim = [
		Select.ar(which1, [encoder[0], \sig1.ar(0,0.1)]),
		Select.ar(which2, [encoder[1], \sig2.ar(0,0.1)]),
		Select.ar(which3, [encoder[2], \sig3.ar(0,0.1)]),
		Select.ar(which4, [encoder[3], \sig4.ar(0,0.1)]),
		Select.ar(which5, [encoder[4], \sig5.ar(0,0.1)]),
		Select.ar(which6, [encoder[5], \sig6.ar(0,0.1)]),
		Select.ar(which7, [encoder[6], \sig7.ar(0,0.1)]),
		Select.ar(which8, [encoder[7], \sig8.ar(0,0.1)]),
	];
	if(dimSize > 8, {
		sig = sigDim ++ encoder.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});
	prior = NN(key2, \forward).ar(sig,
		attributes: [temperature: temp, reset: reset, listen: listen]);
	NN(key, \decode).ar(prior.drop(-1)) * amp;
} ], [ 'nnpriorCC_8D', {arg amp = 1->[0.1,2],
	which1=0 ->[0,1, {|val| val.round(1)}], which2=0 ->[0,1,{|val| val.round(1)}],
	which3=0 ->[0,1,{|val| val.round(1)}], which4=0 ->[0,1,{|val| val.round(1)}],
	which5=0 ->[0,1, {|val| val.round(1)}], which6=0 ->[0,1,{|val| val.round(1)}],
	which7=0 ->[0,1,{|val| val.round(1)}], which8=1 ->[0,1,{|val| val.round(1)}],
	sig8=98 -> [0,100], reset=1->[0,1,{|val| val.round(1)}];
	var input, sig, encoder, sigDim, dimSize, key, key2, prior;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	key2 = ("prior" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	encoder = NN(key, \encode).ar(input);
	sigDim = [
		Select.ar(which1, [encoder[0], \sig1.ar(0,0.1)]),
		Select.ar(which2, [encoder[1], \sig2.ar(0,0.1)]),
		Select.ar(which3, [encoder[2], \sig3.ar(0,0.1)]),
		Select.ar(which4, [encoder[3], \sig4.ar(0,0.1)]),
		Select.ar(which5, [encoder[4], \sig5.ar(0,0.1)]),
		Select.ar(which6, [encoder[5], \sig6.ar(0,0.1)]),
		Select.ar(which7, [encoder[6], \sig7.ar(0,0.1)]),
		Select.ar(which8, [encoder[7], encoder[7]]),
	];
	if(dimSize > 8, {
		sig = sigDim ++ encoder.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});
	prior = NN(key2, \forward).ar(sig,
		attributes: [temperature: sig8, reset: reset, listen: which8]);
	NN(key, \decode).ar(prior.drop(-1)) * amp;
} ], [ 'nntImprov', {arg lowCut=20 ->[20,20000, \exp],
	hiCut=20000 ->[20,20000, \exp], preVol= 0 ->[ 0, 24, \db, 0, -inf,  "dB" ],
	cpthresh= -20 ->[ -60, 0, \db, 0, -inf,  "dB" ], ratio=1 ->[1,6],
	cpatk=0.01 ->[0.001,0.1], cprel=0.01 -> [0.001,0.1], transp=0 ->[-24,24,{|val| val.round(0.5)}],
	disper=0 ->[0,0.1], postVol= 0 ->[ -24, 24], amp= 1->[0.1,2], pan= 0 ->[-1,1],
	which1=0 ->[0,3, {|val| val.round(1)}], which2=0 ->[0,3,{|val| val.round(1)}],
	which3=0 ->[0,3,{|val| val.round(1)}], which4=0 ->[0,3,{|val| val.round(1)}],
	which5=0 ->[0,3, {|val| val.round(1)}], which6=0 ->[0,3,{|val| val.round(1)}],
	which7=0 ->[0,3,{|val| val.round(1)}], which8=0 ->[0,3,{|val| val.round(1)}],
	dryDim = 1 -> [0,1], wetDim = 0 -> [0,1],
	mulSpace= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpace= 0 -> [-6,6],
	mul1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul7 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul8 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	add1= 0 -> [-6,6], add2= 0 -> [-6,6], add3= 0 -> [-6,6], add4= 0 -> [-6,6],
	add5= 0 -> [-6,6], add6= 0 -> [-6,6], add7= 0 -> [-6,6], add8= 0 -> [-6,6],
		modWhich1 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich2 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich3 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich4 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich5 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich6 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich7 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich8 = 0 -> [0,4,{|val| val.round(1)}],
	modFreq1 = 23 -> [0.01,85], modFreq2 = 23 -> [0.01,85],
	modFreq3 = 23 -> [0.01,85], modFreq4 = 23 -> [0.01,85],
	modFreq5 = 23 -> [0.01,85], modFreq6 = 23 -> [0.01,85],
	modFreq7 = 23 -> [0.01,85], modFreq8 = 23 -> [0.01,85],
	min1 = -3 -> [-6,6], min2 = -3 -> [-6,6], min3 = -3 -> [-6,6],
	min4 = -3 -> [-6,6], min5 = -3 -> [-6,6], min6 = -3 -> [-6,6],
	min7 = -3 -> [-6,6], min8 = -3 -> [-6,6],
	max1 = 3 -> [-6,6], max2 = 3 -> [-6,6], max3 = 3 -> [-6,6],
	max4 = 3 -> [-6,6], max5 = 3 -> [-6,6], max6 = 3 -> [-6,6],
	max7 = 3 -> [-6,6], max8 = 3 -> [-6,6],
	whichMix = 0 -> [0,1, {|val| val.round(1)}],
	gainDel=0 -> [ -inf, 0, \db, 0, -inf,  "dB" ],
	dryDelGain = -inf -> [ -inf, 6, \db, 0, -inf,  "dB" ],
	dryDelay = 0.683 -> [0,1.5];
	var input, sig, encoder, sigDim, dimSize, key, fxchain, modDim,
	postEncode, postModDim, postSum, decoder, mulArr, dryDel, decoderMix;

	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = Mix(\in);
	//fx chain
	fxchain = input * (preVol.dbamp.lag(0.01));
	fxchain = LPF.ar(fxchain, hiCut);
	fxchain = HPF.ar(fxchain, lowCut);
	fxchain = Compander.ar(fxchain, fxchain,
        thresh: cpthresh.dbamp,
        slopeBelow: 1,
        slopeAbove: 1/ratio,
        clampTime:  cpatk,
        relaxTime:  cprel
    );
	fxchain = PitchShift.ar(fxchain, 0.2, transp.midiratio,disper);
	//fx chain

	mul1 = mul1.dbamp + add1;
	mul2 = mul2.dbamp + add2;
	mul3 = mul3.dbamp + add3;
	mul4 = mul4.dbamp + add4;
	mul5 = mul5.dbamp + add5;
	mul6 = mul6.dbamp + add6;
	mul7 = mul7.dbamp + add7;
	mul8 = mul8.dbamp + add8;

	mulArr = [mul1, mul2, mul3, mul4, mul5, mul6, mul7, mul8];

	modDim = [
		Select.ar(modWhich1, [LFNoise1.ar(modFreq1), SinOsc.ar(modFreq1), LFTri.ar(modFreq1), LFSaw.ar(modFreq1), LFPulse.ar(modFreq1)]).range(min1, max1),
	Select.ar(modWhich2, [LFNoise1.ar(modFreq2), SinOsc.ar(modFreq2), LFTri.ar(modFreq2), LFSaw.ar(modFreq2), LFPulse.ar(modFreq2)]).range(min2, max2),
	Select.ar(modWhich3, [LFNoise1.ar(modFreq3), SinOsc.ar(modFreq3), LFTri.ar(modFreq3), LFSaw.ar(modFreq3), LFPulse.ar(modFreq3) ]).range(min3, max3),
	Select.ar(modWhich4, [LFNoise1.ar(modFreq4), SinOsc.ar(modFreq4), LFTri.ar(modFreq4), LFSaw.ar(modFreq4), LFPulse.ar(modFreq4) ]).range(min4, max4),
	Select.ar(modWhich5, [LFNoise1.ar(modFreq5), SinOsc.ar(modFreq5), LFTri.ar(modFreq5), LFSaw.ar(modFreq5), LFPulse.ar(modFreq5) ]).range(min5, max5),
	Select.ar(modWhich6, [LFNoise1.ar(modFreq6), SinOsc.ar(modFreq6), LFTri.ar(modFreq6), LFSaw.ar(modFreq6), LFPulse.ar(modFreq6) ]).range(min6, max6),
	Select.ar(modWhich7, [LFNoise1.ar(modFreq7), SinOsc.ar(modFreq7), LFTri.ar(modFreq7), LFSaw.ar(modFreq7), LFPulse.ar(modFreq7) ]).range(min7, max7),
	Select.ar(modWhich8, [LFNoise1.ar(modFreq8), SinOsc.ar(modFreq8), LFTri.ar(modFreq8), LFSaw.ar(modFreq8), LFPulse.ar(modFreq8) ]).range(min8, max8),
	];

	encoder = NN(key, \encode).ar(fxchain);
	/*encoder = encoder * mulSpace.dbamp + addSpace;*/

	postEncode = encoder * dryDim;
	postModDim = modDim * wetDim;
	postSum = postEncode + postModDim;

	sigDim = [
		Select.ar(which1, [encoder[0], postSum[0], \sig1.ar(0,0.1), modDim[0]]),
		Select.ar(which2, [encoder[1], postSum[1], \sig2.ar(0,0.1), modDim[1]]),
		Select.ar(which3, [encoder[2], postSum[2], \sig3.ar(0,0.1), modDim[2]]),
		Select.ar(which4, [encoder[3], postSum[3], \sig4.ar(0,0.1), modDim[3]]),
		Select.ar(which5, [encoder[4], postSum[4], \sig5.ar(0,0.1), modDim[4]]),
		Select.ar(which6, [encoder[5], postSum[5], \sig6.ar(0,0.1), modDim[5]]),
		Select.ar(which7, [encoder[6], postSum[6], \sig7.ar(0,0.1), modDim[6]]),
		Select.ar(which8, [encoder[7], postSum[7], \sig8.ar(0,0.1), modDim[7]])
	];
	if(dimSize > 8, {
		sigDim = sigDim*mulArr;
		sig = sigDim ++ encoder.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sigDim = sigDim*mulArr;
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});

	sig = sig * mulSpace.dbamp + addSpace;
	decoder = NN(key, \decode).ar(sig);

	dryDel = DelayL.ar(input * dryDelGain.dbamp, 1, dryDelay);

	decoderMix = decoder * gainDel.dbamp + dryDel ;
	decoderMix = decoderMix * amp * (postVol.dbamp.lag(0.01));
	decoderMix = Select.ar(whichMix, [decoderMix, input]);

	Pan2.ar(decoderMix, pan);
} ], [ 'nntImprovOld', {arg lowCut=20 ->[20,20000, \exp],
	hiCut=20000 ->[20,20000, \exp], preVol=0 ->[ 0, 24, \db, 0, -inf,  "dB" ],
	cpthresh= -20 ->[ -60, 0, \db, 0, -inf,  "dB" ], ratio=1 ->[1,6],
	cpatk=0.01 ->[0.001,0.1], cprel=0.01 -> [0.001,0.1], transp=0 ->[-24,24,{|val| val.round(0.5)}],
	disper=0 ->[0,0.1], postVol=0 ->[ -24, 24], amp= 1->[0.1,2],
	which1=0 ->[0,1, {|val| val.round(1)}], which2=0 ->[0,1,{|val| val.round(1)}],
	which3=0 ->[0,1,{|val| val.round(1)}], which4=0 ->[0,1,{|val| val.round(1)}],
	which5=0 ->[0,1, {|val| val.round(1)}], which6=0 ->[0,1,{|val| val.round(1)}],
	which7=0 ->[0,1,{|val| val.round(1)}], which8=0 ->[0,1,{|val| val.round(1)}];
	var input, sig, encoder, sigDim, dimSize, key, fxchain;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	//fx chain
	fxchain = input * (preVol.dbamp.lag(0.01));
	fxchain = LPF.ar(fxchain, hiCut);
	fxchain = HPF.ar(fxchain, lowCut);
	fxchain = Compander.ar(fxchain, fxchain,
        thresh: cpthresh.dbamp,
        slopeBelow: 1,
        slopeAbove: 1/ratio,
        clampTime:  cpatk,
        relaxTime:  cprel
    );
	fxchain = PitchShift.ar(fxchain, 0.2, transp.midiratio,disper);
	//fx chain
	encoder = NN(key, \encode).ar(fxchain);
	sigDim = [
		Select.ar(which1, [encoder[0], \sig1.ar(0,0.1)]),
		Select.ar(which2, [encoder[1], \sig2.ar(0,0.1)]),
		Select.ar(which3, [encoder[2], \sig3.ar(0,0.1)]),
		Select.ar(which4, [encoder[3], \sig4.ar(0,0.1)]),
		Select.ar(which5, [encoder[4], \sig5.ar(0,0.1)]),
		Select.ar(which6, [encoder[5], \sig6.ar(0,0.1)]),
		Select.ar(which7, [encoder[6], \sig7.ar(0,0.1)]),
		Select.ar(which8, [encoder[7], \sig8.ar(0,0.1)]),
	];
	if(dimSize > 8, {
		sig = sigDim ++ encoder.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sig = sigDim.copyRange(0, dimSize-1);
		}, {
			sig = sigDim;
		});
	});
	NN(key, \decode).ar(sig) * amp * (postVol.dbamp.lag(0.01));
} ], [ 'nntImprov2', {arg lowCut=20 ->[20,20000, \exp],
	hiCut=20000 ->[20,20000, \exp], preVol=0 ->[ 0, 24, \db, 0, -inf,  "dB" ],
	cpthresh= -20 ->[ -60, 0, \db, 0, -inf,  "dB" ], ratio=1 ->[1,6],
	cpatk=0.01 ->[0.001,0.1], cprel=0.01 -> [0.001,0.1], transp=0 ->[-24,24,{|val| val.round(0.5)}],
	disper=0 ->[0,0.1], postVol= 0 ->[ -24, 24], amp= 1->[0.1,2],
	which1=0 ->[0,3, {|val| val.round(1)}], which2=0 ->[0,3,{|val| val.round(1)}],
	which3=0 ->[0,3,{|val| val.round(1)}], which4=0 ->[0,3,{|val| val.round(1)}],
	which5=0 ->[0,3, {|val| val.round(1)}], which6=0 ->[0,3,{|val| val.round(1)}],
	which7=0 ->[0,3,{|val| val.round(1)}], which8=0 ->[0,3,{|val| val.round(1)}],
	dryDim = 1 -> [0,1], wetDim = 0 -> [0,1],
	mulSpace= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpace= 0 -> [-6,6,{|val| val.round(0.1)}],
	mul1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul7 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	mul8 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
	add1= 0 -> [-6,6], add2= 0 -> [-6,6], add3= 0 -> [-6,6], add4= 0 -> [-6,6],
	add5= 0 -> [-6,6], add6= 0 -> [-6,6], add7= 0 -> [-6,6], add8= 0 -> [-6,6],
	modWhich1 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich2 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich3 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich4 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich5 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich6 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich7 = 0 -> [0,4,{|val| val.round(1)}],
	modWhich8 = 0 -> [0,4,{|val| val.round(1)}],
	modFreq1 = 23 -> [0.01,85], modFreq2 = 23 -> [0.01,85],
	modFreq3 = 23 -> [0.01,85], modFreq4 = 23 -> [0.01,85],
	modFreq5 = 23 -> [0.01,85], modFreq6 = 23 -> [0.01,85],
	modFreq7 = 23 -> [0.01,85], modFreq8 = 23 -> [0.01,85],
	min1 = -3 -> [-6,6], min2 = -3 -> [-6,6], min3 = -3 -> [-6,6],
	min4 = -3 -> [-6,6], min5 = -3 -> [-6,6], min6 = -3 -> [-6,6],
	min7 = -3 -> [-6,6], min8 = -3 -> [-6,6],
	max1 = 3 -> [-6,6], max2 = 3 -> [-6,6], max3 = 3 -> [-6,6],
	max4 = 3 -> [-6,6], max5 = 3 -> [-6,6], max6 = 3 -> [-6,6],
	max7 = 3 -> [-6,6], max8 = 3 -> [-6,6],
	whichMix = 0 -> [0,1, {|val| val.round(1)}],
	gainDel=0 -> [ -inf, 0, \db, 0, -inf,  "dB" ],
	dryDelGain = -inf -> [ -inf, 0, \db, 0, -inf,  "dB" ],
	dryDelay = 0.683 -> [0,1.5];
	var input, sigL, sigR, encoderL, encoderR, sigDimL, sigDimR, dimSize,
	key, fxchain, modDim, postEncodeL, postEncodeR, postModDim, postSumL,
	postSumR, decoderL, decoderR, mulArr, dry, dryDel, decoderMix;
	key = ("rave" ++ Radicles.modelNum).asSymbol;
	NN(key).methods.do{|item| if(item.name == \encode, {dimSize = item.numOutputs}) };
	input = \in;
	//fx chain
	fxchain = input * (preVol.dbamp.lag(0.01));
	fxchain = LPF.ar(fxchain, hiCut);
	fxchain = HPF.ar(fxchain, lowCut);
	fxchain = Compander.ar(fxchain, fxchain,
        thresh: cpthresh.dbamp,
        slopeBelow: 1,
        slopeAbove: 1/ratio,
        clampTime:  cpatk,
        relaxTime:  cprel
    );
	fxchain = PitchShift.ar(fxchain, 0.2, transp.midiratio,disper);
	//fx chain

	mul1 = mul1.dbamp + add1;
	mul2 = mul2.dbamp + add2;
	mul3 = mul3.dbamp + add3;
	mul4 = mul4.dbamp + add4;
	mul5 = mul5.dbamp + add5;
	mul6 = mul6.dbamp + add6;
	mul7 = mul7.dbamp + add7;
	mul8 = mul8.dbamp + add8;

	mulArr = [mul1, mul2, mul3, mul4, mul5, mul6, mul7, mul8];

	modDim = [
		Select.ar(modWhich1, [LFNoise1.ar(modFreq1), SinOsc.ar(modFreq1), LFTri.ar(modFreq1), LFSaw.ar(modFreq1), LFPulse.ar(modFreq1)]).range(min1, max1),
	Select.ar(modWhich2, [LFNoise1.ar(modFreq2), SinOsc.ar(modFreq2), LFTri.ar(modFreq2), LFSaw.ar(modFreq2), LFPulse.ar(modFreq2)]).range(min2, max2),
	Select.ar(modWhich3, [LFNoise1.ar(modFreq3), SinOsc.ar(modFreq3), LFTri.ar(modFreq3), LFSaw.ar(modFreq3), LFPulse.ar(modFreq3) ]).range(min3, max3),
	Select.ar(modWhich4, [LFNoise1.ar(modFreq4), SinOsc.ar(modFreq4), LFTri.ar(modFreq4), LFSaw.ar(modFreq4), LFPulse.ar(modFreq4) ]).range(min4, max4),
	Select.ar(modWhich5, [LFNoise1.ar(modFreq5), SinOsc.ar(modFreq5), LFTri.ar(modFreq5), LFSaw.ar(modFreq5), LFPulse.ar(modFreq5) ]).range(min5, max5),
	Select.ar(modWhich6, [LFNoise1.ar(modFreq6), SinOsc.ar(modFreq6), LFTri.ar(modFreq6), LFSaw.ar(modFreq6), LFPulse.ar(modFreq6) ]).range(min6, max6),
	Select.ar(modWhich7, [LFNoise1.ar(modFreq7), SinOsc.ar(modFreq7), LFTri.ar(modFreq7), LFSaw.ar(modFreq7), LFPulse.ar(modFreq7) ]).range(min7, max7),
	Select.ar(modWhich8, [LFNoise1.ar(modFreq8), SinOsc.ar(modFreq8), LFTri.ar(modFreq8), LFSaw.ar(modFreq8), LFPulse.ar(modFreq8) ]).range(min8, max8),
	];

	encoderL = NN(key, \encode).ar(fxchain[0]);
	encoderR = NN(key, \encode).ar(fxchain[1]);

/*	encoderL = encoderL * mulSpace.dbamp + addSpace;
	encoderR = encoderR * mulSpace.dbamp + addSpace;*/

	postEncodeL = encoderL * dryDim;
	postEncodeR = encoderR * dryDim;

	postModDim = modDim * wetDim;

	postSumL = postEncodeL + postModDim;
	postSumR = postEncodeR + postModDim;

	sigDimL = [
		Select.ar(which1, [encoderL[0], postSumL[0], \sig1.ar(0,0.1), modDim[0]]),
		Select.ar(which2, [encoderL[1], postSumL[1], \sig2.ar(0,0.1), modDim[1]]),
		Select.ar(which3, [encoderL[2], postSumL[2], \sig3.ar(0,0.1), modDim[2]]),
		Select.ar(which4, [encoderL[3], postSumL[3], \sig4.ar(0,0.1), modDim[3]]),
		Select.ar(which5, [encoderL[4], postSumL[4], \sig5.ar(0,0.1), modDim[4]]),
		Select.ar(which6, [encoderL[5], postSumL[5], \sig6.ar(0,0.1), modDim[5]]),
		Select.ar(which7, [encoderL[6], postSumL[6], \sig7.ar(0,0.1), modDim[6]]),
		Select.ar(which8, [encoderL[7], postSumL[7], \sig8.ar(0,0.1), modDim[7]])
	];
	if(dimSize > 8, {
		sigDimL = sigDimL*mulArr;
		sigL = sigDimL ++ encoderL.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sigDimL = sigDimL*mulArr;
			sigL = sigDimL.copyRange(0, dimSize-1);
		}, {
			sigL = sigDimL;
		});
	});

	sigDimR = [
		Select.ar(which1, [encoderR[0], postSumR[0], \sig1.ar(0,0.1), modDim[0]]),
		Select.ar(which2, [encoderR[1], postSumR[1], \sig2.ar(0,0.1), modDim[1]]),
		Select.ar(which3, [encoderR[2], postSumR[2], \sig3.ar(0,0.1), modDim[2]]),
		Select.ar(which4, [encoderR[3], postSumR[3], \sig4.ar(0,0.1), modDim[3]]),
		Select.ar(which5, [encoderR[4], postSumR[4], \sig5.ar(0,0.1), modDim[4]]),
		Select.ar(which6, [encoderR[5], postSumR[5], \sig6.ar(0,0.1), modDim[5]]),
		Select.ar(which7, [encoderR[6], postSumR[6], \sig7.ar(0,0.1), modDim[6]]),
		Select.ar(which8, [encoderR[7], postSumR[7], \sig8.ar(0,0.1), modDim[7]])
	];
	if(dimSize > 8, {
		sigDimR = sigDimR*mulArr;
		sigR = sigDimR ++ encoderR.copyRange(8, dimSize-1);
	}, {
		if(dimSize < 8, {
			sigDimR = sigDimR*mulArr;
			sigR = sigDimR.copyRange(0, dimSize-1);
		}, {
			sigR = sigDimR;
		});
	});

	sigL = sigL * mulSpace.dbamp + addSpace;
	sigR = sigR * mulSpace.dbamp + addSpace;

	decoderL = NN(key, \decode).ar(sigL);
	decoderR = NN(key, \decode).ar(sigR);

/*	dry = input * dryGain.dbamp;*/

	dryDel = DelayL.ar(input * dryDelGain.dbamp, 1, dryDelay);

	decoderMix = [decoderL, decoderR] * gainDel.dbamp + dryDel ;
	decoderMix = decoderMix * amp * (postVol.dbamp.lag(0.01));
	decoderMix = Select.ar(whichMix, [decoderMix, input]);

	/** gain.dbamp * gainDel.dbamp + dry ;*/
} ], [ 'afterImprov', {arg lowCut=20 ->[20,20000, \exp],
hiCut=20000 ->[20,20000, \exp], preVol= 0 ->[ 0, 24, \db, 0, -inf,  "dB" ],
cpthresh= -20 ->[ -60, 0, \db, 0, -inf,  "dB" ], ratio=1 ->[1,6],
cpatk=0.01 ->[0.001,0.1], cprel=0.01 -> [0.001,0.1], transp=0 ->[-24,24,{|val| val.round(0.5)}],
disper=0 ->[0,0.1], postVol= 0 ->[ -24, 24], amp= 1->[0.1,2], pan= 0 ->[-1,1],
whichTimbre=0 ->[0,2, {|val| val.round(1)}],
whichStructure=0 ->[0,2, {|val| val.round(1)}],
snap = 1 -> [0,1, {|val| val.round(1)}],
gstructure=1 -> [0,5, {|val| val.round(0.1)}],
gtimbre=1-> [0,3, {|val| val.round(0.01)}],
steps=4-> [1,16, {|val| val.round(1)}],
which1=0 ->[0,3, {|val| val.round(1)}], which2=0 ->[0,3,{|val| val.round(1)}],
which3=0 ->[0,3,{|val| val.round(1)}], which4=0 ->[0,3,{|val| val.round(1)}],
which5=0 ->[0,3, {|val| val.round(1)}], which6=0 ->[0,3,{|val| val.round(1)}],
whichS1=0 ->[0,3, {|val| val.round(1)}], whichS2=0 ->[0,3,{|val| val.round(1)}],
whichS3=0 ->[0,3,{|val| val.round(1)}], whichS4=0 ->[0,3,{|val| val.round(1)}],
whichS5=0 ->[0,3, {|val| val.round(1)}], whichS6=0 ->[0,3,{|val| val.round(1)}],
whichS7=0 ->[0,3, {|val| val.round(1)}], whichS8=0 ->[0,3,{|val| val.round(1)}],
whichS9=0 ->[0,3,{|val| val.round(1)}], whichS10=0 ->[0,3,{|val| val.round(1)}],
whichS11=0 ->[0,3, {|val| val.round(1)}], whichS12=0 ->[0,3,{|val| val.round(1)}],
dryDim = 1 -> [0,1], wetDim = 0 -> [0,1],
mulSpace= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpace= 0 -> [-6,6],
dryDimS = 1 -> [0,1], wetDimS = 0 -> [0,1],
mulSpaceS= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpaceS= 0 -> [-6,6],
mul1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS7 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS8 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS9 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS10 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS11 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS12 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
add1= 0 -> [-3,3], add2= 0 -> [-3,3], add3= 0 -> [-3,3],
add4= 0 -> [-3,3], add5= 0 -> [-3,3], add6= 0 -> [-3,3],
addS1= 0 -> [-3,3], addS2= 0 -> [-3,3], addS3= 0 -> [-3,3],
addS4= 0 -> [-3,3], addS5= 0 -> [-3,3], addS6= 0 -> [-3,3],
addS7= 0 -> [-3,3], addS8= 0 -> [-3,3], addS9= 0 -> [-3,3],
addS10= 0 -> [-3,3], addS11= 0 -> [-3,3], addS12= 0 -> [-3,3],
modWhich1 = 0 -> [0,4,{|val| val.round(1)}],
modWhich2 = 0 -> [0,4,{|val| val.round(1)}],
modWhich3 = 0 -> [0,4,{|val| val.round(1)}],
modWhich4 = 0 -> [0,4,{|val| val.round(1)}],
modWhich5 = 0 -> [0,4,{|val| val.round(1)}],
modWhich6 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS1 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS2 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS3 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS4 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS5 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS6 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS7 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS8 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS9 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS10 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS11 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS12 = 0 -> [0,4,{|val| val.round(1)}],
modFreq1 = 23 -> [0.01,85], modFreq2 = 23 -> [0.01,85],
modFreq3 = 23 -> [0.01,85], modFreq4 = 23 -> [0.01,85],
modFreq5 = 23 -> [0.01,85], modFreq6 = 23 -> [0.01,85],
modFreqS1 = 23 -> [0.01,85], modFreqS2 = 23 -> [0.01,85],
modFreqS3 = 23 -> [0.01,85], modFreqS4 = 23 -> [0.01,85],
modFreqS5 = 23 -> [0.01,85], modFreqS6 = 23 -> [0.01,85],
modFreqS7 = 23 -> [0.01,85], modFreqS8 = 23 -> [0.01,85],
modFreqS9 = 23 -> [0.01,85], modFreqS10 = 23 -> [0.01,85],
modFreqS11 = 23 -> [0.01,85], modFreqS12 = 23 -> [0.01,85],
min1 = -1 -> [-3,3], min2 = -1 -> [-3,3], min3 = -1 -> [-3,3],
min4 = -1 -> [-3,3], min5 = -1 -> [-3,3], min6 = -1 -> [-3,3],
minS1 = -1 -> [-1,1], minS2 = -1 -> [-1,1], minS3 = -1 -> [-1,1],
minS4 = -1 -> [-1,1], minS5 = -1 -> [-1,1], minS6 = -1 -> [-1,1],
minS7 = -1 -> [-1,1], minS8 = -1 -> [-1,1], minS9 = -1 -> [-1,1],
minS10 = -1 -> [-1,1], minS11 = -1 -> [-1,1], minS12 = -1 -> [-1,1],
max1 = 1 -> [-3,3], max2 = 1 -> [-3,3], max3 = 1 -> [-3,3],
max4 = 1 -> [-3,3], max5 = 1 -> [-3,3], max6 = 1 -> [-3,3],
maxS1 = 1 -> [-1,1], maxS2 = 1 -> [-1,1], maxS3 = 1 -> [-1,1],
maxS4 = 1 -> [-1,1], maxS5 = 1 -> [-1,1], maxS6 = 1 -> [-1,1],
maxS7 = 1 -> [-1,1], maxS8 = 1 -> [-1,1], maxS9 = 1 -> [-1,1],
maxS10 = 1 -> [-1,1], maxS11 = 1 -> [-1,1], maxS12 = 1 -> [-1,1],
whichMix = 0 -> [0,1, {|val| val.round(1)}],
gainDel=0 -> [ -inf, 0, \db, 0, -inf,  "dB" ],
dryDelGain = -inf -> [ -inf, 6, \db, 0, -inf,  "dB" ],
dryDelay = 2.299 -> [0,4], lagTime = 0.3 -> [0,2];

var input, sig, sigS, encoder, sigDim, sigDimS, dimSize, dimSizeS, key,
fxchain, modDim, postEncode, postEncodeS, postModDim, postModDimS,
postSum, postSumS, decoder, mulArr, mulArrS, dryDel, dryDelS, decoderMix,
structure, diffuse, blockSize, sigTimbre, sigStructure, modDimS, inputT, inputS;

key = ("after" ++ Radicles.modelNum).asSymbol;
NN(key).methods.do{|item| if(item.name == \timbre, {
dimSize = item.numOutputs}) };
NN(key).methods.do{|item| if(item.name == \structure, {
dimSizeS = item.numOutputs}) };
blockSize = 8192;
input = Mix(\in);
inputT = Select.ar(whichTimbre,
[\in, Ndef.ar('spaceTrack9', 2), Ndef.ar('spaceTrack10', 2)]);
inputS = Select.ar(whichStructure,
[\in, Ndef.ar('spaceTrack9', 2), Ndef.ar('spaceTrack10', 2)]);
//fx chain
fxchain = [Mix(inputT), Mix(inputS)] * (preVol.dbamp.lag(0.01));
fxchain = LPF.ar(fxchain, hiCut);
fxchain = HPF.ar(fxchain, lowCut);
fxchain = Compander.ar(fxchain, fxchain,
thresh: cpthresh.dbamp,
slopeBelow: 1,
slopeAbove: 1/ratio,
clampTime:  cpatk,
relaxTime:  cprel
);
fxchain = PitchShift.ar(fxchain, 0.2, transp.midiratio,disper);

//fx chain

mul1 = mul1.dbamp + add1;
mul2 = mul2.dbamp + add2;
mul3 = mul3.dbamp + add3;
mul4 = mul4.dbamp + add4;
mul5 = mul5.dbamp + add5;
mul6 = mul6.dbamp + add6;

mulArr = [mul1, mul2, mul3, mul4, mul5, mul6];

mulS1 = mulS1.dbamp + addS1;
mulS2 = mulS2.dbamp + addS2;
mulS3 = mulS3.dbamp + addS3;
mulS4 = mulS4.dbamp + addS4;
mulS5 = mulS5.dbamp + addS5;
mulS6 = mulS6.dbamp + addS6;
mulS7 = mulS7.dbamp + addS7;
mulS8 = mulS8.dbamp + addS8;
mulS9 = mulS9.dbamp + addS9;
mulS10 = mulS10.dbamp + addS10;
mulS11 = mulS11.dbamp + addS11;
mulS12 = mulS12.dbamp + addS12;

mulArrS = [mulS1, mulS2, mulS3, mulS4, mulS5, mulS6,
mulS7, mulS8, mulS9, mulS10, mulS11, mulS12];

modDim = [
Select.ar(modWhich1, [
LFNoise1.ar(modFreq1),
SinOsc.ar(modFreq1),
LFTri.ar(modFreq1),
LFSaw.ar(modFreq1),
LFPulse.ar(modFreq1)]).range(min1, max1),

Select.ar(modWhich2, [
LFNoise1.ar(modFreq2),
SinOsc.ar(modFreq2),
LFTri.ar(modFreq2),
LFSaw.ar(modFreq2),
LFPulse.ar(modFreq2)]).range(min2, max2),

Select.ar(modWhich3, [
LFNoise1.ar(modFreq3),
SinOsc.ar(modFreq3),
LFTri.ar(modFreq3),
LFSaw.ar(modFreq3),
LFPulse.ar(modFreq3) ]).range(min3, max3),

Select.ar(modWhich4, [
LFNoise1.ar(modFreq4),
SinOsc.ar(modFreq4),
LFTri.ar(modFreq4),
LFSaw.ar(modFreq4),
LFPulse.ar(modFreq4) ]).range(min4, max4),

Select.ar(modWhich5, [
LFNoise1.ar(modFreq5),
SinOsc.ar(modFreq5),
LFTri.ar(modFreq5),
LFSaw.ar(modFreq5),
LFPulse.ar(modFreq5) ]).range(min5, max5),

Select.ar(modWhich6, [
LFNoise1.ar(modFreq6),
SinOsc.ar(modFreq6),
LFTri.ar(modFreq6),
LFSaw.ar(modFreq6),
LFPulse.ar(modFreq6) ]).range(min6, max6),
];

modDimS = [
Select.ar(modWhichS1.lag(lagTime), [
LFNoise1.ar(modFreqS1.lag(lagTime)),
SinOsc.ar(modFreqS1.lag(lagTime)),
LFTri.ar(modFreqS1.lag(lagTime)),
LFSaw.ar(modFreqS1.lag(lagTime)),
LFPulse.ar(modFreqS1.lag(lagTime))
]).range(minS1.lag(lagTime), maxS1.lag(lagTime)),

Select.ar(modWhichS2.lag(lagTime), [
LFNoise1.ar(modFreqS2.lag(lagTime)),
SinOsc.ar(modFreqS2.lag(lagTime)),
LFTri.ar(modFreqS2.lag(lagTime)),
LFSaw.ar(modFreqS2.lag(lagTime)),
LFPulse.ar(modFreqS2.lag(lagTime))
]).range(minS2.lag(lagTime), maxS2.lag(lagTime)),

Select.ar(modWhichS3.lag(lagTime), [
LFNoise1.ar(modFreqS3.lag(lagTime)),
SinOsc.ar(modFreqS3.lag(lagTime)),
LFTri.ar(modFreqS3.lag(lagTime)),
LFSaw.ar(modFreqS3.lag(lagTime)),
LFPulse.ar(modFreqS3.lag(lagTime))
]).range(minS3.lag(lagTime), maxS3.lag(lagTime)),

Select.ar(modWhichS4.lag(lagTime), [
LFNoise1.ar(modFreqS4.lag(lagTime)),
SinOsc.ar(modFreqS4.lag(lagTime)),
LFTri.ar(modFreqS4.lag(lagTime)),
LFSaw.ar(modFreqS4.lag(lagTime)),
LFPulse.ar(modFreqS4.lag(lagTime))
]).range(minS4.lag(lagTime), maxS4.lag(lagTime)),

Select.ar(modWhichS5.lag(lagTime), [
LFNoise1.ar(modFreqS5.lag(lagTime)),
SinOsc.ar(modFreqS5.lag(lagTime)),
LFTri.ar(modFreqS5.lag(lagTime)),
LFSaw.ar(modFreqS5.lag(lagTime)),
LFPulse.ar(modFreqS5.lag(lagTime))
]).range(minS5.lag(lagTime), maxS5.lag(lagTime)),

Select.ar(modWhichS6.lag(lagTime), [
LFNoise1.ar(modFreqS6.lag(lagTime)),
SinOsc.ar(modFreqS6.lag(lagTime)),
LFTri.ar(modFreqS6.lag(lagTime)),
LFSaw.ar(modFreqS6.lag(lagTime)),
LFPulse.ar(modFreqS6.lag(lagTime))
]).range(minS6.lag(lagTime), maxS6.lag(lagTime)),

Select.ar(modWhichS7.lag(lagTime), [
LFNoise1.ar(modFreqS7.lag(lagTime)),
SinOsc.ar(modFreqS7.lag(lagTime)),
LFTri.ar(modFreqS7.lag(lagTime)),
LFSaw.ar(modFreqS7.lag(lagTime)),
LFPulse.ar(modFreqS7.lag(lagTime))
]).range(minS7.lag(lagTime), maxS7.lag(lagTime)),

Select.ar(modWhichS8.lag(lagTime), [
LFNoise1.ar(modFreqS8.lag(lagTime)),
SinOsc.ar(modFreqS8.lag(lagTime)),
LFTri.ar(modFreqS8.lag(lagTime)),
LFSaw.ar(modFreqS8.lag(lagTime)),
LFPulse.ar(modFreqS8.lag(lagTime))
]).range(minS8.lag(lagTime), maxS8.lag(lagTime)),

Select.ar(modWhichS9.lag(lagTime), [
LFNoise1.ar(modFreqS9.lag(lagTime)),
SinOsc.ar(modFreqS9.lag(lagTime)),
LFTri.ar(modFreqS9.lag(lagTime)),
LFSaw.ar(modFreqS9.lag(lagTime)),
LFPulse.ar(modFreqS9.lag(lagTime))
]).range(minS9.lag(lagTime), maxS9.lag(lagTime)),

Select.ar(modWhichS10.lag(lagTime), [
LFNoise1.ar(modFreqS10.lag(lagTime)),
SinOsc.ar(modFreqS10.lag(lagTime)),
LFTri.ar(modFreqS10.lag(lagTime)),
LFSaw.ar(modFreqS10.lag(lagTime)),
LFPulse.ar(modFreqS10.lag(lagTime))
]).range(minS10.lag(lagTime), maxS10.lag(lagTime)),

Select.ar(modWhichS11.lag(lagTime), [
LFNoise1.ar(modFreqS11.lag(lagTime)),
SinOsc.ar(modFreqS11.lag(lagTime)),
LFTri.ar(modFreqS11.lag(lagTime)),
LFSaw.ar(modFreqS11.lag(lagTime)),
LFPulse.ar(modFreqS11.lag(lagTime))
]).range(minS11.lag(lagTime), maxS11.lag(lagTime)),

Select.ar(modWhichS12.lag(lagTime), [
LFNoise1.ar(modFreqS12.lag(lagTime)),
SinOsc.ar(modFreqS12.lag(lagTime)),
LFTri.ar(modFreqS12.lag(lagTime)),
LFSaw.ar(modFreqS12.lag(lagTime)),
LFPulse.ar(modFreqS12.lag(lagTime))
]).range(minS12.lag(lagTime), maxS12.lag(lagTime))
];

encoder = NN(key, \timbre).ar(fxchain[0], blockSize);
structure = NN(key, \structure).ar(fxchain[1], blockSize);

encoder = Gate.ar(encoder, snap);
/*encoder = encoder * mulSpace.dbamp + addSpace;*/

postEncode = encoder * dryDim;
postModDim = modDim * wetDim;
postSum = postEncode + postModDim;

sigDim = [
Select.ar(which1, [encoder[0], postSum[0], \sig1.ar(0,0.1), modDim[0]]),
Select.ar(which2, [encoder[1], postSum[1], \sig2.ar(0,0.1), modDim[1]]),
Select.ar(which3, [encoder[2], postSum[2], \sig3.ar(0,0.1), modDim[2]]),
Select.ar(which4, [encoder[3], postSum[3], \sig4.ar(0,0.1), modDim[3]]),
Select.ar(which5, [encoder[4], postSum[4], \sig5.ar(0,0.1), modDim[4]]),
Select.ar(which6, [encoder[5], postSum[5], \sig6.ar(0,0.1), modDim[5]])
];
if(dimSize > 6, {
sigDim = sigDim*mulArr;
sig = sigDim ++ encoder.copyRange(8, dimSize-1);
}, {
if(dimSize < 6, {
sigDim = sigDim*mulArr;
sig = sigDim.copyRange(0, dimSize-1);
}, {
sig = sigDim;
});
});

sigTimbre = sig * mulSpace.dbamp + addSpace;

//structure
postEncodeS = structure * dryDimS;
postModDimS = modDimS * wetDimS;
postSumS = postEncodeS + postModDimS;

sigDimS = [
Select.ar(whichS1, [structure[0], \sigS1.ar(0,lagTime),
postSumS[0], modDimS[0]]),
Select.ar(whichS2, [structure[1], \sigS2.ar(0,lagTime),
postSumS[1], modDimS[1]]),
Select.ar(whichS3, [structure[2], \sigS3.ar(0,lagTime),
postSumS[2], modDimS[2]]),
Select.ar(whichS4, [structure[3], \sigS4.ar(0,lagTime),
postSumS[3], modDimS[3]]),
Select.ar(whichS5, [structure[4], \sigS5.ar(0,lagTime),
postSumS[4], modDimS[4]]),
Select.ar(whichS6, [structure[5], \sigS6.ar(0,lagTime),
postSumS[5], modDimS[5]]),
Select.ar(whichS7, [structure[6], \sigS7.ar(0,lagTime),
postSumS[6], modDimS[6]]),
Select.ar(whichS8, [structure[7], \sigS8.ar(0,lagTime),
postSumS[7], modDimS[7]]),
Select.ar(whichS9, [structure[8], \sigS9.ar(0,lagTime),
postSumS[8], modDimS[8]]),
Select.ar(whichS10, [structure[9], \sigS10.ar(0,lagTime),
postSumS[9], modDimS[9]]),
Select.ar(whichS11, [structure[10], \sigS11.ar(0,lagTime),
postSumS[10], modDimS[10]]),
Select.ar(whichS12, [structure[11], \sigS12.ar(0,lagTime),
postSumS[11], modDimS[11]]),
];
if(dimSizeS > 12, {
sigDimS = sigDimS*mulArrS;
sigS = sigDimS ++ structure.copyRange(12, dimSizeS-1);
}, {
if(dimSize < 12, {
sigDimS = sigDimS*mulArrS;
sigS = sigDimS.copyRange(0, dimSizeS-1);
}, {
sigS = sigDimS;
});
});

sigStructure = sigS * mulSpaceS.dbamp + addSpaceS;

//diffuse/decode

diffuse = NN(key, \diffuse).ar((sigStructure ++ sigTimbre),
blockSize, debug: 0, attributes: [\guidance_structure, gstructure,
\guidance_timbre, gtimbre, \nb_steps, steps]);

decoder = NN(key, \decode).ar(diffuse);

dryDel = DelayL.ar(input * dryDelGain.dbamp, 4, dryDelay);

decoderMix = decoder * gainDel.dbamp + dryDel;
decoderMix = decoderMix * amp * (postVol.dbamp.lag(0.01));
decoderMix = Select.ar(whichMix, [decoderMix, input]);

Pan2.ar(decoderMix, pan);
} ], [ 'afterImprov2', {arg lowCut=20 ->[20,20000, \exp],
hiCut=20000 ->[20,20000, \exp], preVol= 0 ->[ 0, 24, \db, 0, -inf,  "dB" ],
cpthresh= -20 ->[ -60, 0, \db, 0, -inf,  "dB" ], ratio=1 ->[1,6],
cpatk=0.01 ->[0.001,0.1], cprel=0.01 -> [0.001,0.1], transp=0 ->[-24,24,{|val| val.round(0.5)}],
disper=0 ->[0,0.1], postVol= 0 ->[ -24, 24], amp= 1->[0.1,2], pan= 0 ->[-1,1],
whichTimbre=0 ->[0,2, {|val| val.round(1)}],
whichStructure=0 ->[0,2, {|val| val.round(1)}],
snap = 1 -> [0,1, {|val| val.round(1)}],
gstructure=1 -> [0,5, {|val| val.round(0.1)}],
gtimbre=1-> [0,3, {|val| val.round(0.01)}],
steps=4-> [1,16, {|val| val.round(1)}],
which1=0 ->[0,3, {|val| val.round(1)}], which2=0 ->[0,3,{|val| val.round(1)}],
which3=0 ->[0,3,{|val| val.round(1)}], which4=0 ->[0,3,{|val| val.round(1)}],
which5=0 ->[0,3, {|val| val.round(1)}], which6=0 ->[0,3,{|val| val.round(1)}],
whichS1=0 ->[0,3, {|val| val.round(1)}], whichS2=0 ->[0,3,{|val| val.round(1)}],
whichS3=0 ->[0,3,{|val| val.round(1)}], whichS4=0 ->[0,3,{|val| val.round(1)}],
whichS5=0 ->[0,3, {|val| val.round(1)}], whichS6=0 ->[0,3,{|val| val.round(1)}],
whichS7=0 ->[0,3, {|val| val.round(1)}], whichS8=0 ->[0,3,{|val| val.round(1)}],
whichS9=0 ->[0,3,{|val| val.round(1)}], whichS10=0 ->[0,3,{|val| val.round(1)}],
whichS11=0 ->[0,3, {|val| val.round(1)}], whichS12=0 ->[0,3,{|val| val.round(1)}],
dryDim = 1 -> [0,1], wetDim = 0 -> [0,1],
mulSpace= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpace= 0 -> [-6,6],
dryDimS = 1 -> [0,1], wetDimS = 0 -> [0,1],
mulSpaceS= 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ], addSpaceS= 0 -> [-6,6],
mul1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mul6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS1 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS2 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS3 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS4 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS5 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS6 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS7 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS8 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS9 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS10 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS11 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
mulS12 = 0 -> [ -60, 9, \db, 0.1, -inf,  "dB" ],
add1= 0 -> [-3,3], add2= 0 -> [-3,3], add3= 0 -> [-3,3],
add4= 0 -> [-3,3], add5= 0 -> [-3,3], add6= 0 -> [-3,3],
addS1= 0 -> [-3,3], addS2= 0 -> [-3,3], addS3= 0 -> [-3,3],
addS4= 0 -> [-3,3], addS5= 0 -> [-3,3], addS6= 0 -> [-3,3],
addS7= 0 -> [-3,3], addS8= 0 -> [-3,3], addS9= 0 -> [-3,3],
addS10= 0 -> [-3,3], addS11= 0 -> [-3,3], addS12= 0 -> [-3,3],
modWhich1 = 0 -> [0,4,{|val| val.round(1)}],
modWhich2 = 0 -> [0,4,{|val| val.round(1)}],
modWhich3 = 0 -> [0,4,{|val| val.round(1)}],
modWhich4 = 0 -> [0,4,{|val| val.round(1)}],
modWhich5 = 0 -> [0,4,{|val| val.round(1)}],
modWhich6 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS1 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS2 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS3 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS4 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS5 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS6 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS7 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS8 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS9 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS10 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS11 = 0 -> [0,4,{|val| val.round(1)}],
modWhichS12 = 0 -> [0,4,{|val| val.round(1)}],
modFreq1 = 23 -> [0.01,85], modFreq2 = 23 -> [0.01,85],
modFreq3 = 23 -> [0.01,85], modFreq4 = 23 -> [0.01,85],
modFreq5 = 23 -> [0.01,85], modFreq6 = 23 -> [0.01,85],
modFreqS1 = 23 -> [0.01,85], modFreqS2 = 23 -> [0.01,85],
modFreqS3 = 23 -> [0.01,85], modFreqS4 = 23 -> [0.01,85],
modFreqS5 = 23 -> [0.01,85], modFreqS6 = 23 -> [0.01,85],
modFreqS7 = 23 -> [0.01,85], modFreqS8 = 23 -> [0.01,85],
modFreqS9 = 23 -> [0.01,85], modFreqS10 = 23 -> [0.01,85],
modFreqS11 = 23 -> [0.01,85], modFreqS12 = 23 -> [0.01,85],
min1 = -1 -> [-3,3], min2 = -1 -> [-3,3], min3 = -1 -> [-3,3],
min4 = -1 -> [-3,3], min5 = -1 -> [-3,3], min6 = -1 -> [-3,3],
minS1 = -1 -> [-1,1], minS2 = -1 -> [-1,1], minS3 = -1 -> [-1,1],
minS4 = -1 -> [-1,1], minS5 = -1 -> [-1,1], minS6 = -1 -> [-1,1],
minS7 = -1 -> [-1,1], minS8 = -1 -> [-1,1], minS9 = -1 -> [-1,1],
minS10 = -1 -> [-1,1], minS11 = -1 -> [-1,1], minS12 = -1 -> [-1,1],
max1 = 1 -> [-3,3], max2 = 1 -> [-3,3], max3 = 1 -> [-3,3],
max4 = 1 -> [-3,3], max5 = 1 -> [-3,3], max6 = 1 -> [-3,3],
maxS1 = 1 -> [-1,1], maxS2 = 1 -> [-1,1], maxS3 = 1 -> [-1,1],
maxS4 = 1 -> [-1,1], maxS5 = 1 -> [-1,1], maxS6 = 1 -> [-1,1],
maxS7 = 1 -> [-1,1], maxS8 = 1 -> [-1,1], maxS9 = 1 -> [-1,1],
maxS10 = 1 -> [-1,1], maxS11 = 1 -> [-1,1], maxS12 = 1 -> [-1,1],
whichMix = 0 -> [0,1, {|val| val.round(1)}],
gainDel=0 -> [ -inf, 0, \db, 0, -inf,  "dB" ],
dryDelGain = -inf -> [ -inf, 6, \db, 0, -inf,  "dB" ],
dryDelay = 2.299 -> [0,4], lagTime = 0.3 -> [0,2];

var input, sigL, sigR, sigSL, sigSR, encoderL, encoderR, sigDimL, sigDimR, sigDimSL, sigDimSR,
dimSize, dimSizeS, key, fxchain, modDim,
postEncodeL, postEncodeR, postEncodeSL, postEncodeSR, postModDim, postModDimS,
postSumL, postSumR, postSumSL, postSumSR, decoderL, decoderR, mulArr, mulArrS,
dryDel, decoderMix, structureL, structureR, diffuseL, diffuseR, blockSize, sigTimbreL, sigTimbreR,
sigStructureL, sigStructureR, modDimS, inputT, inputS;

key = ("after" ++ Radicles.modelNum).asSymbol;
NN(key).methods.do{|item| if(item.name == \timbre, {
dimSize = item.numOutputs}) };
NN(key).methods.do{|item| if(item.name == \structure, {
dimSizeS = item.numOutputs}) };
blockSize = 8192;
input = \in;
inputT = Select.ar(whichTimbre,
[\in, Ndef.ar('spaceTrack9', 2), Ndef.ar('spaceTrack10', 2)]);
inputS = Select.ar(whichStructure,
[\in, Ndef.ar('spaceTrack9', 2), Ndef.ar('spaceTrack10', 2)]);
//fx chain
fxchain = [inputT, inputS] * (preVol.dbamp.lag(0.01));
fxchain = LPF.ar(fxchain, hiCut);
fxchain = HPF.ar(fxchain, lowCut);
fxchain = Compander.ar(fxchain, fxchain,
thresh: cpthresh.dbamp,
slopeBelow: 1,
slopeAbove: 1/ratio,
clampTime:  cpatk,
relaxTime:  cprel
);
fxchain = PitchShift.ar(fxchain, 0.2, transp.midiratio,disper);

//fx chain

mul1 = mul1.dbamp + add1;
mul2 = mul2.dbamp + add2;
mul3 = mul3.dbamp + add3;
mul4 = mul4.dbamp + add4;
mul5 = mul5.dbamp + add5;
mul6 = mul6.dbamp + add6;

mulArr = [mul1, mul2, mul3, mul4, mul5, mul6];

mulS1 = mulS1.dbamp + addS1;
mulS2 = mulS2.dbamp + addS2;
mulS3 = mulS3.dbamp + addS3;
mulS4 = mulS4.dbamp + addS4;
mulS5 = mulS5.dbamp + addS5;
mulS6 = mulS6.dbamp + addS6;
mulS7 = mulS7.dbamp + addS7;
mulS8 = mulS8.dbamp + addS8;
mulS9 = mulS9.dbamp + addS9;
mulS10 = mulS10.dbamp + addS10;
mulS11 = mulS11.dbamp + addS11;
mulS12 = mulS12.dbamp + addS12;

mulArrS = [mulS1, mulS2, mulS3, mulS4, mulS5, mulS6,
mulS7, mulS8, mulS9, mulS10, mulS11, mulS12];

modDim = [
Select.ar(modWhich1, [
LFNoise1.ar(modFreq1),
SinOsc.ar(modFreq1),
LFTri.ar(modFreq1),
LFSaw.ar(modFreq1),
LFPulse.ar(modFreq1)]).range(min1, max1),

Select.ar(modWhich2, [
LFNoise1.ar(modFreq2),
SinOsc.ar(modFreq2),
LFTri.ar(modFreq2),
LFSaw.ar(modFreq2),
LFPulse.ar(modFreq2)]).range(min2, max2),

Select.ar(modWhich3, [
LFNoise1.ar(modFreq3),
SinOsc.ar(modFreq3),
LFTri.ar(modFreq3),
LFSaw.ar(modFreq3),
LFPulse.ar(modFreq3) ]).range(min3, max3),

Select.ar(modWhich4, [
LFNoise1.ar(modFreq4),
SinOsc.ar(modFreq4),
LFTri.ar(modFreq4),
LFSaw.ar(modFreq4),
LFPulse.ar(modFreq4) ]).range(min4, max4),

Select.ar(modWhich5, [
LFNoise1.ar(modFreq5),
SinOsc.ar(modFreq5),
LFTri.ar(modFreq5),
LFSaw.ar(modFreq5),
LFPulse.ar(modFreq5) ]).range(min5, max5),

Select.ar(modWhich6, [
LFNoise1.ar(modFreq6),
SinOsc.ar(modFreq6),
LFTri.ar(modFreq6),
LFSaw.ar(modFreq6),
LFPulse.ar(modFreq6) ]).range(min6, max6),
];

modDimS = [
Select.ar(modWhichS1.lag(lagTime), [
LFNoise1.ar(modFreqS1.lag(lagTime)),
SinOsc.ar(modFreqS1.lag(lagTime)),
LFTri.ar(modFreqS1.lag(lagTime)),
LFSaw.ar(modFreqS1.lag(lagTime)),
LFPulse.ar(modFreqS1.lag(lagTime))
]).range(minS1.lag(lagTime), maxS1.lag(lagTime)),

Select.ar(modWhichS2.lag(lagTime), [
LFNoise1.ar(modFreqS2.lag(lagTime)),
SinOsc.ar(modFreqS2.lag(lagTime)),
LFTri.ar(modFreqS2.lag(lagTime)),
LFSaw.ar(modFreqS2.lag(lagTime)),
LFPulse.ar(modFreqS2.lag(lagTime))
]).range(minS2.lag(lagTime), maxS2.lag(lagTime)),

Select.ar(modWhichS3.lag(lagTime), [
LFNoise1.ar(modFreqS3.lag(lagTime)),
SinOsc.ar(modFreqS3.lag(lagTime)),
LFTri.ar(modFreqS3.lag(lagTime)),
LFSaw.ar(modFreqS3.lag(lagTime)),
LFPulse.ar(modFreqS3.lag(lagTime))
]).range(minS3.lag(lagTime), maxS3.lag(lagTime)),

Select.ar(modWhichS4.lag(lagTime), [
LFNoise1.ar(modFreqS4.lag(lagTime)),
SinOsc.ar(modFreqS4.lag(lagTime)),
LFTri.ar(modFreqS4.lag(lagTime)),
LFSaw.ar(modFreqS4.lag(lagTime)),
LFPulse.ar(modFreqS4.lag(lagTime))
]).range(minS4.lag(lagTime), maxS4.lag(lagTime)),

Select.ar(modWhichS5.lag(lagTime), [
LFNoise1.ar(modFreqS5.lag(lagTime)),
SinOsc.ar(modFreqS5.lag(lagTime)),
LFTri.ar(modFreqS5.lag(lagTime)),
LFSaw.ar(modFreqS5.lag(lagTime)),
LFPulse.ar(modFreqS5.lag(lagTime))
]).range(minS5.lag(lagTime), maxS5.lag(lagTime)),

Select.ar(modWhichS6.lag(lagTime), [
LFNoise1.ar(modFreqS6.lag(lagTime)),
SinOsc.ar(modFreqS6.lag(lagTime)),
LFTri.ar(modFreqS6.lag(lagTime)),
LFSaw.ar(modFreqS6.lag(lagTime)),
LFPulse.ar(modFreqS6.lag(lagTime))
]).range(minS6.lag(lagTime), maxS6.lag(lagTime)),

Select.ar(modWhichS7.lag(lagTime), [
LFNoise1.ar(modFreqS7.lag(lagTime)),
SinOsc.ar(modFreqS7.lag(lagTime)),
LFTri.ar(modFreqS7.lag(lagTime)),
LFSaw.ar(modFreqS7.lag(lagTime)),
LFPulse.ar(modFreqS7.lag(lagTime))
]).range(minS7.lag(lagTime), maxS7.lag(lagTime)),

Select.ar(modWhichS8.lag(lagTime), [
LFNoise1.ar(modFreqS8.lag(lagTime)),
SinOsc.ar(modFreqS8.lag(lagTime)),
LFTri.ar(modFreqS8.lag(lagTime)),
LFSaw.ar(modFreqS8.lag(lagTime)),
LFPulse.ar(modFreqS8.lag(lagTime))
]).range(minS8.lag(lagTime), maxS8.lag(lagTime)),

Select.ar(modWhichS9.lag(lagTime), [
LFNoise1.ar(modFreqS9.lag(lagTime)),
SinOsc.ar(modFreqS9.lag(lagTime)),
LFTri.ar(modFreqS9.lag(lagTime)),
LFSaw.ar(modFreqS9.lag(lagTime)),
LFPulse.ar(modFreqS9.lag(lagTime))
]).range(minS9.lag(lagTime), maxS9.lag(lagTime)),

Select.ar(modWhichS10.lag(lagTime), [
LFNoise1.ar(modFreqS10.lag(lagTime)),
SinOsc.ar(modFreqS10.lag(lagTime)),
LFTri.ar(modFreqS10.lag(lagTime)),
LFSaw.ar(modFreqS10.lag(lagTime)),
LFPulse.ar(modFreqS10.lag(lagTime))
]).range(minS10.lag(lagTime), maxS10.lag(lagTime)),

Select.ar(modWhichS11.lag(lagTime), [
LFNoise1.ar(modFreqS11.lag(lagTime)),
SinOsc.ar(modFreqS11.lag(lagTime)),
LFTri.ar(modFreqS11.lag(lagTime)),
LFSaw.ar(modFreqS11.lag(lagTime)),
LFPulse.ar(modFreqS11.lag(lagTime))
]).range(minS11.lag(lagTime), maxS11.lag(lagTime)),

Select.ar(modWhichS12.lag(lagTime), [
LFNoise1.ar(modFreqS12.lag(lagTime)),
SinOsc.ar(modFreqS12.lag(lagTime)),
LFTri.ar(modFreqS12.lag(lagTime)),
LFSaw.ar(modFreqS12.lag(lagTime)),
LFPulse.ar(modFreqS12.lag(lagTime))
]).range(minS12.lag(lagTime), maxS12.lag(lagTime))
];

encoderL = NN(key, \timbre).ar(fxchain[0][0], blockSize);
encoderR = NN(key, \timbre).ar(fxchain[0][1], blockSize);
structureL = NN(key, \structure).ar(fxchain[1][0], blockSize);
structureR = NN(key, \structure).ar(fxchain[1][1], blockSize);

encoderL = Gate.ar(encoderL, snap);
encoderR = Gate.ar(encoderR, snap);
/*encoder = encoder * mulSpace.dbamp + addSpace;*/

postEncodeL = encoderL * dryDim;
postEncodeR = encoderR * dryDim;

postModDim = modDim * wetDim;

postSumL = postEncodeL + postModDim;
postSumR = postEncodeR + postModDim;

sigDimL = [
Select.ar(which1, [encoderL[0], postSumL[0], \sig1.ar(0,0.1), modDim[0]]),
Select.ar(which2, [encoderL[1], postSumL[1], \sig2.ar(0,0.1), modDim[1]]),
Select.ar(which3, [encoderL[2], postSumL[2], \sig3.ar(0,0.1), modDim[2]]),
Select.ar(which4, [encoderL[3], postSumL[3], \sig4.ar(0,0.1), modDim[3]]),
Select.ar(which5, [encoderL[4], postSumL[4], \sig5.ar(0,0.1), modDim[4]]),
Select.ar(which6, [encoderL[5], postSumL[5], \sig6.ar(0,0.1), modDim[5]])
];
if(dimSize > 6, {
sigDimL = sigDimL*mulArr;
sigL = sigDimL ++ encoderL.copyRange(8, dimSize-1);
}, {
if(dimSize < 6, {
sigDimL = sigDimL*mulArr;
sigL = sigDimL.copyRange(0, dimSize-1);
}, {
sigL = sigDimL;
});
});

sigDimR = [
Select.ar(which1, [encoderR[0], postSumR[0], \sig1.ar(0,0.1), modDim[0]]),
Select.ar(which2, [encoderR[1], postSumR[1], \sig2.ar(0,0.1), modDim[1]]),
Select.ar(which3, [encoderR[2], postSumR[2], \sig3.ar(0,0.1), modDim[2]]),
Select.ar(which4, [encoderR[3], postSumR[3], \sig4.ar(0,0.1), modDim[3]]),
Select.ar(which5, [encoderR[4], postSumR[4], \sig5.ar(0,0.1), modDim[4]]),
Select.ar(which6, [encoderR[5], postSumR[5], \sig6.ar(0,0.1), modDim[5]])
];
if(dimSize > 6, {
sigDimR = sigDimR*mulArr;
sigR = sigDimR ++ encoderR.copyRange(8, dimSize-1);
}, {
if(dimSize < 6, {
sigDimR = sigDimR*mulArr;
sigR = sigDimR.copyRange(0, dimSize-1);
}, {
sigR = sigDimR;
});
});

sigTimbreL = sigL * mulSpace.dbamp + addSpace;
sigTimbreR = sigR * mulSpace.dbamp + addSpace;

//structure
postEncodeSL = structureL * dryDimS;
postEncodeSR = structureR * dryDimS;

postModDimS = modDimS * wetDimS;

postSumSL = postEncodeSL + postModDimS;
postSumSR = postEncodeSR + postModDimS;

sigDimSL = [
Select.ar(whichS1, [structureL[0], \sigS1.ar(0,lagTime),
postSumSL[0], modDimS[0]]),
Select.ar(whichS2, [structureL[1], \sigS2.ar(0,lagTime),
postSumSL[1], modDimS[1]]),
Select.ar(whichS3, [structureL[2], \sigS3.ar(0,lagTime),
postSumSL[2], modDimS[2]]),
Select.ar(whichS4, [structureL[3], \sigS4.ar(0,lagTime),
postSumSL[3], modDimS[3]]),
Select.ar(whichS5, [structureL[4], \sigS5.ar(0,lagTime),
postSumSL[4], modDimS[4]]),
Select.ar(whichS6, [structureL[5], \sigS6.ar(0,lagTime),
postSumSL[5], modDimS[5]]),
Select.ar(whichS7, [structureL[6], \sigS7.ar(0,lagTime),
postSumSL[6], modDimS[6]]),
Select.ar(whichS8, [structureL[7], \sigS8.ar(0,lagTime),
postSumSL[7], modDimS[7]]),
Select.ar(whichS9, [structureL[8], \sigS9.ar(0,lagTime),
postSumSL[8], modDimS[8]]),
Select.ar(whichS10, [structureL[9], \sigS10.ar(0,lagTime),
postSumSL[9], modDimS[9]]),
Select.ar(whichS11, [structureL[10], \sigS11.ar(0,lagTime),
postSumSL[10], modDimS[10]]),
Select.ar(whichS12, [structureL[11], \sigS12.ar(0,lagTime),
postSumSL[11], modDimS[11]]),
];
if(dimSizeS > 12, {
sigDimSL = sigDimSL*mulArrS;
sigSL = sigDimSL ++ structureL.copyRange(12, dimSizeS-1);
}, {
if(dimSize < 12, {
sigDimSL = sigDimSL*mulArrS;
sigSL = sigDimSL.copyRange(0, dimSizeS-1);
}, {
sigSL = sigDimSL;
});
});

sigDimSR = [
Select.ar(whichS1, [structureR[0], \sigS1.ar(0,lagTime),
postSumSR[0], modDimS[0]]),
Select.ar(whichS2, [structureR[1], \sigS2.ar(0,lagTime),
postSumSR[1], modDimS[1]]),
Select.ar(whichS3, [structureR[2], \sigS3.ar(0,lagTime),
postSumSR[2], modDimS[2]]),
Select.ar(whichS4, [structureR[3], \sigS4.ar(0,lagTime),
postSumSR[3], modDimS[3]]),
Select.ar(whichS5, [structureR[4], \sigS5.ar(0,lagTime),
postSumSR[4], modDimS[4]]),
Select.ar(whichS6, [structureR[5], \sigS6.ar(0,lagTime),
postSumSR[5], modDimS[5]]),
Select.ar(whichS7, [structureR[6], \sigS7.ar(0,lagTime),
postSumSR[6], modDimS[6]]),
Select.ar(whichS8, [structureR[7], \sigS8.ar(0,lagTime),
postSumSR[7], modDimS[7]]),
Select.ar(whichS9, [structureR[8], \sigS9.ar(0,lagTime),
postSumSR[8], modDimS[8]]),
Select.ar(whichS10, [structureR[9], \sigS10.ar(0,lagTime),
postSumSR[9], modDimS[9]]),
Select.ar(whichS11, [structureR[10], \sigS11.ar(0,lagTime),
postSumSR[10], modDimS[10]]),
Select.ar(whichS12, [structureR[11], \sigS12.ar(0,lagTime),
postSumSR[11], modDimS[11]]),
];
if(dimSizeS > 12, {
sigDimSR = sigDimSR*mulArrS;
sigSR = sigDimSR ++ structureR.copyRange(12, dimSizeS-1);
}, {
if(dimSize < 12, {
sigDimSR = sigDimSR*mulArrS;
sigSR = sigDimSR.copyRange(0, dimSizeS-1);
}, {
sigSR = sigDimSR;
});
});

sigStructureL = sigSL * mulSpaceS.dbamp + addSpaceS;
sigStructureR = sigSR * mulSpaceS.dbamp + addSpaceS;

//diffuse/decode

diffuseL = NN(key, \diffuse).ar((sigStructureL ++ sigTimbreL),
blockSize, debug: 0, attributes: [\guidance_structure, gstructure,
\guidance_timbre, gtimbre, \nb_steps, steps]);

decoderL = NN(key, \decode).ar(diffuseL);

diffuseR = NN(key, \diffuse).ar((sigStructureR ++ sigTimbreR),
blockSize, debug: 0, attributes: [\guidance_structure, gstructure,
\guidance_timbre, gtimbre, \nb_steps, steps]);

decoderR = NN(key, \decode).ar(diffuseR);

///

dryDel = DelayL.ar(input * dryDelGain.dbamp, 4, dryDelay);

decoderMix = [decoderL, decoderR] * gainDel.dbamp + dryDel;
decoderMix = decoderMix * amp * (postVol.dbamp.lag(0.01));
decoderMix = Select.ar(whichMix, [decoderMix, input]);

} ] ]