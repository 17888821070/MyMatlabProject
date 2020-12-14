%输入关节角，m，n获得{n}系到{m}系的转换矩阵
function Solution=GetTnm(q,m,n)
a=q;
b=m;
c=n;
Ti=eye(4);
Tnm=eye(4);
DH=[ 0,   0    ,   0.6 ,  a(1);	
	0,   pi/2 ,   0.5 ,  pi/2+a(2);	
	0,   -pi/2,   0.5 ,  a(3);	
	5,   0    ,   0.5 ,  a(4);	
	5,   0    ,   0.5 ,  a(5);	
	0,   pi/2 ,   0.5 ,  -pi/2+a(6);	
	0,   -pi/2,   0.6 ,  a(7);];
for i=b+1:c
    Ti=DH_Ti(DH(i,:));
    Tnm=Tnm*Ti;
end

Solution =Tnm;
    
