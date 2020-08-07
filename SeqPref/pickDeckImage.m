function [img,imgtile,imgfix,imgfixtile]=pickDeckImage(IDletter1,IDletter2,context)
if isempty(IDletter1) % Learning Phase 
    [img] =  imread([context, 'Card'],'jpg');
    [imgtile] = imread([context, 'Tile'],'jpg'); 
else % Decision Phase
    [img] =  imread([IDletter1, 'Card'],'jpg');
    [imgtile] = imread([IDletter1, 'Tile'],'jpg');
    [imgfix] = imread([IDletter2, 'Card'],'jpg');
    [imgfixtile] = imread([IDletter2, 'Tile'],'jpg');
end