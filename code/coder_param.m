snd='V/FEM_IN_a_2.wav';

n_init=0;

[s_input, SampleRate] = wavread(snd);

Frame = 512*4;
delFrame = 64*4;

num = [1,  -1.999164328624417,   0.999179759436045];
den = [1  -1.983125142253791,   0.983311655264209];
s_filter = filter(num,  den, [zeros(Frame/2-delFrame-2,1); s_input; zeros(Frame/2,1)]);
clear s_input
Pitch_min = 16*8; 
Pitch_max = floor(Frame/3);
m=14;
threshold_UV = 0.7;                    
Pitch_Unvoiced = Pitch_max + 1;
Dynamic_cod=zeros(Pitch_max,4);
cof = form_cof;                        

a_all = [];
energy_all = [];
Pitch_all = [];
phase_all = [];
ampl_all  = [];
Voiced_all = [];
for n0 = n_init : delFrame : length(s_filter) - 2*Frame,
    s = s_filter(n0+1:n0+Frame);
    [a, ampl, energy, Pitch, phase, Voiced, Dynamic_cod] = coder(s, delFrame, threshold_UV, cof, Dynamic_cod, m, Pitch_min, Pitch_max);
    a_all = [a_all; a];
    energy_all = [energy_all; energy];
    Pitch_all = [Pitch_all; Pitch];
    phase_all(size(phase_all,1)+1, 1:floor(Pitch/2)) = phase;
    ampl_all(size(ampl_all,1)+1, 1:floor(Pitch/2)) = ampl;
    Voiced_all = [Voiced_all; Voiced];
end

sndout='V/FEM_OUT_a_2.wav';

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
    s = s_filterout(n0+1:n0+Frameout);
    [a, ampl, energy, Pitch, phase, Voiced, Dynamic_codout] = coder(s, delFrameout, threshold_UVout, cofout, Dynamic_codout, m, Pitch_minout, Pitch_maxout);
    aout = [aout; a];
    energyout = [energyout; energy];
    Pitchout = [Pitchout; Pitch];
    phaseout(size(phaseout,1)+1, 1:floor(Pitch/2)) = phase;
    amplout(size(amplout,1)+1, 1:floor(Pitch/2)) = ampl;
    Voicedout = [Voicedout; Voiced];
end

