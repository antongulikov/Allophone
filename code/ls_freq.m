function sum_err=ls_freq(P,Frame,swf,cof)
%
F=Frame/P;
sum_err=0;
for i_band=2:P/2,
   norm_err=ls_band((i_band-1)*F,F,swf,cof);     % minimum of LS criterion
   sum_err=sum_err+norm_err;  
end


