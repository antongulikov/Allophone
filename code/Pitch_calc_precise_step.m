function Pitch_opt = Pitch_calc_precise_step(sw, Pitch, Frame, cof)

%  Direct minimization of the LS criterion over quantized values of Pitch.
swf=fft(sw);
f_min = abs(swf'*swf);
step = 0.2;
Pitch_opt = Pitch;
for P = Pitch-2 : step : Pitch+2,
    f=ls_freq(P,Frame,swf,cof);          %%% Computation of the LS functional
    if f<f_min,
       Pitch_opt = P;
       f_min=f;
    end
end
%
Pitch = Pitch_opt;
step = 0.04;
for P = Pitch-0.2 : step : Pitch+0.2,
    f=ls_freq(P,Frame,swf,cof);          %%% Computation of the LS functional
    if f<f_min,
       Pitch_opt = P;
       f_min=f;
    end
end
%
Pitch = Pitch_opt;
step = 0.01;
for P = Pitch-0.06 : step : Pitch+0.06,
    f=ls_freq(P,Frame,swf,cof);          %%% Computation of the LS functional
    if f<f_min,
       Pitch_opt = P;
       f_min=f;
    end
end


