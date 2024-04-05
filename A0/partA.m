fs=44100; dt=1/fs;
T=4; % seconds
N=T*fs;
t=(1:N)*dt; % vector of time samples

% A3 tone
f = 220; % A3
A3 = cos(2*pi*f*t);
A3 = A3 * 0.25; % scaling to -12 dBFS
audiowrite('A3tone.wav', A3, fs);
sound(A3,fs); % plays sound to speaker

% E4 tone
f = 329.63; % E4
E4 = cos(2*pi*f*t);
E4 = E4 * 0.25; % scaling to -12 dBFS
audiowrite('E4tone.wav', E4, fs);
sound(E4,fs); % plays sound to speaker

[y1,fs]=audioread('A3tone.wav');
[y2,fs]=audioread('E4tone.wav');
y= y1 + y2;
audiowrite('A3E4tone.wav',y,fs); %
sound(y,fs); % plays sound to speaker







