% imput
baselineDirectory = '/path/to/baseline/tiff/files'; % define
experimentalDirectory = '/path/to/experimental/tiff/files'; % define
compareFluorescenceValues(baselineDirectory, experimentalDirectory);

function compareFluorescenceValues(baselineDirectory, experimentalDirectory)
    % Check if the provided directories exist
    if ~isfolder(baselineDirectory) || ~isfolder(experimentalDirectory)
        error('One or both of the provided directories do not exist.');
    end

    % Get a list of TIFF files in the baseline directory
    baselineFiles = dir(fullfile(baselineDirectory, '*.tif'));

    % Initialize arrays to store baseline and experimental fluorescence values
    baselineFluorescence = [];
    experimentalFluorescence = [];

    % Loop through each baseline TIFF file
    for i = 1:length(baselineFiles)
        % Read the current baseline TIFF file
        baselineFilePath = fullfile(baselineDirectory, baselineFiles(i).name);
        baselineData = double(imread(baselineFilePath));

        % Call the defineROI function to get the ROI
        roi = defineROI(baselineData);

        % Extract fluorescence values in the ROI
        baselineFluorescenceCurrentFile = baselineData(roi);

        % Store baseline fluorescence values
        baselineFluorescence = [baselineFluorescence; baselineFluorescenceCurrentFile];
    end

    % Loop through each experimental TIFF file
    experimentalFiles = dir(fullfile(experimentalDirectory, '*.tif'));
    for i = 1:length(experimentalFiles)
        % Read the current experimental TIFF file
        experimentalFilePath = fullfile(experimentalDirectory, experimentalFiles(i).name);
        experimentalData = double(imread(experimentalFilePath));

        % Use the same ROI defined from the baseline
        % Call the defineROI function to get the ROI
        roi = defineROI(experimentalData);

        % Extract fluorescence values in the ROI
        experimentalFluorescenceCurrentFile = experimentalData(roi);

        % Store experimental fluorescence values
        experimentalFluorescence = [experimentalFluorescence; experimentalFluorescenceCurrentFile];
    end

    % Compare the baseline and experimental fluorescence values
    % T-Test
    pValue = ttest2(baselineFluorescence, experimentalFluorescence);

    % Display the result
    fprintf('P-value from t-test: %f\n', pValue);

    % Visualize the distributions
    figure;
    histogram(baselineFluorescence, 'Normalization', 'probability', 'DisplayName', 'Baseline');
    hold on;
    histogram(experimentalFluorescence, 'Normalization', 'probability', 'DisplayName', 'Experimental');
    legend('show');
    title('Comparison of Fluorescence Values');
    xlabel('Fluorescence Values');
    ylabel('Probability');
end
