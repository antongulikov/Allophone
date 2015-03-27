function [Pitch, sw, Dynamic_cod] = Pitch_int_calc(s, Dynamic_cod, Pitch_min, Pitch_max)

Frame = length(s);
%    Normalized Hanning window calculation
w = hanning(Frame);      % w=.5-.5*cos(2*pi*(0:Frame-1)'/Frame);
w=w/sqrt(w'*w/Frame);
w2=w.*w;
w4s=w2'*w2;
%       
sw=s.*w;                % - windowed signal
sw2=sw'*sw;             % - its squared norm
sww=sw.*w;
%
% Computation of the correlation coefficients 'phi'.
t=[sww;zeros(Frame,1)];
t=fft(t);
t=real(t.*conj(t));
phi=real(ifft(t));
clear t;
% 
% Computation of the minimal LS functional for each pitch period 'P'.
Pitch_range = [Pitch_min : Pitch_max];
for P = Pitch_range,
        sum_phi=phi(1);
        for i=1:Frame/P, sum_phi=sum_phi+2*phi(1+P*i); end
        Residual(P,1)=(sw2-P*sum_phi/Frame)/(Frame-P*w4s/Frame);
end
%
% Dynamic programming for N_frames+1 last frames.
N_frames=3;
D=2;
for P = Pitch_range,
   i_min=P-D; if i_min<Pitch_min, i_min=Pitch_min; end
   i_max=P+D; if i_max>Pitch_max, i_max=Pitch_max; end
   for k=1:N_frames,
      % Bellman equation:
      Dynamic_cod(P,k) = 0.5*min(Dynamic_cod(i_min:i_max,k+1)) + Residual(P);
   end
end
Dynamic_cod(Pitch_range,N_frames+1) = Residual(Pitch_range);
%
[Dynamic_min, ind_min] = min(Dynamic_cod(Pitch_min:Pitch_max, 1));
Pitch = Pitch_min + ind_min-1;
