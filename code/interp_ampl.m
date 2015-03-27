
load parameters_inp_MAL_u_1
load parameters_out_MAL_u_1

SampleRate = 44100;
delFrame = 256;
N_frames = length(P_inp);   % = length(P_out)

ff = [200:1:8000];

A_inp = zeros(N_frames, length(ff));
A_out = zeros(N_frames, length(ff));
W     = zeros(N_frames, length(ff));
seg_ff = [1:60];
for i_frame = 1:N_frames,
    Pitch_inp = P_inp(i_frame);
    Pitch_out = P_out(i_frame);
    f_inp = seg_ff*SampleRate/Pitch_inp;
    f_out = seg_ff*SampleRate/Pitch_out;
    A_inp(i_frame,:) = spline(f_inp, ampl_inp(i_frame,1+seg_ff), ff);
    A_out(i_frame,:) = spline(f_out, ampl_out(i_frame,1+seg_ff), ff);
    W_frame = ampl_out(i_frame,1+seg_ff).*ampl_inp(i_frame,1+seg_ff)./(ampl_inp(i_frame,1+seg_ff).^2 + 1e-6);
    W(i_frame,:) = spline(f_out, W_frame, ff);
end

%save tmp P_inp P_out A_inp A_out W

seg_plot = [1:4101];

len = size(A_inp,1);
figure(1);
k = 400; % FEM a_3
image([0:len-1]/SampleRate*delFrame*1e3,seg_plot,abs(A_inp(:, seg_plot)')*k);
xlabel('Time,   ms')
ylabel('Hz')
title('FEM a 3. Spectrum near vocal chords')

figure(2);
k = 500; % FEM a_3
image([0:len-1]/SampleRate*delFrame*1e3,seg_plot,abs(A_out(:, seg_plot)')*k);
xlabel('Time,   ms')
ylabel('Hz')
title('FEM a 3. Spectrum outside')

figure(3);
k = 30; % FEM a_3
image([0:len-1]/SampleRate*delFrame*1e3,seg_plot,log2(abs(W(:, seg_plot)')+1)*k);
xlabel('Time,   ms')
ylabel('Hz')
title('FEM a 3. Transfer function of the vocal tract. In dB');

figure(4);
plot([0:len-1]/SampleRate*delFrame*1e3,SampleRate./[P_inp, P_out])
xlabel('Time,   ms')
ylabel('Hz')
title('FEM a 3. Fundamental frequency');
legend('inside','outside')
