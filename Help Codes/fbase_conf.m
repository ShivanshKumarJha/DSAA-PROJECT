function [sn rn lr lx s ne e p ncu uca ucd nbu ubd nmat ] = fbase_conf( ldata,n )
%FINDING THE SENDING NODES OF NETWORK
sn=ldata(:,1);
%FINDING THE RECEIVING NODES OF NETWORK
rn=ldata(:,2);
%FINDING THE BRANCH RESISTANCE OF NETWORK
lr=ldata(:,3);
%FINDING THE BRANCH REACTANCE OF NETWORK
lx=ldata(:,4);
%FINDING THE STARTING NODE OF NETWORK
for i=1:1:n
    if((max(i==rn))==0)         
        s=i;
        break;
    end
end
%FINDING THE ENDING NODES OF NETWORK
ne=0;
for i=1:1:n
    if((max(i==sn))==0)
        ne=ne+1;
        e(ne)=i;
    end
end
%FINDING THE PRECEDENCE NODES
p=zeros(n,1);
for i=1:1:n
    if(i~=s)
        p(i)=sn(find(i==rn),1);     
    end
end
%FINDING THE CONTINUOUS PATHS(LATERALS OR TIESETS)
for i=1:1:ne
       x=e(i);
       ncu(i)=0;
       for k=1:1:n
           for m=1:1:n
                   if((m==p(x))||(p(x)==0))
                       ncu(i)=ncu(i)+1;
                       uca(i,ncu(i))=x;
                       x=p(x);
                       break;
                   end
               end
               if(x==0)
                   break;
               end
           end
end

%ARRANGING THE NODES OF LATERAL IN DESCENDING ORDER
for i=1:1:ne
    for j=ncu(i):-1:1
        ucd(i,ncu(i)+1-j)=uca(i,j);
    end
end
%ARRANGING BRANCHES IN DESCENDING ORDER
nbu=ncu-1;
for i=1:1:ne
    for j=1:1:nbu(i)
        ubd(i,j)=find(ucd(i,j+1)==rn);
    end
end

%Finding n-matrix
nmat=zeros(n,n);
for i=1:1:n
    for j=1:1:ne
        tmp=ucd(j,:);
        if(find(i==tmp))
            ind=find(i==tmp);
            for k=1:1:ind
                nmat(ucd(j,k),i)=1;
            end
        end
        if(find(i==tmp))
            break;
        end
    end
end

end

