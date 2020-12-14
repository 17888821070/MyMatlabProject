%定义变量
% sym m(i);%%关节角
% sym d(i);  %%偏置
% sym n(i);%%扭角
% sym a(i);  %%杆长

%转换矩阵通式
% T[i-1][i]=[cos(m(i)),-sin(m(i)),0,a(i-1);
% sin(m(i))cos(n(i-1)),cos(m(i))cos(n(i-1)),-sin(n(i-1)),-d(i)sin(n(i-1));
% sin(m(i))sin(n(i-1)),cos(m(i))sin(n(i-1)),cos(n(i-1)),d(i)cos(n(i-1));
% 0,0,0,1];

%DH参数扭角
%n(0)=0,n(1)=90*pi/180,n(2)=90*pi/180,n(3)=0,n(4)=0,n(5)=-90*pi/180,n(6)=-90*pi/180 %扭角

%定义实变量
% syms m1;
% syms m2;
% syms m3;
% syms m4;
% syms m5;
% syms m6;
% syms m7;
% syms d1;
% syms d2;
% syms d3;
% syms d4;
% syms d5;
% syms d6;
% syms d7;
% syms a1;
% syms a2;
% syms a3;
% syms a4;
tic
n=800;
%生成随机数
r1=rand(n,1);
r2=rand(n,1);
r3=rand(n,1);
r4=rand(n,1);
r5=rand(n,1);
r6=rand(n,1);
r7=rand(n,1);

%tf=360;
%ts=1;
%n=floor(tf/ts);
W=zeros(n,7);
Q=zeros(n,7);

 for i=1:n
  m1=360*r1(i,1)*pi/180;
  m2=360*r2(i,1)*pi/180;
  m3=360*r3(i,1)*pi/180;
  m4=360*r4(i,1)*pi/180;
  m5=360*r5(i,1)*pi/180;
  m6=360*r6(i,1)*pi/180;
  m7=360*r7(i,1)*pi/180;

%给定DH参数
%m1=60*pi/180;
% m2=90*pi/180;
%m3=120*pi/180;
%m4=60*pi/180;
%m5=120*pi/180;
%m6=-90*pi/180;
%m7=180*pi/180;

%已知关节参数
d1=0.5;
d2=0.4;
d3=0.4;
d4=0.4;
d5=0.4;
d6=0.4;
d7=0.5;
a3=3;
a4=3;

%各转换矩阵
T01=[cos(m1),-sin(m1),0,0;sin(m1),cos(m1),0,0;0,0,1,d1;0,0,0,1];
T12=[cos(m2),-sin(m2),0,0;0,0,-1,-d2;sin(m2),cos(m2),0,0;0,0,0,1];
T23=[cos(m3),-sin(m3),0,0;0,0,-1,-d3;sin(m3),cos(m3),0,0;0,0,0,1];
T34=[cos(m4),-sin(m4),0,a3;sin(m4),cos(m4),0,0;0,0,1,d4;0,0,0,1];
T45=[cos(m5),-sin(m5),0,a4;sin(m5),cos(m5),0,0;0,0,1,d5;0,0,0,1];
T56=[cos(m6),-sin(m6),0,0;0,0,1,d6;-sin(m6),-cos(m6),0,0;0,0,0,1];
T67=[cos(m7),-sin(m7),0,0;0,0,1,d7;-sin(m7),-cos(m7),0,0;0,0,0,1];

%%利用matlab计算变换矩阵
T01=T01;
T02=T01*T12;
T03=T01*T12*T23;
T04=T01*T12*T23*T34;
T05=T01*T12*T23*T34*T45;
T06=T01*T12*T23*T34*T45*T56;
T07=T01*T12*T23*T34*T45*T56*T67;

% simplify(T07)

T17=T12*T23*T34*T45*T56*T67;
T27=T23*T34*T45*T56*T67;
T37=T34*T45*T56*T67;
T47=T45*T56*T67;
T57=T56*T67;
T67=T67;

%%R0i=T0i([1 2 3],[1 2 3])  %获取R0i
R01=T01([1 2 3],[1 2 3]);
R02=T02([1 2 3],[1 2 3]);
R03=T03([1 2 3],[1 2 3]);
R04=T04([1 2 3],[1 2 3]);
R05=T05([1 2 3],[1 2 3]);
R06=T06([1 2 3],[1 2 3]);
R07=T07([1 2 3],[1 2 3]);

%%Zi=T0i([1 2 3],[3])  %获取Zi
Z1=T01([1 2 3],[3]);
Z2=T02([1 2 3],[3]);
Z3=T03([1 2 3],[3]);
Z4=T04([1 2 3],[3]);
Z5=T05([1 2 3],[3]);
Z6=T06([1 2 3],[3]);
Z7=T07([1 2 3],[3]);

%%Pi7=Ti7([1 2 3],[4])  %获取Pi7
P17=T17([1 2 3],[4]);
P27=T27([1 2 3],[4]);
P37=T37([1 2 3],[4]);
P47=T47([1 2 3],[4]);
P57=T57([1 2 3],[4]);
P67=T67([1 2 3],[4]);
P77=[0;0;0];

J=[cross(Z1,(R01*P17)),cross(Z2,(R02*P27)),cross(Z3,(R03*P37)),cross(Z4,(R04*P47)),cross(Z5,(R05*P57)),cross(Z6,(R06*P67)),cross(Z7,(R07*P77));Z1,Z2,Z3,Z4,Z5,Z6,Z7];

% W([1],[i])=J;
%雅可比矩阵奇异值分解
[U,S,V]=svd(J);
%求最小奇异值
%min=S([6],[6]);
%K=S(1:1,1)/S(6:6,6);%条件数
L=S(6:6,6)/S(1:1,1);%处理后的条件数
w=S(1:1,1)*S(2:2,2)*S(3:3,3)*S(4:4,4)*S(5:5,5)*S(6:6,6);%可操作度










W(i,1)=360*r1(i,1);
W(i,2)=360*r3(i,1);
W(i,3)=360*r4(i,1);
W(i,4)=360*r5(i,1);
W(i,5)=360*r6(i,1);
W(i,6)=360*r7(i,1);
W(i,7)=w;
 end
 for j=1:i
my_max=max(W(:,7));
my_min=min(W(:,7));
f=(W(j,7)-my_min)/(my_max-my_min);
H=L/2+f/2;
Q(j,1)=W(j,1);
Q(j,2)=W(j,2);
Q(j,3)=W(j,3);
Q(j,4)=W(j,4);
Q(j,5)=W(j,5);
Q(j,6)=W(j,6);
Q(j,7)=H;
%绘图
plot3(W(i,2),W(i,3),Q(i,7),'.k')
hold on;
grid on;
title('综合运动能力');
xlabel('第4关节角度值/°') ;
ylabel('第6关节角度值/°') ;
zlabel('综合运动能力') ;
axis([0 360 0 360 0 1]);
 end
 toc
