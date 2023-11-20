clear all
% % Reading the data from XLSX 
BusNumber=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
    'DSAA PROJECT\Data Values\VoltageProfile.xlsx'],'A5:A37');
% VoltageMagnitude=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
%     'DSAA PROJECT\Data Values\VoltageProfile.xlsx'],'C5:C37');
% VoltageAngle=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
%     'DSAA PROJECT\Data Values\VoltageProfile.xlsx'],'D5:D37');
% 
LineNumber=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
    'DSAA PROJECT\Data Values\CurrentProfile.xlsx'],'A5:A36');
% CurrentMagnitude=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
%     'DSAA PROJECT\Data Values\CurrentProfile.xlsx'],'F5:F36');
% CurrentAngle=xlsread(['C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\' ...
%     'DSAA PROJECT\Data Values\CurrentProfile.xlsx'],'G5:G36');


[num,txt,raw]=xlsread('C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\DSAA PROJECT\Data Values\PowerProfile.xlsx','L4:L36');
data = cellfun(@str2double,raw);
% CurrentMagnitude=real(data);
VoltageMagnitude=imag(data);
plot(BusNumber,VoltageMagnitude)

xlabel('\bf Bus Number')
ylabel('\bf Voltage Angle')
title('Graph of Angle Of Voltage')
grid on

% plot(BusNumber,VoltageAngle)
% xlabel('\bf Bus Number')
% ylabel('\bf Voltage Angle')
% title('Graph of Angle Of Voltage')
% grid on

% plot(LineNumber,CurrentMagnitude)
% xlabel('\bf Bus Number')
% ylabel('\bf Voltage Magnitude')
% title('Graph of Magnitude Of Current(in pu)')
% grid on
% 
% plot(LineNumber,CurrentAngle)
% xlabel('\bf Line Number')
% ylabel('\bf Current Angle')
% title('Graph of Angle Of Current')
% grid on

% [num,txt,raw]=xlsread('C:\Users\Shivansh Kumar Jha\OneDrive\Desktop\DSAA PROJECT\Data Values\PowerProfile.xlsx');
% data = cellfun(@str2double,raw)
% VoltageMagnitude=real(data);