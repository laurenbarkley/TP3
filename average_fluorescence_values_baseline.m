% Function imput
videoFileName = 'your_video_file.tif';
ComputeFluorescenceChange(videoFileName);

function fluorescenceChange = ComputeFluorescenceChange(videoFileName)
    % Read the TIFF video file
    videoObj = VideoReader(videoFileName);

    % Get video properties
    frame_num = videoObj.NumFrames;
    frameSize = [videoObj.Height, videoObj.Width];

    % Initialize fluorescence change array
    fluorescenceChange = zeros(frameSize);
    

    % Loop through frames and compute fluorescence change
    for frameNumber = 2:frame_num
        % Read current and previous frames
        currentFrame = double(read(videoObj, frame_num));
        previousFrame = double(read(videoObj, frame_num - 1));

        % Compute fluorescence change
        frameDiff = currentFrame - previousFrame;
        fluorescenceChange = fluorescenceChange + abs(frameDiff);
    end
    if frame_num>60
end 

    % Display the average fluorescence changes
    baseline = fluorescenceChange / (frame_num - 1);
    frameSize(zeros(baseline));
    imagedisplay(baseline(:, :, 1))
    figure;
    imshow(uint8(averageChange), []);
    title('Average Fluorescence Change');

    % Save the average fluorescence change to a file
    imwrite(uint8(averageChange), 'average_fluorescence_change.tif');
end 
    