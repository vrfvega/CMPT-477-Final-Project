function edgeImage = laplacian2_edge_detection(inputImage, edgeType)
   if nargin < 2
       error('Both input image and edge type are required');
   end
   
   inputImage = double(inputImage);
   
   [rows, cols] = size(inputImage);
   
   edgeImage = zeros(rows, cols);
   
   for y = 2:rows-1
       for x = 2:cols-1
           switch lower(edgeType)
               case 'upward'
                   lap2 = inputImage(y-1,x-1) + inputImage(y-1,x+1) + ...
                          inputImage(y+1,x-1) + inputImage(y+1,x+1) - ...
                          4 * inputImage(y,x);
                   edgeImage(y,x) = (lap2 > 0);
               case 'downward'
                   lap2 = inputImage(y-1,x-1) + inputImage(y-1,x+1) + ...
                          inputImage(y+1,x-1) + inputImage(y+1,x+1) - ...
                          4 * inputImage(y,x);
                   edgeImage(y,x) = (lap2 < 0);
               otherwise
                   error('Edge type must be ''upward'' or ''downward''');
           end
       end
   end
end

img = imread('Bridge.tif');

if size(img, 3) > 1
   img = rgb2gray(img);
end

upward_edges = laplacian2_edge_detection(img, 'upward');
downward_edges = laplacian2_edge_detection(img, 'downward');

figure;
imshow(img), title('Original Image');
figure;
imshow(upward_edges), title('Upward Edges');
figure;
imshow(downward_edges), title('Downward Edges');

