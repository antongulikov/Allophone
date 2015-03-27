function Pitch = Pitch_multiple_decision(sw, Pitch, Frame, cof, m, Pitch_min, Pitch_max)

% Calculate the precise estimate of Pitch.
swf = fft(sw);
%Pitch = Pitch_calc_Newton(swf, Pitch, Frame, cof);
Pitch = Pitch_calc_precise_step(swf, Pitch, Frame, cof);
%
% Admissible values of multiple frequencies.
ind_Freq = [1/4, 1/3, 1/2, 2/3, 1, 3/2, 2, 3, 4, 5];
while (Pitch/ind_Freq(1) > Pitch_max),
    ind_Freq = ind_Freq(2:end);
end
while (Pitch/ind_Freq(end) < Pitch_min),
    ind_Freq = ind_Freq(1:end-1);
end
%
ind0 = [1/4, 1/3, 1/2, 2/3, 3/4, 1];
ind = [];
for i=1:Pitch/2,
    ind = [ind, ind0+i-1];
end
%
% Energy in the spectral bands between spectra peaks.
a = linPredictCoef(sw, m);
for i=1:length(ind),
    env_lpc(i)=1/abs(polyval(a(m+1:-1:1),exp(2i*pi/Pitch*ind(i))));
end
%
% Cost function for multiple frequencies
FundFreq=Frame/Pitch;
for i_Freq = 1:length(ind_Freq),
    iF = ind_Freq(i_Freq);
    cross = 0;
    R = 0;
    for i = 1:length(ind),
        if (abs(ind(i)/iF - round(ind(i)/iF)) < 1e-6),
            [norm_err,sum_ampl,norm_swf]=ls_band(ind(i)*FundFreq,iF*FundFreq,swf,cof);
            envelope = abs(sum_ampl);
            cross = cross + env_lpc(i)*envelope;
            R = R + env_lpc(i)*env_lpc(i);
        end
    end
    cross_all(i_Freq) = cross;
    R_all(i_Freq) = R;
    Res(i_Freq) = cross*cross/R;
end
%
% Make the final decision about the Fundamental Frequency.
[Res_min, i_min] = max(Res);
if (ind_Freq(i_min) == 1),
    return;
else
    Pitch = Pitch/ind_Freq(i_min);
    %Pitch = Pitch_calc_Newton(swf, Pitch, Frame, cof);
    Pitch = Pitch_calc_precise_step(swf, Pitch, Frame, cof);
end
