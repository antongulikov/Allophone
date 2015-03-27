function a = linPredictCoef(sw, m)

Frame = length(sw);
for k=0:m,
    r(k+1)=sw(k+1:Frame)'*sw(1:Frame-k);
end
E=r(1);
a=1;
for i=1:m,
    k=-a*r(i+1:-1:2)'/E;
    a=[a,0];
    a=a+k*a(i+1:-1:1);
    E=E*(1-k*k);
end
