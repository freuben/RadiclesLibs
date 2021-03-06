[ [ 'mgb', {arg thresh=0->[0.01,50.01,\exp, {|val| val-0.01}], adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_MagBelow(chain, thresh); 
	(adjVol * IFFT(chain));} ], [ 'mgs', {arg strech=0->[0.001,2], shift=0->[-5,5], adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_MagShift(chain, strech, shift); 
	(adjVol * IFFT(chain));} ], [ 'mgr', {arg wipe=0->[0,1], trig=0->[0,1], adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_RandComb(chain, wipe, trig); 
	(adjVol * IFFT(chain));} ], [ 'mgn', {arg adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_MagNoise(chain); 
	(adjVol * IFFT(chain));} ], [ 'mgbw', {arg wipe=0->[-1,1], adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_BrickWall(chain, wipe); 
	(adjVol * IFFT(chain));} ], [ 'mgbs', {arg wipe=0 ->[0,1], width=0 -> [0,1], trig = 0 -> [0,1], adjVol=1->[0,4];
var chain, frameSize=2048, input;
	input = \in;
chain = FFT(LocalBuf(frameSize, input.numChannels), input);
chain = PV_BinScramble(chain, wipe, width, trig); 
	(adjVol * IFFT(chain));} ], [ 'pvmt', {arg track=2->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	signal = Select.ar(track-1, [Ndef(\track1).ar, Ndef(\track2).ar, Ndef(\track3).ar, Ndef(\track4).ar, Ndef(\track5).ar, Ndef(\track6).ar, Ndef(\track7).ar, Ndef(\track8).ar]);
	input = \in;
	frameSize = 2048;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Mul(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'pvmi', {arg soundin=1->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	frameSize = 2048;
	signal = SoundIn.ar((soundin+1).round(1));
	input = \in;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Mul(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'pvri', {arg soundin=1->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4], wipe=0 -> [0,1], trig=0 -> [0,1, {|val| val.round(1)}];
var chainA, chainB, chain, frameSize, signal, input;
	frameSize = 2048;
	signal = SoundIn.ar((soundin+1).round(1));
	input = \in;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_RandWipe(chainA, chainB, wipe, trig); 
	(adjVol * IFFT(chain));} ], [ 'pvrt', {arg track=2->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4], wipe=0 -> [0,1], trig=0 -> [0,1, {|val| val.round(1)}];
var chainA, chainB, chain, frameSize, signal, input;
	signal = Select.ar(track-1, [Ndef(\track1).ar, Ndef(\track2).ar, Ndef(\track3).ar, Ndef(\track4).ar, Ndef(\track5).ar, Ndef(\track6).ar, Ndef(\track7).ar, Ndef(\track8).ar]);
	input = \in;
	frameSize = 2048;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_RandWipe(chainA, chainB, wipe, trig); 
	(adjVol * IFFT(chain));} ], [ 'pvmxt', {arg track=2->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	signal = Select.ar(track-1, [Ndef(\track1).ar, Ndef(\track2).ar, Ndef(\track3).ar, Ndef(\track4).ar, Ndef(\track5).ar, Ndef(\track6).ar, Ndef(\track7).ar, Ndef(\track8).ar]);
	input = \in;
	frameSize = 2048;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Max(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'pvmxi', {arg soundin=1->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	frameSize = 2048;
	signal = SoundIn.ar((soundin+1).round(1));
	input = \in;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Max(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'pvmni', {arg soundin=1->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	frameSize = 2048;
	signal = SoundIn.ar((soundin+1).round(1));
	input = \in;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Min(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'pvmnt', {arg track=2->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	signal = Select.ar(track-1, [Ndef(\track1).ar, Ndef(\track2).ar, Ndef(\track3).ar, Ndef(\track4).ar, Ndef(\track5).ar, Ndef(\track6).ar, Ndef(\track7).ar, Ndef(\track8).ar]);
	input = \in;
	frameSize = 2048;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Min(chainA, chainB); 
	(adjVol * IFFT(chain));} ], [ 'morphi', {arg morph = 0.5 -> [0,1], soundin=1->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	frameSize = 2048;
	signal = SoundIn.ar((soundin+1).round(1));
	input = \in;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Morph(chainA, chainB, morph); 
	(adjVol * IFFT(chain));} ], [ 'morpht', {arg morph = 0.5 -> [0,1], track=2->[1,8,{|val| val.round(1)}], inMul=0.5 ->[0,1], sigMul=0.5 -> [0,1], adjVol=1->[0,4];
var chainA, chainB, chain, frameSize, signal, input;
	signal = Select.ar(track-1, [Ndef(\track1).ar, Ndef(\track2).ar, Ndef(\track3).ar, Ndef(\track4).ar, Ndef(\track5).ar, Ndef(\track6).ar, Ndef(\track7).ar, Ndef(\track8).ar]);
	input = \in;
	frameSize = 2048;
	chainA = FFT(LocalBuf(frameSize, input.numChannels), input * (inMul/2));
	chainB = FFT(LocalBuf(frameSize, input.numChannels), signal * (sigMul/2));
	chain = PV_Morph(chainA, chainB, morph); 
	(adjVol * IFFT(chain));} ] ]