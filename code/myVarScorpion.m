function ret = myVarScorpion(A)

N = length(A);

men = 0;

for i = 1:N,
	men = men + A(i);
end

men = men / (0. + N);

ret = 0;

for i = 1:N,
	ret = ret + abs(A(i) - men) * abs(A(i) - men);
end

ret = ret / (0. + N - 1);

end