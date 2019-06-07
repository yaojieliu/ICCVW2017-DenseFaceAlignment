# ICCVW2018-DenseFaceAlignment
Yaojie Liu, Amin Jourabloo, William Ren, Xiaoming Liu

![alt text](http://www.cse.msu.edu/~liuyaoj1/images/project-iccvw17.png)

[![Watch the video](https://i.imgur.com/vKb2F1B.png)](https://www.youtube.com/watch?v=GjwpvHKHf9U)

## Setup
1. Download the [Basel Face Model (BFM)](http://faces.cs.unibas.ch/bfm/main.php?nav=1-0&id=basel_face_model)
2. unzip the file into the root folder

## Testing
Run the "test.m". 

If you are the first time to use the code, please configure and run the "vl_compilenn.m" according to your system configurations.

To note:

The testing code is tested on Matlab 2016b/2017a/2017b @ Ubuntu 16.04 with GPU. If you are using Windows system, please
change the slash in the file path to backslash to match the Windows path naming.
The code is built on [MatConvNet](http://www.vlfeat.org/matconvnet). Please refer to their web page for any compiling issues.

## Acknowledge
Please cite the paper:

    @inproceedings{iccvw17liu,
        title={Dense Face Alignment},
        author={Yaojie Liu, Amin Jourabloo, William Ren, Xiaoming Liu},
        booktitle={In Proceeding of International Conference on Computer Vision Workshop (ICCVW 2017)},
        address={Venice, Italy},
        year={2017}
    }   
   
If you have any question, please contact: [Yaojie Liu](liuyaoj1@cse.msu.edu)
