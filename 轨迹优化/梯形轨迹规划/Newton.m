clear;
tf=20;
ts=4;
t0=0.05;
n=floor(tf/t0);
k=1:(n+1);
t = (k-1)*t0;

robotdata;

load Joint_th.txt;
q1 = Joint_th(:,1)*pi/180;
q2 = Joint_th(:,2)*pi/180;
q3 = Joint_th(:,3)*pi/180;
q4 = Joint_th(:,4)*pi/180;
q5 = Joint_th(:,5)*pi/180;
q6 = Joint_th(:,6)*pi/180;
q7 = Joint_th(:,7)*pi/180;

load Joint_w.txt;
w1 = Joint_w(:,1)*pi/180;
w2 = Joint_w(:,2)*pi/180;
w3 = Joint_w(:,3)*pi/180;
w4 = Joint_w(:,4)*pi/180;
w5 = Joint_w(:,5)*pi/180;
w6 = Joint_w(:,6)*pi/180;
w7 = Joint_w(:,7)*pi/180;
load Joint_a.txt;
a1 = Joint_a(:,1)*pi/180;
a2 = Joint_a(:,2)*pi/180;
a3 = Joint_a(:,3)*pi/180;
a4 = Joint_a(:,4)*pi/180;
a5 = Joint_a(:,5)*pi/180;
a6 = Joint_a(:,6)*pi/180;
a7 = Joint_a(:,7)*pi/180;

z=[0,0,1]';
t1=zeros(1,n+1);
t2=zeros(1,n+1);
t3=zeros(1,n+1);
t4=zeros(1,n+1);
t5=zeros(1,n+1);
t6=zeros(1,n+1);
t7=zeros(1,n+1);

