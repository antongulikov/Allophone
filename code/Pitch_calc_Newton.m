function Pitch = Pitch_calc_Newton(swf, Pitch, Frame, cof)
%   Enhanced 'Pitch' update

P_min = Pitch - 2;
P_max = Pitch + 2;

%  Strict minimization of the LS criterion over quantized values of Pitch.
h = 0.04;
P = Pitch;
f = ls_freq(P,Frame,swf,cof);          %%% Computation of the LS functional
while (1 == 1),
    f_left  = ls_freq(P-h,Frame,swf,cof);
    f_right = ls_freq(P+h,Frame,swf,cof);
    df = (f_right - f_left)/(2*h);
    d2f = (f_right+f_left - 2*f)/(h^2);
    dP = -df/d2f;
    if (d2f <= 0)
        dP = -sign(df)*h;
    end
    step = 1;
    while (step > 1e-4),
        P_new = P + dP*step;
        if (P_new > P_max), P_new = P_max; end
        if (P_new < P_min), P_new = P_min; end
        f_new = ls_freq(P_new, Frame, swf, cof);
        %disp([f, f_new, step])
        if (f_new < f*0.99999),
            P = P_new;
            f = f_new;
            break;
        else
            step = step/2;
        end
    end
    %if (step <= 1e-4),
    if (step*abs(dP) <= 1e-4),
        break;
    end
end
Pitch = P;
