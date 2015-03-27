function [norm_err,sum_ampl,norm_swf]=ls_band(freq,F,swf,cof)
%
ib_min=floor(freq-F/2)+1;          % lower bound 
ib_max=floor(freq+F/2);            % upper bound
seg_b=[ib_min+1:ib_max+1];         % interval, accosiated with 'freq'.
norm_swf=swf(seg_b)'*swf(seg_b);   % energy of signal in the band
%        Corresponding peaks of 'swf' take 3-4, maximum 5, samples.
i0=round(freq);                    % the central sample
i_min=ib_min;
i_max=ib_max;
if i_min<i0-2, i_min=i0-2; end
if i_max>i0+2, i_max=i0+2; end
seg=[i_min+1:i_max+1];             % interval for the "bell" represented by 'cof'.
iw_min=i_min-i0+3;
iw_max=i_max-i0+3;
l=round((freq-i0)*100)+51;         % tabulated fractional shift
wcof=cof(iw_min:iw_max,l);         % interpolation coefficients
sum_ampl=wcof'*swf(seg);           % projection
norm_err=real(norm_swf-sum_ampl'*sum_ampl);
%
if (i0 ~= 2*round(i0/2)),
    sum_ampl = -sum_ampl;
end


