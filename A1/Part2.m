
% +15dB
[file, fs] = audioread('tone.wav');

dB_level = 15;
amplitude_level = 10^(dB_level/20);

file = file * amplitude_level % Add +15 dBFS

audiowrite('tonePlus15dB.wav', file, fs);
sound(file,fs); % plays sound to speaker

% -3dB
[file, fs] = audioread('tri.wav');

dB_level = -3;
amplitude_level = 10^(dB_level/20);

file = file * amplitude_level % Add -3 dBFS

audiowrite('triMinus3dB.wav', file, fs);
sound(file,fs); % plays sound to speaker
