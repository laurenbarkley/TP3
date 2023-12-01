% Function imput
directoryPath = '/Users/laurenbarkley/Documents/MATLAB/bio107a_tp3_withteams-team_e1/Team 1 - 2mM Glutamate';
normalize_Data(directoryPath);

function normalized_Data = normalize_Data(directoryPath)
    % Validate if the provided path exists
    if ~isfolder(directoryPath)
        error('Provided directory does not exist.');
    end

    % List .tif files in the directory
    tifFiles = dir(fullfile(directoryPath, '*.tif'));

    % Initialize an array to store data in the ROI for each file
    data_In_ROI = [];

    % Loop through each .tif file
    for i = 1:length(tifFiles)
        % Read the current .tif file
        currentFilePath = fullfile(directoryPath, tifFiles(i).name);
        currentData = double(imread(currentFilePath));

        % Call defineROI function to get the ROI
        roi = define_ROI(currentData);

        % Extract data in the ROI
        dataInROICurrentFile = currentData(roi);

        % Store the data in the ROI for further processing
        data_In_ROI = [data_In_ROI; dataInROICurrentFile];
    end

    % Normalize the data in the ROI (z-score normalization)
    meanValue = mean(data_In_ROI);
    stdValue = std(data_In_ROI);
    normalized_Data = (data_In_ROI - meanValue) / stdValue;

    % Visualize the normalized data
    figure;
    histogram(normalized_Data, 'Normalization', 'probability');
    title('Normalized Data in ROI');

    % Optionally, you can save the normalized data to a file
    save('normalized_data.mat', 'normalized_Data');
end
