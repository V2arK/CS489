fs=44100; dt=1/fs;
T=4; % seconds
N=T*fs;
t=(1:N)*dt; % vector of time samples

% 220hz tone
f = 220; % A3
y = cos(2*pi*f*t);
y = y * 0.25; % scaling to -12 dBFS
audiowrite('220.wav', y, fs);

% 660hz tone
f = 660; % E4
y = cos(2*pi*f*t);
y = y * 0.25; % scaling to -12 dBFS
audiowrite('660.wav', y, fs);

% A3 note
[y1,fs]=audioread('220.wav');
[y2,fs]=audioread('660.wav');
y= y1 + y2;
audiowrite('A3note.wav',y,fs);
sound(y,fs); % plays sound to speaker

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 329.63hz tone
f = 329.63; % A3
y = cos(2*pi*f*t);
y = y * 0.25; % scaling to -12 dBFS
audiowrite('329.63.wav', y, fs);

% 659.26hz tone
f = 659.26; % E4
y = cos(2*pi*f*t);
y = y * 0.25; % scaling to -12 dBFS
audiowrite('659.26.wav', y, fs);

% E4 note
[y1,fs]=audioread('329.63.wav');
[y2,fs]=audioread('659.26.wav');
y= y1 + y2;
audiowrite('E4note.wav',y,fs);
sound(y,fs); % plays sound to speaker

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A3E4 note
[y1,fs]=audioread('A3note.wav');
[y2,fs]=audioread('E4note.wav');
y= y1 + y2;
audiowrite('A3E4note.wav',y,fs);
sound(y,fs); % plays sound to speaker




