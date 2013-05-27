close all
% clear
% clc


clear

PM1_InM=[13,10,0];




%%%%Hmi
HmiOptimization=[0.0556    0.0024;0.0070    0.0333];%  3.1615e-04
MyHmi=[-0.0394   -0.0143;  0.0406   -0.7140];% 32.2106
HmiReal=[ 0.0555    0.0024; 0.0070    0.0334];% 3.1620e-04

%%%%%B
MyB=[ -0.0063    0.0094; 0.0030   -0.0592];% 32.2106
BOptimization=[ 0.0079   -0.0002;0.0011    0.0028];% 3.2243e-04


XYZ=[ -1.3003,2.5496,-0.75092]; % MY : 0.076569   0.076367
XYZBest=[ -1.2568,6.1557,-0.26889];


% [ABest]=fminsearch(@(args)CheckParameters( args,PM1_InM),XYZ );
[sumError] =CheckParameters(XYZBest,PM1_InM )
 
 








  