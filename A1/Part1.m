pkg load signal;

fs=44100; dt=1/fs;
T=2; % seconds
N=T*fs;
t=(1:N)*dt; % vector of time samples
f = 233.08; % frequency
dB_level = -10;
amplitude_level = 10^(dB_level/20);

% Pure tone
file = cos(2*pi*f*t);
file = file * amplitude_level; % scaling to -10 dBFS
audiowrite('tone.wav', file, fs);
sound(file,fs); % plays sound to speaker

% Triangular wave
file = sawtooth(2*pi*f*t, 0.5);
file = file * amplitude_level; % scaling to -10 dBFS
audiowrite('tri.wav', file, fs);
sound(file,fs); % plays sound to speaker

% Square wave
file = square(2*pi*f*t);
file = file * amplitude_level; % scaling to -10 dBFS
audiowrite('sqr.wav', file, fs);
sound(file,fs); % plays sound to speaker

% Sum all above
[file1, fs] = audioread('tone.wav');
[file2, fs] = audioread('tri.wav');
[file3, fs] = audioread('sqr.wav');
file = file1 + file2 + file3;
audiowrite('sum.wav', file, fs);
sound(file, fs); % plays sound to speaker
