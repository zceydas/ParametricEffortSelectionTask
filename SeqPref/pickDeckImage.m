function [img,imgtile,imgfix,imgfixtile]=pickDeckImage(IDletter1,IDletter2,context)
if isempty(IDletter1) % Learning Phase 
    [img] =  imread([context, 'Card'],'png');
    [imgtile] = imread([context, 'Tile'],'png'); 
else % Decision Phase
    [img] =  imread([IDletter1, 'Card'],'png');
    [imgtile] = imread([IDletter1, 'Tile'],'png');
    [imgfix] = imread([IDletter2, 'Card'],'png');
    [imgfixtile] = imread([IDletter2, 'Tile'],'png');
end