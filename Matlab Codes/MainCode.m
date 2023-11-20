LineData=load('linedata33bus.m');  %Line Data
BusData=load('busdata33bus.m')     %Bus Data

Sbase=100;    %MVA
Vbase=11.5;   %KV
Zbase=(Vbase^2)/Sbase;

LineData(:,4:5)=LineData(:,4:5)/Zbase;
BusData(:,2:3)=BusData(:,2:3)/(Sbase*1000);

N=max(max(LineData(:,2:3)));

Sload=complex(BusData(:,2),BusData(:,3));
Sload(6) = complex(BusData(6,2), BusData(6,3)); % Include DG set at bus 6

%Initial Voltage Values
V=ones(size(BusData,1),1);  

Z=complex(LineData(:,4),LineData(:,5));

% Current in each Line
Iline=zeros(size(LineData,1),1);

iter=2000;

for i=1:iter

    %BackWard Sweep
    Iload=conj(Sload./V)

    for j=size(LineData,1):-1:1
        c=[];
        e=[];
        [c e]=find(LineData(:,2:3)==LineData(j,3));

        % if c has only one value that means j is a beginning or ending bus
        if size(c,1)==1   
            Iline(LineData(j,1))=Iload(LineData(j,3));
        else
            Iline(LineData(j,1))=Iload(LineData(j,3))+sum(Iline(LineData(c,1)))-Iline(LineData(j,1));
        end
    end

    %Forward Sweep
    for j=1:size(LineData,1)
        V(LineData(j,3))=(V(LineData(j,2))-Iline(LineData(j,1))*Z(j));
    end
end

Voltage=abs(V);
Vangle=angle(Vbase);

% Losses
P=real(Z.*(Iline.^2));
Q=imag(Z.*(Iline.^2));