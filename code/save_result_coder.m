% INPUT
a_inp = [1:150]; % FEM a_1
P_inp = Pitch_all(a_inp);
plot(P_inp,'.-');
inp = deltaScorpion(P_inp);
seg_inp = a_inp(inp(1):inp(2));
P_inp = Pitch_all(seg_inp);


a_out = [1:150]; % FEM a_1
P_out = Pitchout(a_out);
%plot(P_out, '.-');
out = deltaScorpion(P_out);
disp(out(2));
disp(out(1));
seg_out = a_out(out(1):out(2)); % FEM a_ 1
P_out = Pitchout(seg_out);

%plot(P_out, '.-');

[LI, RI, LO, RO] = findOptimalShift(P_inp, P_out);

LI = LI + inp(1);
RI = RI + inp(1);
LO = LO + out(1);
RO = RO + out(1);

disp(LI);
disp(RI);
disp(LO);
disp(RO);



seg_inp = a_inp(LI:RI);
P_inp = Pitch_all(seg_inp);

seg_out = a_out(LO:RO); % FEM a_ 1
P_out = Pitchout(seg_out);

%plot(P_out, '.-')
%plot(P_inp, '.-')

energy_inp = energy_all(seg_inp);
ampl_inp = ampl_all(seg_inp,:);
phase_inp = phase_all(seg_inp,:);    


save parameters_inp_FEM_a_2 P_inp energy_inp ampl_inp phase_inp

% OUTPUT
energy_out = energyout(seg_out);
ampl_out = amplout(seg_out,:);
phase_out = phaseout(seg_out,:);

save parameters_out_FEM_a_2 P_out energy_out ampl_out phase_out

plot([P_inp, P_out])

%plot(P_out, '.-')
%plot(P_inp, '.-')
