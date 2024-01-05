clear ;
clc;
global ldata_o;
%ldata_o= [ Ln   sn   rn     r        x     ]
 ldata_o= [  1    1    2   0.0922   0.0477
             2    2    3   0.4930   0.2511
             3    3    4   0.3660   0.1864
             4    4    5   0.3811   0.1941
             5    5    6   0.8190   0.7070
             6    6    7   0.1872   0.6188
             7    7    8   1.7114   1.2351
             8    8    9   1.0300   0.7400
             9    9   10   1.0440   0.7400
            10   10   11   0.1966   0.0650 
            11   11   12   0.3744   0.1238 
            12   12   13   1.4680   1.1550
            13   13   14   0.5416   0.7129
            14   14   15   0.5910   0.5260
            15   15   16   0.7463   0.5450
            16   16   17   1.2890   1.7210 
            17   17   18   0.7320   0.5740
            18    2   19   0.1640   0.1565
            19   19   20   1.5042   1.3554
            20   20   21   0.4095   0.4784
            21   21   22   0.7089   0.9373
            22    6   23   0.2030   0.1034
            23   23   24   0.2842   0.1447
            24   24   25   1.0590   0.9337
            25   25   26   0.8042   0.7006
            26   26   27   0.5075   0.2585
            27   27   28   0.9744   0.9630
            28   28   29   0.3105   0.3619
            29   29   30   0.3410   0.5302
            30   3    31   0.4512   0.3083
            31   31   32   0.8980   0.7019
            32   32   33   0.8960   0.7011 ];

dim=size(ldata_o);
nbus=dim(1)+1;
ldata=ldata_o(1:dim(1),2:dim(2));

[sn rn lr lx s ne e p ncu uca ucd nbu ubd nmat] = fbase_conf( ldata,nbus );
[bcPloss,bcQloss,bctmpv,bctmpd,bcPL,bcQL,bciter,bcmaxerror] =fdist_loadflow();

% display  result of Loadflow
         
   fprintf('\n\n total iteration number=%g\t\t\t\t\n\n',bciter);
   fprintf('\n Maximum error deviation=%8.7f\t\t\t\n\n',bcmaxerror);
   
   
   head =['            RESULT SHOWING VOLTAGE PROFILE               '
          '   Bus        Magnitude of Voltage          Voltage Angle'
          '  Number               (pu)                    (rad)     '];     

    disp(head);
    for m=1:nbus
        fprintf('\n%5g\t\t\t\t%8.7f\t\t\t\t%8.7f\t\t\t\t%8.7f\t\t\t\t',m,bctmpv(m),bctmpd(m));
    end 
fprintf('\n\n');
head1 =['RESULT SHOWING ACTIVE POWER&REACTIVE POWER LOSSES IN THE BRANCHES'
        '   Branch       SBranch-RBranch           Branch Losses          '
        '   Number           SBN-RBN         RealPL(kW)   ReactivePL(kVAR)'];     

    disp(head1);
    for bn=1:nbus-1
        % fprintf('\n %5g\t\t\t\t %2g-%2g\t\t\t\t%5.3f\t\t\t\t%5.3f\t\t\t\t',bn,sn(bn),rn(bn),bcPL(bn)*1000,bcQL(bn)*1000);
        fprintf('\n %5g\t\t\t\t %2g-%2g\t\t\t\t%5.3f\t\t\t\t%5.3f\t\t\t\t',bcQL(bn)*1000)
        % fprintf('\n \t\t',bcPL(bn)*1000,bcQL(bn)*1000)
    end 
fprintf('\n\nReal power Loss(kW)    = %5g\t\t\t\t\n',bcPloss*1000); 
fprintf('\nReactive power Loss(kVar)= %5g\t\t\t\t\n',bcQloss*1000);  
figure(1);
bar(bctmpv);
axis([1 33 0 1.1]);