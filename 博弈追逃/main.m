clear;
%%%%%%%% 基本配置量
%总时间T
T=1000;
%步长
dt=0.1;
%总步数
n=T/dt;
%单次博弈离散步长
onedt=0.01;
%追逃成功距离
endDistance = 100;

%%%%%%%% 初始状态
%追捕卫星
% Xp=[0,0,0,pi/3,pi/2]; %a,y,z,α，β
% Xp=[0,0,0,pi/3,0]; %a,y,z,α，β
% Xp=[0,0,0,0,pi/3]; %a,y,z,α，β
Xp=[0,0,0,0,0];
Vpmax=10;

%逃逸卫星
Xe=[1000,0,0,0,0]; %a,y,z,α，β
Vemax = 8;

%%%%%%%% 策略集
%追捕卫星
maxUp = pi;
dUp = pi/20;
sizUp=maxUp/dUp*2+1;
Up=[-1*maxUp:dUp:maxUp;-1*maxUp:dUp:maxUp;];%
% 逃逸卫星
maxUe = pi;
dUe = pi/10;
Ue=[-1*maxUe:dUe:maxUe;-1*maxUe:dUe:maxUe;];%
sizUe=maxUe/dUe*2+1;

%%%%%%%% 离散博弈 t0~tf
%离散数据集,p表示追，e表示逃，行表示第i时刻的状态
Xpt=zeros(n+1,5); % 1x,2y,3z,4α，5β，6vx,7vy,8vz
Xet=zeros(n+1,5);
Upt=zeros(n+1,2);
Uet=zeros(n+1,2);
%t0时刻
Xpt(1,:)=Xp;
Xet(1,:)=Xe;
%支付J
J=zeros(n+1,1);

for i = 2:n+1
    Upt(i,:) = GetBestUp(Xpt,Xet,Up,i,onedt,dt,sizUp,Vpmax);%[unifrnd(-1,10),unifrnd(-10,10)];%
    Uet(i,:) = GetBestUe(Xpt,Xet,Ue,i,onedt,dt,sizUe,Vemax);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%积分法求位置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %根据角速度变化率求一轮博弈后的角速度
     Xpt(i,:) = OneGameByDt(Xpt(i-1,4),Xpt(i-1,5),Upt(i,1),Upt(i,2),Vpmax,Xpt(i-1,1),Xpt(i-1,2),Xpt(i-1,3),0,onedt,dt);
     Xet(i,:) = OneGameByDt(Xet(i-1,4),Xet(i-1,5),Uet(i,1),Uet(i,2),Vemax,Xet(i-1,1),Xet(i-1,2),Xet(i-1,3),0,onedt,dt);
%      Xpt(i,:) = OneGameByInt(Xpt(i-1,4),Xpt(i-1,5),Upt(i,1),Upt(i,2),Vpmax,Xpt(i-1,1),Xpt(i-1,2),Xpt(i-1,3),0,dt);
%      Xet(i,:) = OneGameByInt(Xet(i-1,4),Xet(i-1,5),Uet(i,1),Uet(i,2),Vemax,Xet(i-1,1),Xet(i-1,2),Xet(i-1,3),0,dt);
     J(i) = GetJ(Xpt(i,:),Xet(i,:));
     if J(i)<endDistance
         break;
     end
     i
end
% 
figure(1);
title('空间位置跟踪图')
plot3(Xpt(:,1),Xpt(:,2),Xpt(:,3),'o');
hold on;
plot3(Xet(:,1),Xet(:,2),Xet(:,3),'*');

figure(2);
title('相对距离')
plot(J);

figure(3);
title('双方俯仰角跟踪图α')
hold on;
plot(Xpt(:,4),'-g');
plot(Xet(:,4),'--g');
figure(4);
title('双方俯仰角跟踪图β')
hold on;
plot(Xpt(:,5),'-r');
plot(Xet(:,5),'--r');
% figure(5);
% title('x方向跟踪')
% hold on;
% plot(Xpt(:,6),'--y');
% plot(Xet(:,6),'*y');
% figure(6);
% title('y方向跟踪')
% hold on;
% plot(Xpt(:,7),'-b');
% plot(Xet(:,7),'--b');
% figure(7);
% title('z方向跟踪')
% hold on;
% plot(Xpt(:,8),'-o');
% plot(Xet(:,8),'--o');