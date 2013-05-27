
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Rozenfled');
addpath('C:\Users\SAAR\MATLAB\Computer Vision\Simulation');
Hmi=[   -0.0026   -0.0176;   0.0183   -0.0022];
Hsi=[0.020407    0.0050018; 0.0014665    -0.024758];

HmsRealFromHmi=pinv(Hsi)*Hmi; %from Hmi

HmsReal=[  0.0508   -0.7348;  -0.8654    0.0369];% from optimiztion

HmsReal=HmsRealFromHmi;


ThetaIn= 0.7656;
a=0;
b=0;
c=0;
s =40.7631;
p0Norm =16.6402;
MyXYms=[ -0.0842   -1.4206   -1.7842]; 
XYmsBest=[  -0.0912   -1.6000   -2.9919];% from optimization
XYmsBest=[-0.1588   -1.6530   -3.3382]; % from hmi


% [XYmsBest]=fminsearch(@(args)calc_Hms( args,ThetaIn,s,p0Norm,a,b,c,HmsReal),MyXYms );
[sumError] =calc_Hms( MyXYms,ThetaIn,s,p0Norm,a,b,c,HmsReal )

% best reseults
Xm_s=[-0.0291   -0.9954   -0.0911];
Ym_s=[-0.9880    0.0424   -0.1485];