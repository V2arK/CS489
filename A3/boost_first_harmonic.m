pkg load signal; % Load signal processing package

function boost_first_harmonic_and_plot(input_file, output_file)
    % Read the audio file
    [y, Fs] = audioread(input_file);

    % Convert to mono if stereo
    if size(y, 2) == 2
        y = mean(y, 2); % Convert to mono by averaging channels
    end

    % Perform FFT
    Y = fft(y);
    N = length(Y);
    f = (0:N-1)*(Fs/N); % Frequency vector

    % Plot original frequency spectrum
    figure;
    subplot(2,1,1); % Two rows, one column, first subplot
    plot(f(1:floor(N/2)), abs(Y(1:floor(N/2))));
    title('Original Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 Fs/2]);

    % Find the first harmonic (excluding the DC component)
    [pks, locs] = findpeaks(abs(Y(2:floor(N/2))));
    [~, maxIdx] = max(pks);
    firstHarmonicIndex = locs(maxIdx) + 1;

    % Boost the first harmonic and surrounding bins by 6dB
    boost_range = max(1, firstHarmonicIndex-500):min(firstHarmonicIndex+500, floor(N/2));
    Y(boost_range) = 0; % Boost by 6dB
    Y(N-boost_range+2) = Y(N-boost_range+2) * sqrt(2); % Mirror for negative frequencies
    disp (boost_range);
    % Inverse FFT to get the boosted signal back
    y_boosted = real(ifft(Y));

    % Normalize the boosted signal
    % y_boosted = y_boosted / max(abs(y_boosted));

    % Perform FFT on the boosted signal for visualization
    Y_boosted = fft(y_boosted);

    % Plot boosted frequency spectrum
    subplot(2,1,2); % Two rows, one column, second subplot
    plot(f(1:floor(N/2)), abs(Y_boosted(1:floor(N/2))));
    title('Boosted Frequency Spectrum');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0 Fs/2]);

    % Save the boosted audio file
    audiowrite(output_file, y_boosted, Fs);
end

% Process the Trumpet.wav and Oboe.wav files
boost_first_harmonic_and_plot('Trumpet.wav', 'Trump1.wav');

