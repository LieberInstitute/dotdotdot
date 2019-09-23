# Human RNAscope Workflow

The input [czi](https://github.com/LieberInstitute/dotdotdot/blob/master/images/Human1.czi) file has the following channels

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-DAPI.png" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-520.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-570.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-620.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-690.png" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/MAX_Human2-Lip.png" title="Opal 520" width="225"/> <br/>

The corresponding segmentions from Dotdotdot

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_DAPILp3.jpg" title="DAPI" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal520_Lp20.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal570Lp1_0.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal620_Lp20.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_Opal690Lp30.jpg" title="Opal 520" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/output/Human2_segmentation_No103_Lipofuscin_63x.jpg" title="Opal 520" width="225"/> <br/>

Download the [toolbox](https://github.com/LieberInstitute/dotdotdot/tree/master/toolbox) directory and assign the paths of input `czi` file and toolbox to Matlab variables as shown below. The toolbox should be added to the Matlab’s current working directory to run the code.

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
...
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
>> load('~/Human2_segmentation.mat')
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

    'ROI1'    [         18]     1       [         68]    { 1×1 cell}    { 1×1 cell}
    'ROI2'    [ 8×1 double]     8       [ 8×1 double]    { 8×1 cell}    { 8×1 cell}
    'ROI3'    [ 2×1 double]     2       [ 2×1 double]    { 2×1 cell}    { 2×1 cell}
    'ROI4'    [13×1 double]    13       [13×1 double]    {13×1 cell}    {13×1 cell}
    'ROI5'    [12×1 double]    12       [12×1 double]    {12×1 cell}    {12×1 cell}

```
The above matlab tables for all the images are consolidated into single R dataframe like below, where RVolume is volume of ROI, P520 is number of ROI pixels covered with gene in channel 520, MP520 is number of ROI pixels covered with gene in channel 520 after lipofuscin masking, MI_P520 is mean intensity of ROI pixels covered with gene, MI_MP520 is mean intensity of ROI pixels covered with gene after lipofuscin masking, PP520 is proportion of ROI covered with 520 pixels.

```R
head(long_Dat)
                        name RVolume P520 MP520  MI_P520 MI_MP520 P570 MP570
1 Br1350_Strip1_Layer2and3_1   16727    8     8  9682.75  9682.75 2577  2567
2 Br1350_Strip1_Layer2and3_1   17243  138   135 11582.46 11612.07   31    31
3 Br1350_Strip1_Layer2and3_1    4829   13    13 12051.08 12051.08  468   468
4 Br1350_Strip1_Layer2and3_1   35946  135   135 12042.07 12042.07 6788  6776
5 Br1350_Strip1_Layer2and3_1   15994  239   175 11340.56 11220.83   59    57
6 Br1350_Strip1_Layer2and3_1   43408 4968  4963 14307.84 14312.59   60    60
   MI_P570 MI_MP570 P620 MP620  MI_P620 MI_MP620  P690 MP690  MI_P690 MI_MP690
1 20413.50 20410.38    1     1 5824.000 5824.000  9744  9734 6110.654 6111.147
2 18010.06 18010.06 1960  1943 9555.410 9544.715  7287  7272 4856.068 4857.804
3 20599.55 20599.55    0     0    0.000    0.000   937   937 3875.629 3875.629
4 21536.88 21540.04   11    11 9725.455 9725.455 11979 11978 4947.050 4947.152
5 15772.75 15915.42    0     0    0.000    0.000     3     3 3012.000 3012.000
6 15815.37 15815.37    6     6 6966.500 6966.500    27    26 3766.519 3794.808
         PP520       PP570        PP620        PP690      Layer  ROI Rcluster
1 0.0004782687 0.153464459 5.978358e-05 0.5819334011 Layer2and3 ROI1  SLC17A7
2 0.0078292640 0.001797831 1.126834e-01 0.4217363568 Layer2and3 ROI2     GAD1
3 0.0026920688 0.096914475 0.000000e+00 0.1940360323 Layer2and3 ROI3  SLC17A7
4 0.0037556335 0.188504980 3.060146e-04 0.3332220553 Layer2and3 ROI4  SLC17A7
5 0.0109416031 0.003563836 0.000000e+00 0.0001875703 Layer2and3 ROI5      Neg
6 0.1143337634 0.001382234 1.382234e-04 0.0005989679 Layer2and3 ROI6      MBP
   Brain
1 Br1350
2 Br1350
3 Br1350
4 Br1350
5 Br1350
6 Br1350
```
A test and train dataset is created from a couple of randomnly selected and manually annotated images like below.

<img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/manually_annotated_image.png" title="Manually annoatted" width="225"/> <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/manually_annotated_dataset.png" width="225"/>

Of 89 ROIs from above dataset, 60 random ROIs were used as training dataset and the remaining as test dataset for [CART](https://www.statmethods.net/advstats/cart.html) modelling.

```R

library(rpart)
library(rpart.plot)

s = sample(1:89, 60)
aa_train = manually_annotated[s,]
aa_test = manually_annotated[-s,]

head(aa_test)
                       name RVolume       PP520       PP570       PP620
530 Br1350_Strip2_LayerVI_1   18242 0.008551694 0.248711764 0.003124657
532 Br1350_Strip2_LayerVI_1    9313 0.312895952 0.043380221 0.000000000
536 Br1350_Strip2_LayerVI_1   26877 0.001227816 0.174796294 0.003646240
537 Br1350_Strip2_LayerVI_1    9021 0.002882164 0.003768983 0.000000000
540 Br1350_Strip2_LayerVI_1   14528 0.003716960 0.000000000 0.000000000
543 Br1350_Strip2_LayerVI_1     931 0.000000000 0.272824919 0.000000000
         PP690 cluster Kcluster 
530 0.31723495       r  SLC17A7   
532 0.02544830       g      MBP   
536 0.36120103       r  SLC17A7    
537 0.01263718       n     Glia   
540 0.00000000       n     Glia    
543 0.68528464       r  SLC17A7  

head(aa_train)
                       name RVolume       PP520        PP570        PP620
527 Br1350_Strip2_LayerVI_1   13293 0.339501994 0.0382908298 0.0005265929
528 Br1350_Strip2_LayerVI_1   79877 0.040186787 0.0254391126 0.0004381737
529 Br1350_Strip2_LayerVI_1   28124 0.015289433 0.2272080785 0.0016711705
531 Br1350_Strip2_LayerVI_1   19632 0.007436838 0.0005093725 0.0000000000
533 Br1350_Strip2_LayerVI_1   15278 0.058777327 0.0000000000 0.0000000000
534 Br1350_Strip2_LayerVI_1   10640 0.016165414 0.0002819549 0.0000000000
         PP690 cluster Kcluster
527 0.02362145       g      MBP
528 0.06294678       n     Glia
529 0.40044090       n     Glia
531 0.00000000       n     Glia
533 0.00000000       n     Glia
534 0.00000000       n     Glia


fit = rpart(Kcluster~PP520+PP570+PP620, method = "class", data = aa_train)

 fit
n= 60 

node), split, n, loss, yval, (yprob)
      * denotes terminal node

 1) root 60 40 SLC17A7 (0.21666667 0.33333333 0.13333333 0.31666667)  
   2) PP570>=0.04282934 21  2 SLC17A7 (0.04761905 0.90476190 0.00000000 0.04761905) *
   3) PP570< 0.04282934 39 21 Glia (0.30769231 0.02564103 0.20512821 0.46153846)  
     6) PP520>=0.07558398 11  0 MBP (1.00000000 0.00000000 0.00000000 0.00000000) *
     7) PP520< 0.07558398 28 10 Glia (0.03571429 0.03571429 0.28571429 0.64285714)  
      14) PP620>=0.0007935354 9  1 GAD1 (0.00000000 0.00000000 0.88888889 0.11111111) *
      15) PP620< 0.0007935354 19  2 Glia (0.05263158 0.05263158 0.00000000 0.89473684) *

