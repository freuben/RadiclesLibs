[ [ 'myblock', {arg freq= 200 -> [20, 20000, \exp];
	SinOsc.ar(freq);
} ], [ 'blocknew', {arg freq=200 -> [20, 20000, \exp];
	Pulse.ar(freq, 0.5, 0.5);	
} ], [ 'blocknew2', {arg freq=200 -> [20, 20000, \exp], trig=1 -> [0,1, {|val| val.round(1)}];
	Pulse.ar(freq, 0.5, 0.5) * Env.adsr.kr(gate: trig);	
} ] ]