function [Ploss,Qloss,tmpv,tmpd,PL,QL,iter,maxerror] = fdist_loadflow( )
global ldata_o;

%  busdata=[ Bn    BP     BQ  ]
   busdata=[  1     0      0
              2   100     60
              3    90     40
              4   120     80
              5    60     30
              6   2000    20
              7   200    100
              8   200    100
              9    60     20 
             10    60     20
             11    45     30
             12    60     35
             13    60     35
             14   120     80
             15    60     10
             16    60     20
             17    60     20
             18    90     40
             19    90     40
             20    90     40
             21    90     40
             22    90     40
             23    90     50
             24   420    200
             25   420    200
             26    60     25
             27    60     25
             28    60     20
             29   120     70
             30   200    600
             31   150     70 
             32   210    100
             33    60     40 ];
         
% initialization FOR LOADFLOW
bKVA=1000; %10MVA
bKV=12.66;    %33KV
maxerror=1;
tolerance=0.0001;

% end of initialization FOR LOADFLOW
         
dim=size(ldata_o);
n=dim(1)+1;
mldata=ldata_o(1:dim(1),2:dim(2));

[sn rn lr lx s ne e p ncu uca ucd nbu ubd nmat ] = fbase_conf( mldata,n );
bp=busdata(:,2);
bq=busdata(:,3);

    

%%%%%%%%%%%%%%
maxerror=1;
bZ=bKV*bKV*1000/bKVA;;
S=complex(bp,bq);
Spu=S/bKVA;
bppu=bp/bKVA;
bqpu=bq/bKVA;
real=sum(bppu);
Reactive=sum(bqpu);
lrpu=lr/(bZ);
lxpu=lx/(bZ);

% initialization
v1=1;
v2=0;
del1=0;
del2=0;
Ploss=0;
Qloss=0;
PL=zeros(1,n-1);
QL=zeros(1,n-1);

iter=0;
tmpv0=zeros(1,n)+1;
tmpv=tmpv0;
tmpd0=zeros(1,n);
tmpd=zeros(1,n);
mm=0;
flag1=0;
%  end of initialization
while (maxerror>tolerance)
    Ploss=0;
    Qloss=0;
    iter=iter+1;
    v1=1;
    del1=0; 
    for m=1:1:ne
        for k=1:nbu(m)   % no of node for each lateral
            cbn=ubd(m,k);
            crn=rn(cbn);
            csn=sn(cbn);
            if((tmpv(crn)==tmpv0(crn))&&(tmpd(crn)==tmpd0(crn)))
                v1=tmpv(csn);
                del1=tmpd(csn);
                v2=tmpv(crn);
                del2=tmpd(crn); 
                P2=0; Q2=0;
                row=nmat(crn,:);
                for l=1:1:n % also from l= k to n
                    if(l==crn)
                        P2=P2+bppu(l);
                        Q2=Q2+bqpu(l);
                        else if(row(l)==1)
                                P2=P2+bppu(l)+PL(find(l==rn)); % from the current node l>k
                                Q2=Q2+bqpu(l)+QL(find(l==rn));
                            end
                    end
                end % end of for loop made for summation at a node
                A(crn)=P2*lrpu(cbn)+Q2*lxpu(cbn)-0.5*v1^2;
                img=(A(crn))^2-((lrpu(cbn))^2+(lxpu(cbn))^2)*(P2^2+Q2^2);
                if (img<0)
                    fprintf('\n LF: load flow not converged imaginary voltage ');
                    flag1=1;
                    break;
                end
                
                B(crn)=sqrt(img);
                imgg=B(crn)-A(crn);
                if (imgg<0)
                    fprintf('\n LFF: load flow not converged imaginary voltage ');
                    flag1=1;
                    indlfnc=1;
                    break;
                end
                v2=sqrt(imgg);
                dd=(P2*lxpu(cbn)-Q2*lrpu(cbn))/(P2*lrpu(cbn)+Q2*(lrpu(cbn)+v2^2));
                del2=del1-atan(dd);
     %  branch loss calculation
                PL(cbn)=lrpu(cbn)*(P2^2+Q2^2)/v2^2;
                QL(cbn)=lxpu(cbn)*(P2^2+Q2^2)/v2^2;
                      
     % storing data
                tmpv(crn)=v2;
                tmpd(crn)=del2;
                Ploss=Ploss+PL(cbn);
                Qloss=Qloss+QL(cbn);
            end  %end of calculation of node
        end     %end of calculation of lateral
        if (flag1==1)
            fprintf('\n LF1: load flow not converged imaginary voltage ');
            flag1=2;
            indlfnc=1;
            break;
        end
    end         %end of calculation of iteration
    if (flag1==2)
            fprintf('\n LF2: load flow not converged imaginary voltage ');
            fprintf('\n the current iteration =%d\n',iter)
            flag1=3;
            indlfnc=1;
            break;
    end

 
     
    
     % end of for loop for each bus load flow
   
   v_err=abs(tmpv0-tmpv);
   del_err=abs(tmpd0-tmpd);
   maxr=max(v_err,del_err);
   maxerror=max(maxr);
   
   
   tmpv0=tmpv;
   tmpd0=tmpd;% assigning the current value for next error calculation
   
   
end % end of while


del_deg=tmpd*180/pi;
V_act=tmpv*bKV;
Ploss_act=Ploss*bKVA;
Qloss_act=Qloss*bKVA;
PL_act=PL*bKVA;
QL_act=QL*bKVA;



end