aa_test$rcluster = predict(fit, aa_test, type = "class") #cell labels for whole dataset are similary predicted

aa_test #Kcluster(manually annotated) Rcluster(CART predicted)

                       name RVolume        PP520        PP570        PP620
530  Br1350_Strip2_LayerVI_1   18242 8.551694e-03 0.2487117641 3.124657e-03
532  Br1350_Strip2_LayerVI_1    9313 3.128960e-01 0.0433802212 0.000000e+00
536  Br1350_Strip2_LayerVI_1   26877 1.227816e-03 0.1747962942 3.646240e-03
537  Br1350_Strip2_LayerVI_1    9021 2.882164e-03 0.0037689835 0.000000e+00
540  Br1350_Strip2_LayerVI_1   14528 3.716960e-03 0.0000000000 0.000000e+00
543  Br1350_Strip2_LayerVI_1     931 0.000000e+00 0.2728249194 0.000000e+00
546  Br1350_Strip2_LayerVI_1   10737 3.725435e-03 0.0000000000 1.015181e-01
551  Br1350_Strip2_LayerVI_1    1034 0.000000e+00 0.1972920696 0.000000e+00
554  Br1350_Strip2_LayerVI_1   18926 3.011730e-03 0.0000000000 2.604882e-02
555  Br1350_Strip2_LayerVI_1    8863 3.272030e-03 0.0875550039 0.000000e+00
566  Br1350_Strip2_LayerVI_2   13898 5.445388e-01 0.0016549144 0.000000e+00
567  Br1350_Strip2_LayerVI_2   14462 1.329000e-01 0.0005531738 0.000000e+00
572  Br1350_Strip2_LayerVI_2   11646 7.727975e-04 0.0000000000 0.000000e+00
590  Br1350_Strip2_LayerVI_3   18465 1.949634e-03 0.3502301652 2.166260e-03
598  Br1350_Strip2_LayerVI_3    5005 6.993007e-03 0.0003996004 0.000000e+00
600  Br1350_Strip2_LayerVI_3    9525 2.099738e-04 0.0012598425 0.000000e+00
606  Br1350_Strip2_LayerVI_3    9989 6.086695e-02 0.0000000000 3.286615e-01
1038 Br1531_Strip2_LayerVI_5   27500 4.094545e-02 0.2513454545 5.090909e-04
1040 Br1531_Strip2_LayerVI_5   22390 1.514069e-02 0.0213488164 4.466280e-05
1046 Br1531_Strip2_LayerVI_5   12168 6.163708e-03 0.0004109139 0.000000e+00
1047 Br1531_Strip2_LayerVI_5   50302 1.013876e-03 0.1960160630 8.349569e-04
1077 Br1531_Strip2_LayerVI_6   21493 0.000000e+00 0.0000000000 1.543758e-01
1080 Br1531_Strip2_LayerVI_6   25736 6.294684e-03 0.0000000000 3.885608e-05
1081 Br1531_Strip2_LayerVI_6   29854 9.713941e-04 0.0520198298 0.000000e+00
1083 Br1531_Strip2_LayerVI_6   10081 3.852792e-01 0.0000000000 0.000000e+00
1084 Br1531_Strip2_LayerVI_6   37827 5.142094e-01 0.0018240939 0.000000e+00
1089 Br1531_Strip2_LayerVI_6    9213 0.000000e+00 0.1157060675 0.000000e+00
1093 Br1531_Strip2_LayerVI_6   33521 2.983205e-05 0.0792339131 0.000000e+00
1094 Br1531_Strip2_LayerVI_6   16865 7.596205e-01 0.0000000000 0.000000e+00
            PP690 cluster Kcluster Rcluster
