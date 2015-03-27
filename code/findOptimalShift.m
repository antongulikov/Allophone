function [LI, RI, LO, RO] = findOptimalShift(A, B)

N = length(A);
M = length(B);
K = min(N, M);
ST = max(1, K - 20);
LI = -1;
RI = -1;
RET = 1e18;
LO = -1;
RO = -1;
for len = ST:K,
	for i1 = 1:(N-len+1),
		for j1 = 1:(M-len+1),
			q = [1:len];
			for u = 1:len,
				q(u+u) = abs(A(i1 + u - 1) - B(j1 + u - 1));
			end
			tmpVar = myVarScorpion(q);
			if tmpVar < RET,
				RET = tmpVar;
				LI = i1;
				RI = i1 + len - 1;
				LO = j1;
				RO = j1 + len - 1;
			end
		end
	end
end

end	
			