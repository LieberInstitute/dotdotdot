# Mouse RNAscope Workflow

```matlab
>> toolbox = '/Volumes/Neural_Plasticity/Maddy/dotdot_vignette/toolbox';
>> filename = '/Volumes/Neural_Plasticity/Maddy/dotdot_vignette/Mouse1.czi';
>> rnascope_mouse(filename, toolbox)
Reading Images:  1  of  56 Frames
Reading Images:  2  of  56 Frames
Reading Images:  3  of  56 Frames
Reading Images:  4  of  56 Frames
Reading Images:  5  of  56 Frames
Reading Images:  6  of  56 Frames
Reading Images:  7  of  56 Frames
Reading Images:  8  of  56 Frames
Reading Images:  9  of  56 Frames
Reading Images:  10  of  56 Frames
Reading Images:  11  of  56 Frames
Reading Images:  12  of  56 Frames
Reading Images:  13  of  56 Frames
Reading Images:  14  of  56 Frames
Reading Images:  15  of  56 Frames
Reading Images:  16  of  56 Frames
Reading Images:  17  of  56 Frames
Reading Images:  18  of  56 Frames
Reading Images:  19  of  56 Frames
Reading Images:  20  of  56 Frames
Reading Images:  21  of  56 Frames
Reading Images:  22  of  56 Frames
Reading Images:  23  of  56 Frames
Reading Images:  24  of  56 Frames
Reading Images:  25  of  56 Frames
Reading Images:  26  of  56 Frames
Reading Images:  27  of  56 Frames
Reading Images:  28  of  56 Frames
Reading Images:  29  of  56 Frames
Reading Images:  30  of  56 Frames
Reading Images:  31  of  56 Frames
Reading Images:  32  of  56 Frames
Reading Images:  33  of  56 Frames
Reading Images:  34  of  56 Frames
Reading Images:  35  of  56 Frames
Reading Images:  36  of  56 Frames
Reading Images:  37  of  56 Frames
Reading Images:  38  of  56 Frames
Reading Images:  39  of  56 Frames
Reading Images:  40  of  56 Frames
Reading Images:  41  of  56 Frames
Reading Images:  42  of  56 Frames
Reading Images:  43  of  56 Frames
Reading Images:  44  of  56 Frames
Reading Images:  45  of  56 Frames
Reading Images:  46  of  56 Frames
Reading Images:  47  of  56 Frames
Reading Images:  48  of  56 Frames
Reading Images:  49  of  56 Frames
Reading Images:  50  of  56 Frames
Reading Images:  51  of  56 Frames
Reading Images:  52  of  56 Frames
Reading Images:  53  of  56 Frames
Reading Images:  54  of  56 Frames
Reading Images:  55  of  56 Frames
Reading Images:  56  of  56 Frames
Elapsed time is 8.432484 seconds.
    "extracted"    "Cy5"    "DsRed"    "EGFP"    "DAPI"




segmenting DAPI
This is SEGMCT for segmentation of cytoplasmically stained cells
This is SEGMCT using settings
method          :               adth            
illum           :               0               
illumdiameter   :               25              
splitth         :               1               
split           :               1               
h               :               0.313       0.313       0.396
just            :               0.9             
planewise       :               0               
splitplane      :               7               
voxelvol        :               0.038796        
minvol          :               38              
minvolvox       :               979             
maxvol          :               91952.3226      
maxvolvox       :               2370166         
minvolfull      :               38              
maxvolfull      :               91952.3226      
splitvolvox     :               979             
This is SMOOTHIM using settings
planewise   :           1           
gpu         :           0           
h           :           0.313       0.313       0.396
method      :           gaussian    
Using Gaussian smoothing
Using settings
diameter   :          5  5  3    
stdev      :          2          
Using segmentation method ADTH in SEGMCT
This is SEGMADTH using settings
th          :           0.01        
filtrad     :           13          
h           :           0.313       0.313       0.396
minvolvox   :           979         
maxvolvox   :           2370166     
Splitting cells using distance function
This is SPLITCELLS splitting objects
Number of objects due to splitting: 11
This is SMOOTHIM using settings
planewise   :           1           
gpu         :           0           
h           :           0.313       0.313       0.396
Using Gaussian smoothing
Using settings
diameter   :          9  9       
stdev      :          3          
Number of objects afters splitting: 32
Remove small parts that are not cells
Removed 17 regions due to small size
Removed 0 regions due to large size
Number of objects left: 15
Elapsed time is 52.609018 seconds.
no.of nuclei detected: 18
CHANNEL img.Cy5:  197 dots detected
1 cells finished in time 0.089916s
2 cells finished in time 0.15175s
3 cells finished in time 0.17971s
4 cells finished in time 0.19982s
5 cells finished in time 0.22093s
6 cells finished in time 0.25515s
7 cells finished in time 0.28704s
8 cells finished in time 0.31558s
9 cells finished in time 0.33993s
10 cells finished in time 0.3665s
11 cells finished in time 0.38797s
12 cells finished in time 0.41038s
13 cells finished in time 0.42822s
14 cells finished in time 0.4534s
15 cells finished in time 0.47089s
16 cells finished in time 0.49097s
17 cells finished in time 0.50986s
18 cells finished in time 0.52831s
completed Cy5
CHANNEL img.DsRed:  209 dots detected
1 cells finished in time 0.021619s
2 cells finished in time 0.043223s
3 cells finished in time 0.069977s
4 cells finished in time 0.094432s
5 cells finished in time 0.11648s
6 cells finished in time 0.14037s
7 cells finished in time 0.16431s
8 cells finished in time 0.18853s
9 cells finished in time 0.20938s
10 cells finished in time 0.23201s
11 cells finished in time 0.25191s
12 cells finished in time 0.27883s
13 cells finished in time 0.29779s
14 cells finished in time 0.31538s
15 cells finished in time 0.331s
16 cells finished in time 0.34819s
17 cells finished in time 0.36806s
18 cells finished in time 0.39029s
completed DsRed
CHANNEL img.EGFP:  81 dots detected
1 cells finished in time 0.011321s
2 cells finished in time 0.024802s
3 cells finished in time 0.037123s
4 cells finished in time 0.04863s
5 cells finished in time 0.061743s
6 cells finished in time 0.076748s
7 cells finished in time 0.092096s
8 cells finished in time 0.10681s
9 cells finished in time 0.11907s
10 cells finished in time 0.13159s
11 cells finished in time 0.14399s
12 cells finished in time 0.1596s
13 cells finished in time 0.17024s
14 cells finished in time 0.18351s
15 cells finished in time 0.19526s
16 cells finished in time 0.20945s
17 cells finished in time 0.22101s
18 cells finished in time 0.23408s
completed EGFP
Elapsed time is 0.236000 seconds.
```
