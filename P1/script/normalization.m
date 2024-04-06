pkg load signal;

function normalize_and_write_audio(input_file, output_file_name)
    % Read audio file
    [y, fs] = audioread(input_file);

    % Normalize audio amplitude to range [-1, 1]
    max_amp = max(abs(y));
    y_normalized = y / max_amp;

    % Write normalized audio back to file
    audiowrite(output_file_name, y_normalized, fs);
end

function normalize_all_wav_files_in_folder()
    % Get a list of all .wav files in the folder
    folder_path = pwd();
    wav_files = dir(fullfile(folder_path, '*.wav'));

    % Loop through each .wav file and normalize
    for i = 1:length(wav_files)
        file_name = fullfile(folder_path, wav_files(i).name);
        output_file_name = fullfile(folder_path, ['normalized_' wav_files(i).name]);
        normalize_and_write_audio(file_name, output_file_name);
        disp(['Normalized and wrote ' file_name]);
    end
end

normalize_all_wav_files_in_folder();
