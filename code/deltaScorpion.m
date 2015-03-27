function w = deltaScorpion(A)

N = length(A);
delt = [1:(N - 1)];
for i = 2:(N),
	delt(i-1) = abs(A(i) - A(i - 1));
end
left = 0;
for i = 1:(N-40),
	cntqqq = 0;
    for j = 1:40,
        if delt(i + j - 1) < 30,
			cntqqq = cntqqq + 1;
        end
    end
    if cntqqq > 39,
		left = i;
		break;
    end
end

right = N - 1;
for i = (left + 1): (N-1),
	if delt(i) > 50,
		right = i;
		break;
	end
end             
w = [left, right];
end
