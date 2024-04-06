pkg load signal

function filtered_input_signal = spring_filter(input_signal, fs, f_natural)
  %% taking FFT
  % Perform FFT on the audio signal
  sigma = 1;             % Standard deviation for the bell shape
  Y = fft(input_signal);

  % Generate frequency axis for FFT
  nfft = length(input_signal);
  f_axis = linspace(0, fs, nfft);

  % Convert frequencies to log scale
  log_f_axis = log2(f_axis);

  % Create the filter
  filter = exp(-((log_f_axis - log2(f_natural)).^2) / (2*sigma^2));
  filter = filter / max(filter); % Normalize the filter

  % Determine if nfft is odd or even
  if mod(nfft, 2) == 0
      % nfft is even
      midpoint = nfft / 2;
      filter = [filter(1:midpoint), fliplr(filter(1:midpoint))];
  else
      % nfft is odd
      midpoint = (nfft + 1) / 2;
      filter = [filter(1:midpoint), fliplr(filter(2:midpoint))];
  end

  % Apply the filter to the FFT of the audio signal
  for i = 1:length(Y);
      Y_filtered(i) = Y(i) * filter(i);
  end
  % Perform inverse FFT to get the filtered audio signal
  filtered_input_signal = ifft(Y_filtered);
end

% read file
[input_signal, fs] = audioread('test_melody.wav');

% make the file mono if it is stereo
if size(input_signal, 2) > 1
    input_signal = input_signal(:,1); % use the first channel
end

% Parameters
N = length(input_signal);
output_signal = zeros(N, 1);
initial_delay_ms = 40; % The initial delay length
num_echoes = 6; % Number of echoes
feedback_initial_level = 0.6; % Initial feedback gain
mix_rate = 0.6; % Mix ratio of the reverberated signal and the original signal
decay_rate = 0.8; % Decay rate after each reflection
spring_natural_freq = 1000; % Natural frequency of the spring


% Initialize the delay buffer
max_delay_samples = round(fs * (initial_delay_ms / 1000) * (1 + 2*num_echoes));
delay_buffers = zeros(max_delay_samples, 1);

% Calculate the delay sample length for each echo
delay_lengths = round(fs * initial_delay_ms / 1000) * (1:2:2*num_echoes);

filtered_input_signal = spring_filter(input_signal, fs, spring_natural_freq);

for n = 1:N
    current_sample = filtered_input_signal(n);
    echo_sample = 0;

    % Add new samples to the delay buffer
    delay_buffers = [current_sample; delay_buffers(1:end-1)];

    for echo_num = 1:num_echoes
        echo_index = delay_lengths(echo_num);
        % Calculate the echo level for this round
        feedback_level = feedback_initial_level * decay_rate^(echo_num-1);
        % Calculate the feedback
        echo_sample = echo_sample + feedback_level * delay_buffers(echo_index, 1);
    end

    % Add the echo samples to the output signal
    output_signal(n) = echo_sample;
end

% Mix the original signal and the reverb signal
reverbed_signal = (1 - mix_rate) * input_signal + mix_rate * output_signal;

% normalize
reverbed_signal = reverbed_signal / max(reverbed_signal);

% Output
audiowrite('output_melody.wav', reverbed_signal, fs);
