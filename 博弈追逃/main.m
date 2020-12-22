clear;
%%%%%%%% ����������
%��ʱ��T
T=1000;
%����
dt=0.1;
%�ܲ���
n=T/dt;
%���β�����ɢ����
onedt=0.01;
%׷�ӳɹ�����
endDistance = 100;

%%%%%%%% ��ʼ״̬
%׷������
% Xp=[0,0,0,pi/3,pi/2]; %a,y,z,������
% Xp=[0,0,0,pi/3,0]; %a,y,z,������
% Xp=[0,0,0,0,pi/3]; %a,y,z,������
Xp=[0,0,0,0,0];
Vpmax=10;

%��������
Xe=[1000,0,0,0,0]; %a,y,z,������
Vemax = 8;

%%%%%%%% ���Լ�
%׷������
maxUp = pi;
dUp = pi/20;
sizUp=maxUp/dUp*2+1;
Up=[-1*maxUp:dUp:maxUp;-1*maxUp:dUp:maxUp;];%
% ��������
maxUe = pi;
dUe = pi/10;
Ue=[-1*maxUe:dUe:maxUe;-1*maxUe:dUe:maxUe;];%
sizUe=maxUe/dUe*2+1;

%%%%%%%% ��ɢ���� t0~tf
%��ɢ���ݼ�,p��ʾ׷��e��ʾ�ӣ��б�ʾ��iʱ�̵�״̬
Xpt=zeros(n+1,5); % 1x,2y,3z,4����5�£�6vx,7vy,8vz
Xet=zeros(n+1,5);
Upt=zeros(n+1,2);
Uet=zeros(n+1,2);
%t0ʱ��
Xpt(1,:)=Xp;
Xet(1,:)=Xe;
%֧��J
J=zeros(n+1,1);

for i = 2:n+1
    Upt(i,:) = GetBestUp(Xpt,Xet,Up,i,onedt,dt,sizUp,Vpmax);%[unifrnd(-1,10),unifrnd(-10,10)];%
    Uet(i,:) = GetBestUe(Xpt,Xet,Ue,i,onedt,dt,sizUe,Vemax);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ַ���λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %���ݽ��ٶȱ仯����һ�ֲ��ĺ�Ľ��ٶ�
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
title('�ռ�λ�ø���ͼ')
plot3(Xpt(:,1),Xpt(:,2),Xpt(:,3),'o');
hold on;
plot3(Xet(:,1),Xet(:,2),Xet(:,3),'*');

figure(2);
title('��Ծ���')
plot(J);

figure(3);
title('˫�������Ǹ���ͼ��')
hold on;
plot(Xpt(:,4),'-g');
plot(Xet(:,4),'--g');
figure(4);
title('˫�������Ǹ���ͼ��')
hold on;
plot(Xpt(:,5),'-r');
plot(Xet(:,5),'--r');
% figure(5);
% title('x�������')
% hold on;
% plot(Xpt(:,6),'--y');
% plot(Xet(:,6),'*y');
% figure(6);
% title('y�������')
% hold on;
% plot(Xpt(:,7),'-b');
% plot(Xet(:,7),'--b');
% figure(7);
% title('z�������')
% hold on;
% plot(Xpt(:,8),'-o');
% plot(Xet(:,8),'--o');