pkg load signal;

fs=44100; dt=1/fs;
T=2; % seconds
N=T*fs;
t=(1:N)*dt; % vector of time samples
f = 440; % frequency
dB_level = 0;
amplitude_level = 10^(dB_level/20);

% Square wave
% The harmonics of a square wave consist of only odd harmonics.
% The amplitude of each harmonic decreases as the inverse of the harmonic number.
y_square = zeros(size(t));
for k = 1:2:9
    y_square += (4/pi) * (1/k) * sin(2 * pi * k * f * t);
end
y_square = y_square / max(abs(y_square)); % Normalize
audiowrite('file1.wav', y_square, fs);
sound(y_square,fs); % plays sound to speaker

% Triangular wave
% triangular wave only contains odd harmonics.
% The amplitude decreases as the square of the inverse of the harmonic number.
y_triangle = zeros(size(t));
for k = 1:2:9
    y_triangle += ((-1)^((k-1)/2) * (8/pi^2) * (1/k^2) * sin(2 * pi * k * f * t));
end
y_triangle = y_triangle / max(abs(y_triangle)); % Normalize
audiowrite('file2.wav', y_triangle, fs);
sound(y_triangle,fs); % plays sound to speaker

% Sawtooth wave
% sawtooth wave contains both even and odd harmonics,
% and the amplitude decreases as the inverse of the harmonic number.
y_sawtooth = zeros(size(t));
for k = 1:9
    y_sawtooth += (2/pi) * (1/k) * sin(2 * pi * k * f * t);
end
y_sawtooth = y_sawtooth / max(abs(y_sawtooth)); % Normalize
audiowrite('file3.wav', y_sawtooth, fs);
sound(y_sawtooth,fs); % plays sound to speaker

% Custom wave
a_k = [0.05, 0.15, 0.22, 0.22, 0.17, 0.10, 0.05, 0.02, 0.008];
phi_k = [0, pi/2, 0, -pi/2, 0, pi/2, 0, -pi/2, 0];
y_custom = zeros(size(t));
for k = 1:9
    y_custom += a_k(k) * cos(2 * pi * k * f * t + phi_k(k));
end
y_custom = y_custom / max(abs(y_custom)); % Normalize
audiowrite('file4.wav', y_custom, fs);
sound(y_custom,fs); % plays sound to speaker


