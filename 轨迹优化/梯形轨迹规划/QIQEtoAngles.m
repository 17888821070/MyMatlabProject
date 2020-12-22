%%%
%%%此函数是使用带抛物线过度的速度梯形轨迹规划规划初始构型到终止构型的关节角序列
%%%输入：qini初始关节角1*7，qend终止关节角1*7
%%%输出：关节角序列n*7
%%%

function angles = QIQEtoAngles(qini,qend,tf,ts,t0)

%机械臂关节运动角度
dq=qend-qini;
% tf=20;
% ts=8;
% t0=0.05;

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
    ss(i,1)=qini(1)+ss(i,1);
    ss(i,2)=qini(2)+ss(i,2);
    ss(i,3)=qini(3)+ss(i,3);
    ss(i,4)=qini(4)+ss(i,4);
    ss(i,5)=qini(5)+ss(i,5);
    ss(i,6)=qini(6)+ss(i,6);
    ss(i,7)=qini(7)+ss(i,7);
end

angles=ss;
