function cof = form_cof
%  Form bells

N = 512;
e = pi/N;
for k=1:101,
    delta = -0.5+(k-1)*0.01;
    x = pi*([-2:2]'-delta)/N;
    if (delta == 0),
        cof(1:5, k) = [0; -1/sqrt(6); sqrt(2/3); -1/sqrt(6); 0];
    else
        cof(1:5,k) = sin(pi*delta)*cos(x)*sin(e)^2./(sin(x).*sin(x+e).*sin(x-e))/(N*sqrt(3/2));
    end
end
