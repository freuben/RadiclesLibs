[ [ 'myblock', {arg freq= 200 ;
	SinOsc.ar(freq);
} ], [ 'blocknew', {arg freq=200 ;
	Pulse.ar(freq, 0.5, 0.5);	
} ], [ 'blocknew2', {arg freq=200 , trig=1 ;
	Pulse.ar(freq, 0.5, 0.5) * Env.adsr.kr(gate: trig);	
} ] ]