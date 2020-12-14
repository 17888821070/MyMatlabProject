
%机械臂初始构型关节角
qinit=[10,20,30,40,50,60,70];
qend=[20,40,60,80,100,120,140];
%机械臂关节运动角度
dq=qend-qinit;
tf=20;
% ts=4;
ts=8;
t0=0.05;

syms x;

a1=9*dq/(4*ts*ts*(tf-ts));
a2=3*dq/(2*ts*(tf-ts));
b2=-dq/(4*(tf-ts));
a3=-9*dq/(4*ts*ts*(tf-ts));
b3=9*dq/(2*ts*(tf-ts));
c3=-5*dq/(4*(tf-ts));

w1=a1*x^2;
w2=a2*x+b2;
w3=a3*x^2+b3*x+c3;
w4=dq/(tf-ts);
w5=a3*(tf-x)^2+b3*(tf-x)+c3;
w6=a2*(tf-x)+b2;
w7=a1*(tf-x)^2;

%角速度

t=0:t0:tf;
k=length(t);
s=zeros(k,7);
ss=zeros(k,7);
sss=zeros(k,7);
s(1)=0;
ss(1)=0;
sss(1)=0;

for i=2:k
    y111=w1.*(t(i)>=0 & t(i)<ts/3)+     w2.*(t(i)>=ts/3 & t(i)<ts/3*2)+    w3.*(t(i)>=ts/3*2 & t(i)<ts)+      w4.*(t(i)>=ts & t(i)<tf-ts)+      w5.*(t(i)>=tf-ts & t(i)<tf-ts/3*2)+      w6.*(t(i)>=tf-ts/3*2 & t(i)<tf-ts/3)+     w7.*(t(i)>=tf-ts/3 & t(i)<tf);
    s(i,:)=subs(y111,x,t(i));
    ss(i,:)=ss(i-1,:)+(s(i,:)+s(i-1,:))/2*t0;%subs(q,x,t(i));
    sss(i,:)=(s(i,:)-s(i-1,:))/t0;
end

for i=1:k
    ss(i,1)=qinit(1)+ss(i,1);
    ss(i,2)=qinit(2)+ss(i,2);
    ss(i,3)=qinit(3)+ss(i,3);
    ss(i,4)=qinit(4)+ss(i,4);
    ss(i,5)=qinit(5)+ss(i,5);
    ss(i,6)=qinit(6)+ss(i,6);
    ss(i,7)=qinit(7)+ss(i,7);
end


save 针对一个目标末端位姿求解的目标关节角序列.txt ss -ascii


% k=1:length(t);
% t1 = (k-1)*t0;
% save 'Joint_th.txt' ss -ascii ;
% save 'Joint_w.txt' s -ascii ;
% save 'Joint_a.txt' sss -ascii ;
% ss1 = [t1',ss(:,1)*pi/180];
% save 'Joint_th1.txt' ss1 -ascii ;
% ss2 = [t1',ss(:,2)*pi/180];
% save 'Joint_th2.txt' ss2 -ascii ;
% ss3 = [t1',ss(:,3)*pi/180];
% save 'Joint_th3.txt' ss3 -ascii ;
% ss4 = [t1',ss(:,4)*pi/180];
% save 'Joint_th4.txt' ss4 -ascii ;
% ss5 = [t1',ss(:,5)*pi/180];
% save 'Joint_th5.txt' ss5 -ascii ;
% ss6 = [t1',ss(:,6)*pi/180];
% save 'Joint_th6.txt' ss6 -ascii ;
% ss7 = [t1',ss(:,7)*pi/180];
% save 'Joint_th7.txt' ss7 -ascii ;
% 
% figure(1);
% plot(t,ss(:,1)/180*pi,'g-',t,ss(:,2)/180*pi,'b--',t,ss(:,3)/180*pi,'r:',t,ss(:,4)/180*pi,'k-.',t,ss(:,5)/180*pi,'k-.',t,ss(:,6)/180*pi,'g--',t,ss(:,7)/180*pi,'b:');
% xlabel('时间(s)');
% ylabel('关节角度/弧度');
% title('关节1—7关节角度变化图');
% grid on;
% legend('q1','q2','q3','q4','q5','q6','q7');
% set(gca,'xlim',[0 20]);
% saveas(gcf,'关节1—7关节角度变化图.jpg');
% 
% figure(2);
% plot(t,s(:,1)/180*pi,'g-',t,s(:,2)/180*pi,'b--',t,s(:,3)/180*pi,'r:',t,s(:,4)/180*pi,'-.',t,s(:,5)/180*pi,'k-.',t,s(:,6)/180*pi,'g--',t,s(:,7)/180*pi,'b:');
% xlabel('时间(s)');
% ylabel('关节角度/弧度/秒');
% title('关节1—7关节角速度变化图');
% grid on;
% legend('ω1','ω2','ω3','ω4','ω5','ω6','ω7');
% set(gca,'xlim',[0 20]);
% saveas(gcf,'关节1—7关节角速度变化图.jpg');
% 
% figure(3);
% plot(t,sss(:,1)/180*pi,'g-',t,sss(:,2)/180*pi,'b--.',t,sss(:,3)/180*pi,'r:',t,sss(:,4)/180*pi,'k-.',t,sss(:,5)/180*pi,'k-',t,sss(:,6)/180*pi,'g--',t,sss(:,7)/180*pi,'b:');
% xlabel('时间(s)');
% ylabel('关节角度/弧度/秒平方');
% title('关节1—7关节角加速度变化图');
% grid on;
% legend('β1','β2','β3','β4','β5','β6','β7');
% set(gca,'xlim',[0 20]);
% saveas(gcf,'关节1—7关节角加速度变化图.jpg');
