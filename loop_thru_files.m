% Loop through TIFF Files 

directoryPath = '/Users/laurenbarkley/Documents/MATLAB/bio107a_tp3_withteams-team_e1';
process_TIFF_Files(directoryPath);

function process_TIFF_Files(directoryPath)
    % See if the provided path exists
    if ~isfolder(directoryPath)
        error('Provided directory does not exist.');
    end

    % Create a list of files in the directory
    files = dir(fullfile(directoryPath, '*.tif'));

    % Loop through each TIFF file
    for i = 1:length(files)
        % Get the current file name
        CurrentFileName = files(i).name;

        % Build the full file path
        CurrentFilePath ~ fullfile(directoryPath, CurrentFileName);

        % Perform processing on tiffData as needed
        % Your processing code here
        
        % Display or save the results as needed
        disp(['Processing file: ', CurrentFileName]);
    end
end


