pkg load signal; % Load signal processing package

function process_audio(file_name, output_file_remove, output_file_boost)
    % Read the audio file
    [y, Fs] = audioread(file_name);

    % Assume we have a way to remove or boost the first harmonic.
    % This will likely involve Fourier transform, filtering, and inverse Fourier transform
    % Since the exact method can get quite complex, we'll outline the steps

    % Step 1: Fourier Transform
    Y = fft(y);

    % Step 2: Identify the first harmonic around 233.08 Hz and process it
    % This involves finding the bin corresponding to 233.08 Hz
    N = length(Y);
    f = (0:length(Y)-1)*Fs/N;
    harmonic_index = round(233.08 / (Fs/N) + 1);
    boost_range = max(1, harmonic_index-30):min(harmonic_index+30, floor(N/2));

    % Plot original frequency spectrum
    figure;
    subplot(3,1,1); % Two rows, one column, first subplot
    plot(f(1:floor(N/2)), abs(Y(1:floor(N/2))));
    title('Original Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([220 260]);
    ylim([0 300]);

    % Remove the first harmonic for one file
    Y_removed = Y;
    %Y_removed(harmonic_index-5, harmonic_index+5) = 0; % Remove the harmonic
    %Y_removed(end-harmonic_index+2) = 0; % Mirror frequency for real signal
    Y_removed(boost_range) = 0;
    Y_removed(N-boost_range+2) = 0;

    % Boost the first harmonic by 6dB for another file
    Y_boosted = Y;
    %Y_boosted(harmonic_index) = Y(harmonic_index) * 2; % Boost by 6dB
    %Y_boosted(end-harmonic_index+2) = Y(end-harmonic_index+2) * 2; % Mirror frequency for real signal
    Y_boosted(boost_range) = Y_boosted(boost_range) * 2; % Boost by 6dB
    Y_boosted(N-boost_range+2) = Y(N-boost_range+2) * 2; % Mirror for negative frequencies

    % Step 3: Inverse Fourier Transform
    y_removed = real(ifft(Y_removed));
    y_boosted = real(ifft(Y_boosted));

    % Normalize the audio to 0dB full scale
    y_removed = y_removed / max(abs(y_removed));
    y_boosted = y_boosted / max(abs(y_boosted));

    sound(y,Fs); % plays sound to speaker
    % Save the processed audio files
    audiowrite(output_file_remove, y_removed, Fs);
    sound(y_removed,Fs); % plays sound to speaker
    audiowrite(output_file_boost, y_boosted, Fs);
    sound(y_boosted,Fs); % plays sound to speaker

    subplot(3,1,2); % Two rows, one column, second subplot
    plot(f(1:floor(N/2)), abs(Y_boosted(1:floor(N/2))));
    title('Boosted Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([220 260]);
    ylim([0 300]);

    subplot(3,1,3); % Two rows, one column, second subplot
    plot(f(1:floor(N/2)), abs(Y_removed(1:floor(N/2))));
    title('Removed Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([220 260]);
    ylim([0 300]);
end


% Process the Trumpet.wav and Oboe.wav files
process_audio('Trumpet.wav', 'Trump1.wav', 'Trump2.wav');
process_audio('Oboe.wav', 'Oboe1.wav', 'Oboe2.wav');
