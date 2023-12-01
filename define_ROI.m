% Read an image
image = imread('your_image.jpg');  % Replace 'your_image.jpg' with the actual image file

% Define the ROI
roi = defineROI(image);
function roi = defineroi(image)
    % Display the image
    figure;
    imshow(image);
    plot(defineroi(image))
    title('Define Region of Interest');

    % Use roipoly to interactively define the ROI
    roi = roipoly;

    % Close the figure after ROI definition
    close(gcf);
end 