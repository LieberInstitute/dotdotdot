# Human RNAscope Workflow

The input [czi](https://github.com/LieberInstitute/dotdotdot/blob/master/images/Human1.czi) file has the following channels

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-DAPI.png" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-520.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-570.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-620.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-690.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-Lip.png" title="Opal 520" width="225"/> <br/>

The corresponding segmentions

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_DAPILp3.jpg" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal520_Lp20.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal570Lp1_0.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal620_Lp20.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal690Lp30.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_No103_Lipofuscin_63x.jpg" title="Opal 520" width="225"/> <br/>

Download the [toolbox](https://github.com/LieberInstitute/dotdotdot/tree/master/toolbox) directory and assign the paths to input `czi` file and toolbox to Matlab variables as shown below. The toolbox should be added to the Matlab’s current working directory to run the code.

``` matlab
>> filename = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdot_vignette/dotdot_vignette/Human2.czi';
>> toolbox  = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdot_vignette/dotdot_vignette/toolbox';  
>> addpath(genpath(toolbox)) %adding toolbox path to current working directory
```

The command ‘rnascope_human’ takes in the filename and toolbox as inputs.

```matlab
>> rnascope_human(filename, toolbox)

Reading Images:  1  of  70 Frames
Reading Images:  2  of  70 Frames
Reading Images:  3  of  70 Frames
Reading Images:  4  of  70 Frames
Reading Images:  5  of  70 Frames
Reading Images:  6  of  70 Frames
Reading Images:  7  of  70 Frames
Reading Images:  8  of  70 Frames
Reading Images:  9  of  70 Frames
Reading Images:  10  of  70 Frames
Reading Images:  11  of  70 Frames
Reading Images:  12  of  70 Frames
Reading Images:  13  of  70 Frames
Reading Images:  14  of  70 Frames
Reading Images:  15  of  70 Frames
Reading Images:  16  of  70 Frames
Reading Images:  17  of  70 Frames
Reading Images:  18  of  70 Frames
Reading Images:  19  of  70 Frames
Reading Images:  20  of  70 Frames
Reading Images:  21  of  70 Frames
Reading Images:  22  of  70 Frames
Reading Images:  23  of  70 Frames
Reading Images:  24  of  70 Frames
Reading Images:  25  of  70 Frames
Reading Images:  26  of  70 Frames
Reading Images:  27  of  70 Frames
Reading Images:  28  of  70 Frames
Reading Images:  29  of  70 Frames
Reading Images:  30  of  70 Frames
Reading Images:  31  of  70 Frames
Reading Images:  32  of  70 Frames
Reading Images:  33  of  70 Frames
Reading Images:  34  of  70 Frames
Reading Images:  35  of  70 Frames
Reading Images:  36  of  70 Frames
Reading Images:  37  of  70 Frames
Reading Images:  38  of  70 Frames
Reading Images:  39  of  70 Frames
Reading Images:  40  of  70 Frames
Reading Images:  41  of  70 Frames
Reading Images:  42  of  70 Frames
Reading Images:  43  of  70 Frames
Reading Images:  44  of  70 Frames
Reading Images:  45  of  70 Frames
Reading Images:  46  of  70 Frames
Reading Images:  47  of  70 Frames
Reading Images:  48  of  70 Frames
Reading Images:  49  of  70 Frames
Reading Images:  50  of  70 Frames
Reading Images:  51  of  70 Frames
Reading Images:  52  of  70 Frames
Reading Images:  53  of  70 Frames
Reading Images:  54  of  70 Frames
Reading Images:  55  of  70 Frames
Reading Images:  56  of  70 Frames
Reading Images:  57  of  70 Frames
Reading Images:  58  of  70 Frames
Reading Images:  59  of  70 Frames
Reading Images:  60  of  70 Frames
Reading Images:  61  of  70 Frames
Reading Images:  62  of  70 Frames
Reading Images:  63  of  70 Frames
Reading Images:  64  of  70 Frames
Reading Images:  65  of  70 Frames
Reading Images:  66  of  70 Frames
Reading Images:  67  of  70 Frames
Reading Images:  68  of  70 Frames
Reading Images:  69  of  70 Frames
Reading Images:  70  of  70 Frames
extracted
    'DAPILp3'
    'Opal520_Lp20'
    'Opal570Lp1_0'
    'Opal620_LP10'
    'Opal690Lp30'
    'No103_Lipofuscin_63x'

Elapsed time is 5.250257 seconds.
segmented DAPILp3: 5
segmented Opal520_Lp20: 155
segmented Opal570Lp1_0: 122
segmented Opal620_LP10: 2048
segmented Opal690Lp30: 954
segmented No103_Lipofuscin_63x: 176

Completed Masking DAPILp3
Completed Masking Opal520_Lp20
Completed Masking Opal570Lp1_0
Completed Masking Opal620_LP10
Completed Masking Opal690Lp30
Completed Masking No103_Lipofuscin_63x

Started Opal520_Lp20
1 cells finished in time 0.57048s
2 cells finished in time 0.80605s
3 cells finished in time 0.89423s
4 cells finished in time 0.98938s
5 cells finished in time 1.0881s
Started Opal570Lp1_0
1 cells finished in time 0.12922s
2 cells finished in time 0.19549s
3 cells finished in time 0.27868s
4 cells finished in time 0.33056s
5 cells finished in time 0.38089s
Started Opal620_LP10
1 cells finished in time 0.8361s
2 cells finished in time 1.6512s
3 cells finished in time 2.4203s
4 cells finished in time 3.0615s
5 cells finished in time 3.7481s
Started Opal690Lp30
1 cells finished in time 0.37236s
2 cells finished in time 0.75768s
3 cells finished in time 1.1484s
4 cells finished in time 1.4843s
5 cells finished in time 1.8443s
```

The above function outputs the following four `.mat` files that are saved where the input `.czi` file is located.
These matfiles are matlab structures with each field being a channel from the `.czi` file.

[raw data ~/Human2_img.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_img.mat)

```matlab
>> load('~/Human2_img.mat')
>> img

img = 

  struct with fields:

                 DAPILp3: [401×401×10 double]
            Opal520_Lp20: [401×401×10 double]
            Opal570Lp1_0: [401×401×10 double]
            Opal620_LP10: [401×401×10 double]
             Opal690Lp30: [401×401×10 double]
    No103_Lipofuscin_63x: [401×401×10 double]
```

[segmented images ~/Human2_segmentation.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation.mat)
This matfile has two matlab structures `Segmentations`(before masking) and `Segmentation_m`(after masking) 

```matlab
>> load('~/Human2_Segmentations.mat')
>> Segmentations

Segmentations = 

  struct with fields:

                 DAPILp3: [401×401×10 logical]
            Opal520_Lp20: [401×401×10 logical]
            Opal570Lp1_0: [401×401×10 logical]
            Opal620_LP10: [401×401×10 logical]
             Opal690Lp30: [401×401×10 logical]
    No103_Lipofuscin_63x: [401×401×10 logical]
    
>> Segmentations_m

Segmentations_m = 

  struct with fields:

                 DAPILp3: [401×401×10 logical]
            Opal520_Lp20: [401×401×10 logical]
            Opal570Lp1_0: [401×401×10 logical]
            Opal620_LP10: [401×401×10 logical]
             Opal690Lp30: [401×401×10 logical]
    No103_Lipofuscin_63x: [401×401×10 logical]
    
    imshow(max(Segmentations_m.DAPILp3,[],3)) %displays the following image
```    
<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_DAPILp3.jpg" title="DAPI" width="225"/> 
    


[total segmented dots in each channel ~/Human2_totaldots.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_totaldots.mat)
This matfile has two matlab structures `excel_totaldots`(before masking) and `excel_totaldots_mask`(after masking) 

```matlab
>> load('~/Human2_totaldots.mat')
>> excel_totaldots

excel_totaldots = 

  struct with fields:

                 DAPILp3: [5×9 table]
            Opal520_Lp20: [155×9 table]
            Opal570Lp1_0: [122×9 table]
            Opal620_LP10: [2048×9 table]
             Opal690Lp30: [954×9 table]
    No103_Lipofuscin_63x: [36×9 table]

>> excel_totaldots_mask

excel_totaldots_mask = 

  struct with fields:

                 DAPILp3: [5×9 table]
            Opal520_Lp20: [155×9 table]
            Opal570Lp1_0: [122×9 table]
            Opal620_LP10: [2052×9 table]
             Opal690Lp30: [956×9 table]
    No103_Lipofuscin_63x: [0×9 table]
    
>> head(excel_totaldots_mask.DAPILp3) %display 1st few rows of this object

ans =

  5×9 table

    Volume             Centroid             BoundingBox       VoxelIdxList         VoxelList          VoxelValues       MeanIntensity    MinIntensity    MaxIntensity
    ______    __________________________    ____________    ________________    ________________    ________________    _____________    ____________    ____________

    14364     36.124    176.07     3.239    [1x6 double]    [14364×1 double]    [14364×3 double]    [14364×1 double]      9792           299             21394       
    19069     155.55     105.2    4.0746    [1x6 double]    [19069×1 double]    [19069×3 double]    [19069×1 double]     11305             0             26782       
    15332     251.43    86.285     4.709    [1x6 double]    [15332×1 double]    [15332×3 double]    [15332×1 double]     10413           276             26705       
    10391     109.15    144.16    4.5714    [1x6 double]    [10391×1 double]    [10391×3 double]    [10391×1 double]    9469.1             0             18883       
     7506     304.23    92.893    4.6102    [1x6 double]    [ 7506×1 double]    [ 7506×3 double]    [ 7506×1 double]     10138            81             22527       

```

[Dots in nuclei per channel ~/Human2_dots_of_ROI.mat](https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_dots_of_ROI.mat)
This matfile has two matlab structures `excel_dots_of_ROI`(before masking) and `excel_dots_of_ROI_mask`(after masking)

```matlab
>> load('~/Human2_dots_of_ROI.mat')
>> excel_dots_of_ROI

excel_dots_of_ROI = 

  struct with fields:

    Opal520_Lp20: [5×6 table]
    Opal570Lp1_0: [5×6 table]
    Opal620_LP10: [5×6 table]
    Opal690Lp30: [5×6 table]
    
>> excel_dots_of_ROI_mask

excel_dots_of_ROI_mask = 

  struct with fields:

    Opal520_Lp20: [5×6 table]
    Opal570Lp1_0: [5×6 table]
    Opal620_LP10: [5×6 table]
    Opal690Lp30: [5×6 table]
     
>> head(excel_dots_of_ROI_mask.Opal520_Lp20) %display 1st few rows of this object
ans =

  5×6 table

       ROI           dotname       count       Volume         Location       Intensity 
    __________    _____________    _____    _____________    ___________    ___________

    {'ROI1'}    [         18]     1       [         68]    { 1×1 cell}    { 1×1 cell}
    {'ROI2'}    [ 8×1 double]     8       [ 8×1 double]    { 8×1 cell}    { 8×1 cell}
    {'ROI3'}    [ 2×1 double]     2       [ 2×1 double]    { 2×1 cell}    { 2×1 cell}
    {'ROI4'}    [13×1 double]    13       [13×1 double]    {13×1 cell}    {13×1 cell}
    {'ROI5'}    [12×1 double]    12       [12×1 double]    {12×1 cell}    {12×1 cell}

```


