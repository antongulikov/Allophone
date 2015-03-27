function [num_scaled, den_scaled] = calc_LF(num, den, coef)

%num=[0.92727435, -1.8544941, 0.92727435];
%den=[1, -1.9059465, 0.9114024];

num0 = num - num(1)*den;

gamma_d_re = -den(2)/2;
gamma_d_im = sqrt(den(3) - gamma_d_re^2);
gamma = log(gamma_d_re + 1i*gamma_d_im);

A = [2*real(gamma), 1; -abs(gamma)^2, 0];
C = (expm(A)-eye(2))/A;

M = [[1,0]*C; [1,0]*C*(expm(A)+den(2)*eye(2))];
d = M\num0(2:3)';

A_coef = A/coef;
d_coef = d/coef;
C_coef = (expm(A_coef)-eye(2))/A_coef;

A_coef_d = expm(A_coef);
a1_coef = -trace(A_coef_d);
a2_coef = det(A_coef_d);
beta(1) = [1,0]*C_coef*d_coef;
beta(2) = [1,0]*C_coef*(A_coef_d+a1_coef*eye(2))*d_coef;

den_scaled = [1, a1_coef, a2_coef];
%kappa = 1-(beta(2)-beta(1))/(1-a1_coef+a2_coef);
num_scaled = [0, beta];

% figure(2);
% [W, f] = freqz(num_scaled, den_scaled, 10000, 22050);
% plot(f, abs(W));

