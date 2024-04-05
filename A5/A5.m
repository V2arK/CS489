% Ensure the signal package is loaded
pkg load signal;

% Read the filters
[h1, fs1] = audioread('filter1.wav'); % Read filter1 as FLOAT32
[h2, fs2] = audioread('filter2.wav'); % Read filter2 as FLOAT32

% Read the sound files
[x1, fsx1] = audioread('Oboe_norm.wav'); % Read Oboe_norm.wav
[x2, fsx2] = audioread('Trump_norm.wav'); % Read Trump_norm.wav

% Ensure the filters are in the correct format (column vectors)
%h1 = h1(:);
%h2 = h2(:);

% Filter the sound files
yOboe1 = filter(h1, [1], x1); % Filter Oboe_norm.wav with filter1
yOboe2 = filter(h2, [1], x1); % Filter Oboe_norm.wav with filter2
yTrump1 = filter(h1, [1], x2); % Filter Trump_norm.wav with filter1
yTrump2 = filter(h2, [1], x2); % Filter Trump_norm.wav with filter2

% Write the filtered sound files without normalization
audiowrite('Oboe_filt1.wav', yOboe1, fsx1, 'BitsPerSample', 32);
audiowrite('Oboe_filt2.wav', yOboe2, fsx1, 'BitsPerSample', 32);
audiowrite('Trump_filt1.wav', yTrump1, fsx2, 'BitsPerSample', 32);
audiowrite('Trump_filt2.wav', yTrump2, fsx2, 'BitsPerSample', 32);

