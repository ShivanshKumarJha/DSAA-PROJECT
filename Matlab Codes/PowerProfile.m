clear all
LineNumber=xlsread('C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\DSAA PROJECT\Data Values\DGPOWERPROFILE.xlsx','A5:A36');
% ActivePower=xlsread('C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\DSAA PROJECT\Data Values\DGPOWERPROFILE.xlsx','F5:F36');
% ReactivePower=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
%     'DSAA PROJECT\Data Values\PowerProfile.xlsx'],'G5:G36');

ActivePower=[3.297
14.485
7.567
7.726
16.682
1.764
10.747
3.857
3.272
0.511
0.813
2.458
0.672
0.329
0.259
0.232
0.049
0.16
0.828
0.1
0.043
2.358
3.018
10.243
7.1
3.535
1.443
0.193
0.012
3.09
5
1.25


];

ReactivePower=[1.706
7.378
3.854
3.935
14.401
5.83
7.756
2.771
2.328
0.169
0.269
1.934
0.885
0.293
0.189
0.31
0.038
0.153
0.746
0.117
0.057
1.201
1.537
9.031
6.185
1.798
1.427
0.225
0.019
2.113
3.948
0.979

];

plot(LineNumber,ActivePower)
xlabel('\bf Line Number')
ylabel('\bf Active Power(kW)')
title('Graph of Active Power')
grid on

% plot(LineNumber,ReactivePower)
% xlabel('\bf Line Number')
% ylabel('\bf Reactive Power(kVar)')
% title('Graph of Reactive Power')
% grid on