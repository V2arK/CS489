pkg load signal;


% Part A

function y = mu_compress(x, mu)
    y = sign(x) .* log(1 + mu * abs(x)) / log(1 + mu);
end

function y = quantize_signal(x, levels)
    max_val = max(x);
    min_val = min(x);
    y = round((x - min_val) * (levels - 1) / (max_val - min_val)) * (max_val - min_val) / (levels - 1) + min_val;
end

% Set the mu value
mu = 255;

% Read the input files
[trumpet, fs_trumpet] = audioread('Trumpet.wav');
[oboe, fs_oboe] = audioread('Oboe.wav');

% Apply the mu-law compression to both signals
trumpet_compressed = mu_compress(trumpet, mu);
oboe_compressed = mu_compress(oboe, mu);

% Quantize the compressed signals
trumpet_quantized = quantize_signal(trumpet_compressed, mu + 1);
oboe_quantized = quantize_signal(oboe_compressed, mu + 1);

% Save the processed audio to new files
audiowrite('Trumpet_comp.wav', trumpet_quantized, fs_trumpet, 'BitsPerSample', 32);
audiowrite('Oboe_comp.wav', oboe_quantized, fs_oboe, 'BitsPerSample', 32);

% Part B

function y = mu_decompress(x, mu)
    y = sign(x) .* (1 / mu) .* ((1 + mu).^abs(x) - 1);
end

% Set the mu value
mu = 255;

% Read the compressed audio files
[file1_comp, fs1] = audioread('file1_comp.wav');
[file2_comp, fs2] = audioread('file2_comp.wav');

% Apply the inverse mu-law to decompress the files
file1_decomp = mu_decompress(file1_comp, mu);
file2_decomp = mu_decompress(file2_comp, mu);

% Save the decompressed audio to new 32-bit float WAV files
audiowrite('file1_decomp.wav', file1_decomp, fs1, 'BitsPerSample', 32);
audiowrite('file2_decomp.wav', file2_decomp, fs2, 'BitsPerSample', 32);
