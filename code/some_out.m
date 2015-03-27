sndout='V/FEM_OUT_ui_2.wav';

n_initout=0;

[s_output, SampleRate] = wavread(sndout);

Frameout = 512*4;
delFrameout = 64*4;

numout = [1,  -1.999164328624417,   0.999179759436045];
denout = [1  -1.983125142253791,   0.983311655264209];
s_filterout = filter(numout,  denout, [zeros(Frameout/2-delFrameout-2,1); s_output; zeros(Frameout/2,1)]);
clear s_output
Pitch_minout = 16*8; 
Pitch_maxout = floor(Frameout/3);
m=14;
threshold_UVout = 0.7;                    
Pitch_Unvoiced = Pitch_maxout + 1;
Dynamic_codout=zeros(Pitch_maxout,4);
cofout = form_cof;                        

aout = [];
energyout = [];
Pitchout = [];
phaseout = [];
amplout  = [];
Voicedout = [];
for n0 = n_initout : delFrameout : length(s_filterout) - 2*Frameout,
	disp(n0)
    s = s_filterout(n0+1:n0+Frameout);
    [a, ampl, energy, Pitch, phase, Voiced, Dynamic_codout] = coder(s, delFrameout, threshold_UVout, cofout, Dynamic_codout, m, Pitch_minout, Pitch_maxout);
    aout = [aout; a];
    energyout = [energyout; energy];
    Pitchout = [Pitchout; Pitch];
    phaseout(size(phaseout,1)+1, 1:floor(Pitch/2)) = phase;
    amplout(size(amplout,1)+1, 1:floor(Pitch/2)) = ampl;
    Voicedout = [Voicedout; Voiced];
end

