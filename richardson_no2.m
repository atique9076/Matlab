clear
clc
G=load('void.txt');% respective month data in radio excel file
Date=G(:,1);
P=G(:,2);
GH=G(:,3);
WS=G(:,5);
WD=G(:,4);
VT=G(:,6);
u=G(:,7);
v=G(:,8);
BLH=[];
BLH1=[];
for j=1:31
    for i=1:length(G)
        x=find(Date==j);
        y=GH(x);
        if Date(i)==j
             R(i)=((9.81/VT(x(1)))*(VT(i)-VT(x(1)))*(GH(i)-GH(x(1))))/((u(i)-u(x(1)))^2+(v(i)-v(x(1)))^2)
             BLH=[BLH;R(i),P(i)] %richardson no. at each height(geop) of all date of a month.
        end
    end
end
 for j=1:31
     for i=1:length(G)
         if Date(i)==j
            
            if (BLH(i)>1)
                BLH1=[BLH1;Date(i),GH(i-1),GH(i),R(i-1),R(i)];%geop. height & richardson no,...
                % one above and below of height which crosses richardson
                % no=0.25.
                break
            end
         end
     end
 end
 % to find interpolation of 
for k=1:length(BLH1)
    BLH1(BLH1==NaN)=0;
    aa=[BLH1(k,4) BLH1(k,5)];
    bb=[BLH1(k,2) BLH1(k,3)];
    aa(isnan(aa))=0
    bb(isnan(bb))=0
    aa(isinf(aa))=1000
    bb(isinf(bb))=100000
    z(k)=interp1(aa,bb,0.25);
end
z=z';