for i=1:n+1;
    
    q=[q1(i),q2(i),q3(i),q4(i),q5(i),q6(i),q7(i)];  
    %得到Tnm
    T10=GetTnm(q,0,1);
    T21=GetTnm(q,1,2);
    T32=GetTnm(q,2,3);
    T43=GetTnm(q,3,4);
    T54=GetTnm(q,4,5);
    T65=GetTnm(q,5,6);
    T76=GetTnm(q,6,7);
    
    %得到旋转矩阵i+1Ri
    R01=T10(1:3,1:3)';
    R12=T21(1:3,1:3)';
    R23=T32(1:3,1:3)';
    R34=T43(1:3,1:3)';
    R45=T54(1:3,1:3)';
    R56=T65(1:3,1:3)';
    R67=T76(1:3,1:3)';
    
   
    %{i+1}在{i}系的表示
    P10 = T10(1:3,4);
    P21 = T21(1:3,4);
    P32 = T32(1:3,4);
    P43 = T43(1:3,4);
    P54 = T54(1:3,4);
    P65 = T65(1:3,4);
    P76 = T76(1:3,4);
    
    %向外地推计算连杆速度加速度：1——7
        %角速度
    w11(i,:)=w1(i)*z;
    w22(i,:)=R12*w11(i,:)'+w2(i)*z;
    w33(i,:)=R23*w22(i,:)'+w3(i)*z;
    w44(i,:)=R34*w33(i,:)'+w4(i)*z;
    w55(i,:)=R45*w44(i,:)'+w5(i)*z;
    w66(i,:)=R56*w55(i,:)'+w6(i)*z;
    w77(i,:)=R67*w66(i,:)'+w7(i)*z;
 
    
        %角加速度
    wd11(i,:)=a1(i)*z;
    wd22(i,:)=R12*wd11(i,:)'+cross((R12*w11(i,:)'),(w2(i)*z))+a2(i)*z;
    wd33(i,:)=R23*wd22(i,:)'+cross((R23*w22(i,:)'),(w3(i)*z))+a3(i)*z;
    wd44(i,:)=R34*wd33(i,:)'+cross((R34*w33(i,:)'),(w4(i)*z))+a4(i)*z;
    wd55(i,:)=R45*wd44(i,:)'+cross((R45*w44(i,:)'),(w5(i)*z))+a5(i)*z;
    wd66(i,:)=R56*wd55(i,:)'+cross((R56*w55(i,:)'),(w6(i)*z))+a6(i)*z;
    wd77(i,:)=R67*wd66(i,:)'+cross((R67*w66(i,:)'),(w7(i)*z))+a7(i)*z;
    
        %关节线加速度（这里的第一个cross项是wd11还是w11）
    vd11(i,:)=[0,0,0]';
    vd22(i,:)=R12*(vd11(i,:)'+cross(wd11(i,:)',P21)+cross(w11(i,:)',cross(w11(i,:)',P21)));
    vd33(i,:)=R23*(vd22(i,:)'+cross(wd22(i,:)',P32)+cross(w22(i,:)',cross(w22(i,:)',P32)));
    vd44(i,:)=R34*(vd33(i,:)'+cross(wd33(i,:)',P43)+cross(w33(i,:)',cross(w33(i,:)',P43)));
    vd55(i,:)=R45*(vd44(i,:)'+cross(wd44(i,:)',P54)+cross(w44(i,:)',cross(w44(i,:)',P54)));
    vd66(i,:)=R56*(vd55(i,:)'+cross(wd55(i,:)',P65)+cross(w55(i,:)',cross(w55(i,:)',P65)));
    vd77(i,:)=R67*(vd66(i,:)'+cross(wd66(i,:)',P76)+cross(w66(i,:)',cross(w66(i,:)',P76)));
    
        %质心线加速度（前面的RC用的不对）
    vdc11(i,:)=vd11(i,:)+cross(wd11(i,:),rc11)+cross(w11(i,:),cross(w11(i,:),rc11));
    vdc22(i,:)=vd22(i,:)+cross(wd22(i,:),rc22)+cross(w22(i,:),cross(w22(i,:),rc22));
    vdc33(i,:)=vd33(i,:)+cross(wd33(i,:),rc33)+cross(w33(i,:),cross(w33(i,:),rc33));
    vdc44(i,:)=vd44(i,:)+cross(wd44(i,:),rc44)+cross(w44(i,:),cross(w44(i,:),rc44));
    vdc55(i,:)=vd55(i,:)+cross(wd55(i,:),rc55)+cross(w55(i,:),cross(w55(i,:),rc55));
    vdc66(i,:)=vd66(i,:)+cross(wd66(i,:),rc66)+cross(w66(i,:),cross(w66(i,:),rc66));
    vdc77(i,:)=vd77(i,:)+cross(wd77(i,:),rc77)+cross(w77(i,:),cross(w77(i,:),rc77));

        %质心惯性力
    fc11(i,:)=m(1)*vdc11(i,:)';
    fc22(i,:)=m(2)*vdc22(i,:)';
    fc33(i,:)=m(3)*vdc33(i,:)';
    fc44(i,:)=m(4)*vdc44(i,:)';
    fc55(i,:)=m(5)*vdc55(i,:)';
    fc66(i,:)=m(6)*vdc66(i,:)';
    fc77(i,:)=m(7)*vdc77(i,:)';    

        %质心惯性扭矩
    %{    
    nc11(i,:)=I1c1*[0,0,a1(i)]'+cross([0,0,w1(i)]',(I1c1*[0,0,w1(i)]'));
    nc22(i,:)=I2c2*[0,0,a2(i)]'+cross([0,0,w2(i)]',(I2c2*[0,0,w2(i)]'));
    nc33(i,:)=I3c3*[0,0,a3(i)]'+cross([0,0,w3(i)]',(I3c3*[0,0,w3(i)]'));
    nc44(i,:)=I4c4*[0,0,a4(i)]'+cross([0,0,w4(i)]',(I4c4*[0,0,w4(i)]'));
    nc55(i,:)=I5c5*[0,0,a5(i)]'+cross([0,0,w5(i)]',(I5c5*[0,0,w5(i)]'));
    nc66(i,:)=I6c6*[0,0,a6(i)]'+cross([0,0,w6(i)]',(I6c6*[0,0,w6(i)]'));
    nc77(i,:)=I7c7*[0,0,a7(i)]'+cross([0,0,w7(i)]',(I7c7*[0,0,w7(i)]'));
    %}
    
        
    nc11(i,:)=I1c1*wd11(i,:)'+cross(w11(i,:)',(I1c1*w11(i,:)'));
    nc22(i,:)=I2c2*wd22(i,:)'+cross(w22(i,:)',(I2c2*w22(i,:)'));
    nc33(i,:)=I3c3*wd33(i,:)'+cross(w33(i,:)',(I3c3*w33(i,:)'));
    nc44(i,:)=I4c4*wd44(i,:)'+cross(w44(i,:)',(I4c4*w44(i,:)'));
    nc55(i,:)=I5c5*wd55(i,:)'+cross(w55(i,:)',(I5c5*w55(i,:)'));
    nc66(i,:)=I6c6*wd66(i,:)'+cross(w66(i,:)',(I6c6*w66(i,:)'));
    nc77(i,:)=I7c7*wd77(i,:)'+cross(w77(i,:)',(I7c7*w77(i,:)'));
    
   
    
    %向内递推计算力，力矩7——1
        %关节力
    f77(i,:)=fc77(i,:)';
    f66(i,:)=R67'*f77(i,:)'+fc66(i,:)';
    f55(i,:)=R56'*f66(i,:)'+fc55(i,:)';
    f44(i,:)=R45'*f55(i,:)'+fc44(i,:)';
    f33(i,:)=R34'*f44(i,:)'+fc33(i,:)';
    f22(i,:)=R23'*f33(i,:)'+fc22(i,:)';
    f11(i,:)=R12'*f22(i,:)'+fc11(i,:)';
     

        %关节力矩；
    n77(i,:)=nc77(i,:)+cross(rc77,fc77(i,:));
    n66(i,:)=R67'*n77(i,:)'+nc66(i,:)'+cross(rc66,fc66(i,:)')+cross(P76,(R67'*f77(i,:)'));
    n55(i,:)=R56'*n66(i,:)'+nc55(i,:)'+cross(rc55,fc55(i,:)')+cross(P65,(R56'*f66(i,:)'));
    n44(i,:)=R45'*n55(i,:)'+nc44(i,:)'+cross(rc44,fc44(i,:)')+cross(P54,(R45'*f55(i,:)'));
    n33(i,:)=R34'*n44(i,:)'+nc33(i,:)'+cross(rc33,fc33(i,:)')+cross(P43,(R34'*f44(i,:)'));
    n22(i,:)=R23'*n33(i,:)'+nc22(i,:)'+cross(rc22,fc22(i,:)')+cross(P32,(R23'*f33(i,:)'));
    n11(i,:)=R12'*n22(i,:)'+nc11(i,:)'+cross(rc11,fc11(i,:)')+cross(P21,(R12'*f22(i,:)'));

    t1(i)=n11(i,3);
    t2(i)=n22(i,3);
    t3(i)=n33(i,3);
    t4(i)=n44(i,3);
    t5(i)=n55(i,3);
    t6(i)=n66(i,3);
    t7(i)=n77(i,3);

end

figure(1);
plot(t,t1,'g-',t,t2,'b-.',t,t3,'r--',t,t4,'k:');
xlabel('时间(s)');
ylabel('驱动力矩/N.m');
title('关节1—4输出力矩变化图');
grid on;
legend('τ1','τ2','τ3','τ4');
set(gca,'xlim',[0 20]);
saveas(gcf,'关节1—4输出力矩变化图.jpg');


figure(2);
plot(t,t5,'g-',t,t6,'b-.',t,t7,'r--');
xlabel('时间(s)');
ylabel('驱动力矩/N.m');
title('关节5—7输出力矩变化图');
grid on;
legend('τ5','τ6','τ7');
set(gca,'xlim',[0 20]);
saveas(gcf,'关节5—7输出力矩变化图.jpg');