530  0.3172349523       r  SLC17A7  SLC17A7
532  0.0254482981       g      MBP  SLC17A7
536  0.3612010269       r  SLC17A7  SLC17A7
537  0.0126371799       n     Glia     Glia
540  0.0000000000       n     Glia     Glia
543  0.6852846402       r  SLC17A7  SLC17A7
546  0.1996833380       p     GAD1     GAD1
551  0.7823984526       r  SLC17A7  SLC17A7
554  0.5700095107       p     GAD1     GAD1
555  0.2998984542       r  SLC17A7  SLC17A7
566  0.0048208375       g      MBP      MBP
567  0.0000000000       g      MBP      MBP
572  0.0000000000       n     Glia     Glia
590  0.2777145952       r  SLC17A7  SLC17A7
598  0.0000000000       n     Glia     Glia
600  0.0000000000       n     Glia     Glia
606  0.4500951046       p     GAD1     GAD1
1038 0.4776000000       r  SLC17A7  SLC17A7
1040 0.0648503796       r  SLC17A7     Glia
1046 0.0023011177       n     Glia     Glia
1047 0.2858136853       r  SLC17A7  SLC17A7
1077 0.2703205695       p     GAD1     GAD1
1080 0.0001165682       n     Glia     Glia
1081 0.0751993033       r  SLC17A7  SLC17A7
1083 0.0000000000       g      MBP      MBP
1084 0.0116583393       g      MBP      MBP
1089 0.3992184956       r  SLC17A7  SLC17A7
1093 0.2989767608       r  SLC17A7  SLC17A7
1094 0.0000000000       g      MBP      MBP
```
CART tree <img src="https://github.com/LieberInstitute/dotdotdot/blob/master/images/CART.png" title="CART" width="225"/> 
