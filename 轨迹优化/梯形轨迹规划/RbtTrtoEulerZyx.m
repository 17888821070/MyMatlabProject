function Solution=RbtTrtoEulerZyx(m)
a=m;
cosb=sqrt(a(1,1)^2+a(2,1)^2);
if cosb>=10^-9
    bit=atan2(-a(3,1),cosb);
    aif=atan2(a(2,1),a(1,1));
    gam=atan2(a(3,2),a(3,3));
else
    aif=0;
    gam=-atan2(a(2,3),a(2,2));
    if a(2,3)*a(1,2)>0
        bit=-pi/2;
    else
        bit=pi/2;
    end
end
Solution=[aif,bit,gam];