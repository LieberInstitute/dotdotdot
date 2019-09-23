# Mouse RNAscope Workflow

The input [czi](https://github.com/LieberInstitute/dotdotdot/blob/master/images/Mouse1.czi) file has the following channels

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Mouse2-DAPI.jpg" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Mouse2-520.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Mouse2-570.jpg" title="Opal 570" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Mouse2-690.jpg" title="Opal 690" width="225"/> <br/>

The corresponding segmentions from Dotdotdot

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation_DAPI.jpg" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation_EGFP.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation_DsRed.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation_Cy5.jpg" title="Opal 520" width="225"/> <br/>

Download the [toolbox](https://github.com/LieberInstitute/dotdotdot/tree/master/toolbox) directory and assign the paths of input `czi` file and [toolbox](https://github.com/LieberInstitute/dotdotdot/tree/master/toolbox) to Matlab variables as shown below. The [toolbox](https://github.com/LieberInstitute/dotdotdot/tree/master/toolbox) should be added to the Matlab’s current working directory to run the code.

```matlab
>> filename = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdot_vignette/dotdot_vignette/Mouse2.czi';
>> toolbox  = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdot_vignette/dotdot_vignette/toolbox';  
>> addpath(genpath(toolbox)) %adding toolbox path to current working directory
```

The command [rnascope_mouse](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/rnascope_mouse.m) takes in the filename and toolbox as inputs. This command uses [segmct](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/cellsegm-master/%40cellsegm/segmct.m) function from the toolbox [CellSegm](https://www.ncbi.nlm.nih.gov/pubmed/23938087) for nuclei segmentatation. 

The [CellSegm](https://www.ncbi.nlm.nih.gov/pubmed/23938087) toolbox provides the user with several input options for smoothing (coherence enhancing diffusion, edge enhancing diffusion, gaussian) and thresholding (iterative thresholding, adaptive thresholding, gradient thresholding, ridge enhancement). The inputs for [segmct](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/cellsegm-master/%40cellsegm/segmct.m) function are the raw DAPI channe, estimated nucleus size (minimum and maximum in cubic micron) and a matlab structured array called `prm` which takes in the above mentioned options. 

The options given to `prm` suitable for the current mouse data are shown below. 

```matlab
prm.method = 'adth';	% adaptive thresholding
prm.adth.filtrad = 13;  % Filter size for thresholding
prm.adth.th = 0.01;     % threshold
prm.split = 1;          % 1 = split the segmented nuclei, 0 = donot split. 
prm.splitth = 1;        % The amount of splitting is controlled by PRM.SPLITTH where lower values gives stronger splitting.
prm.splitplane = round(Z/2); % Start splitting from the middle plane
prm.h=[voxelSizeX,voxelSizeY,voxelSizeZ]; % x,y,z pixel to um 
minN = 0.038; % minimum nucleus volume in cubic micron given as volume of one voxel for current data
maxN = ((4/3)*(pi)*(Z*0.4/2)^3); % maximum nucleus volume in cubic micron given as volume of sphere with nucleus radius "Z*0.4/2" (the images are taken to approximately cover the depth of a nucleus (Z), so the nucleus radius in cubic micron is (Z/2)*(pixel resolution in Z))
[cellbw1,~,~,~] = cellsegm.segmct(DAPIchannel,minZ,maxZ,'prm',prm);
```

The above `prm` structure is default for the [rnascope_mouse](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/rnascope_mouse.m) function. When the [rnascope_mouse](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/rnascope_mouse.m) is run it produces the following output on command line explaining the process.

```matlab
>> rnascope_mouse(filename, toolbox)
Reading Images:  1  of  72 Frames
Reading Images:  2  of  72 Frames
Reading Images:  3  of  72 Frames
...
Reading Images:  69  of  72 Frames
Reading Images:  70  of  72 Frames
Reading Images:  71  of  72 Frames
Reading Images:  72  of  72 Frames
Elapsed time is 6.512189 seconds.
    "extracted"    "Cy5"    "DsRed"    "EGFP"    "DAPI"
    
segmenting DAPI
This is SEGMCT for segmentation of cytoplasmically stained cells
This is SEGMCT using settings % describing what values and options are used in 'prm'

method          :               adth            
illum           :               0     % correct for any illumination in images (default = 0 (yes), = 1 (no))         
illumdiameter   :               25              
splitth         :               1               
split           :               1               
h               :               0.313       0.313       0.396
just            :               0.9                            
splitplane      :               9               
voxelvol        :               0.038796        
minvol          :               38              
minvolvox       :               979             
maxvol          :               195432.1958     
maxvolvox       :               5037467         
minvolfull      :               38              
maxvolfull      :               195432.1958     
splitvolvox     :               979      

This is SMOOTHIM using settings % using default "gaussian" smoothening filter 
planewise   :           1           
gpu         :           0           
h           :           0.313       0.313       0.396
method      :           gaussian    
Using Gaussian smoothing
Using settings
diameter   :          5  5  3    
stdev      :          2          
Using segmentation method ADTH in SEGMCT % using "adaptive" thresholding
This is SEGMADTH using settings
th          :           0.01        
filtrad     :           13          
h           :           0.313       0.313       0.396
minvolvox   :           979         
maxvolvox   :           5037467     
Splitting cells using distance function
This is SPLITCELLS splitting objects
Number of objects due to splitting: 8
This is SMOOTHIM using settings
planewise   :           1           
gpu         :           0           
h           :           0.313       0.313       0.396
Using Gaussian smoothing
Using settings
diameter   :          9  9       
stdev      :          3          
Number of objects afters splitting: 20
Remove small parts that are not cells
Removed 8 regions due to small size
Removed 0 regions due to large size
Number of objects left: 12
Elapsed time is 52.015566 seconds.
no.of nuclei detected: 14

CHANNEL img.Cy5:  426 dots detected
1 cells finished in time 0.044959s
2 cells finished in time 0.083727s
3 cells finished in time 0.11191s
4 cells finished in time 0.14625s
5 cells finished in time 0.18092s
6 cells finished in time 0.20822s
7 cells finished in time 0.24323s
8 cells finished in time 0.2756s
9 cells finished in time 0.30331s
10 cells finished in time 0.33273s
11 cells finished in time 0.35857s
12 cells finished in time 0.38855s
13 cells finished in time 0.41298s
14 cells finished in time 0.43719s
completed Cy5
CHANNEL img.DsRed:  781 dots detected
1 cells finished in time 0.051917s
2 cells finished in time 0.11335s
3 cells finished in time 0.15307s
4 cells finished in time 0.2112s
5 cells finished in time 0.26617s
6 cells finished in time 0.30689s
7 cells finished in time 0.35975s
8 cells finished in time 0.41578s
9 cells finished in time 0.45942s
10 cells finished in time 0.50974s
11 cells finished in time 0.55287s
12 cells finished in time 0.60081s
13 cells finished in time 0.63754s
14 cells finished in time 0.67165s
completed DsRed
CHANNEL img.EGFP:  284 dots detected
1 cells finished in time 0.027005s
2 cells finished in time 0.051664s
3 cells finished in time 0.072558s
4 cells finished in time 0.098938s
5 cells finished in time 0.12521s
6 cells finished in time 0.14503s
7 cells finished in time 0.16891s
8 cells finished in time 0.19495s
9 cells finished in time 0.21682s
10 cells finished in time 0.23933s
11 cells finished in time 0.25986s
12 cells finished in time 0.29001s
13 cells finished in time 0.31296s
14 cells finished in time 0.33317s
completed EGFP
Elapsed time is 0.334633 seconds.
```
The [rnascope_mouse](https://github.com/LieberInstitute/dotdotdot/blob/master/toolbox/rnascope_mouse.m) function outputs the following four `.mat` files that are saved where the input `.czi` file is located.
These matfiles are matlab structures with each field being a channel from the `.czi` file.

[raw data ~/Mouse2_img.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_img.mat)

```matlab
>> load('~/Mouse2_img.mat')
>> img

img = 

  struct with fields:

      Cy5: [201×201×18 double]
    DsRed: [201×201×18 double]
     EGFP: [201×201×18 double]
     DAPI: [201×201×18 double]
```

[segmented images ~/Mouse2_segmentation.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation.mat)

```matlab
>> load('~/Mouse2_segmentation.mat')
>> Segmentations

Segmentations = 

  struct with fields:

     DAPI: [201×201×18 double]
      Cy5: [201×201×18 logical]
    DsRed: [201×201×18 logical]
     EGFP: [201×201×18 logical]
        
    imshow(max(Segmentations.DAPI,[],3)) %displays the following image
```    
<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_segmentation_DAPI.jpg" title="DAPI" width="225"/> 
    


[total segmented dots in each channel ~/Mouse2_totaldots.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_totaldots.mat)

```matlab
>> load('~/Mouse2_totaldots.mat')
>> excel_totaldots

>> excel_totaldots

excel_totaldots = 

  struct with fields:

     DAPI: [14×9 table]
      Cy5: [426×8 table]
    DsRed: [781×8 table]
     EGFP: [284×8 table]
    
>> head(excel_totaldots.DAPI) %display 1st few rows of this object

ans =

  8×9 table

    Volume             Centroid             BoundingBox       VoxelIdxList         VoxelList          VoxelValues       MeanIntensity    MinIntensity    MaxIntensity
    ______    __________________________    ____________    ________________    ________________    ________________    _____________    ____________    ____________

     8565     62.444     143.6     9.809    [1x6 double]    [ 8565×1 double]    [ 8565×3 double]    [ 8565×1 double]     10628           466             44982       
    11057     162.73    156.14    8.6432    [1x6 double]    [11057×1 double]    [11057×3 double]    [11057×1 double]    9519.9           215             45876       
     2408     5.2022    154.21     8.961    [1x6 double]    [ 2408×1 double]    [ 2408×3 double]    [ 2408×1 double]    7397.1           573             27740       
    12556     108.64    139.28     9.579    [1x6 double]    [12556×1 double]    [12556×3 double]    [12556×1 double]    8743.5           734             50481       
    11766      46.25    106.34    10.424    [1x6 double]    [11766×1 double]    [11766×3 double]    [11766×1 double]     18578           993             65535       
     2829     51.367    196.84    10.746    [1x6 double]    [ 2829×1 double]    [ 2829×3 double]    [ 2829×1 double]    9791.3           718             34668       
    10231     90.073    70.494    9.7296    [1x6 double]    [10231×1 double]    [10231×3 double]    [10231×1 double]     11861           929             57322       
    11066     42.672    26.197    11.052    [1x6 double]    [11066×1 double]    [11066×3 double]    [11066×1 double]     12175           165             64592       

```

[Dots in nuclei per channel ~/Mouse2_dots_of_ROI.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Mouse2_dots_of_ROI.mat)

```matlab
>> load('~/Mouse2_dots_of_ROI.mat')
>> excel_dots_of_ROI

excel_dots_of_ROI = 

  struct with fields:

      Cy5: [14×6 table]
    DsRed: [14×6 table]
     EGFP: [14×6 table]
     
>> head(excel_dots_of_ROI.Cy5) %display 1st few rows of this object
ans =

  8×6 table

     ROI         dotname       count       Volume         Location       Intensity 
    ______    _____________    _____    _____________    ___________    ___________

    'ROI1'    [ 6×1 double]     6       [ 6×1 double]    { 6×1 cell}    { 6×1 cell}
    'ROI2'    [35×1 double]    35       [35×1 double]    {35×1 cell}    {35×1 cell}
    'ROI3'    [ 7×1 double]     7       [ 7×1 double]    { 7×1 cell}    { 7×1 cell}
    'ROI4'    [59×1 double]    59       [59×1 double]    {59×1 cell}    {59×1 cell}
    'ROI5'    [16×1 double]    16       [16×1 double]    {16×1 cell}    {16×1 cell}
    'ROI6'    [ 7×1 double]     7       [ 7×1 double]    { 7×1 cell}    { 7×1 cell}
    'ROI7'    [37×1 double]    37       [37×1 double]    {37×1 cell}    {37×1 cell}
    'ROI8'    [ 4×1 double]     4       [ 4×1 double]    { 4×1 cell}    { 4×1 cell}

```
