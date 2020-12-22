%%%%%%%% 根据当前状态求解一轮博弈之后的结果(数值方式)
%%%% 输入：上轮博弈结果
%         α:alf0
%         β:bat0
%         α变化率:dalf
%         β变化率:dbat
%         最大速度:Vmax
%         x:x0
%         y:y0
%         z:z0
%         积分开始时间:t0
%         积分结束时间:tf
%%%% 输出：[1x,2y,3z,4α，5β，6vx,7vy,8vz]
function Solution = OneGameByDt(alf0,bat0,dalf,dbat,Vmax,x0,y0,z0,t0,dt,tf)

Solution =zeros(1,5);

%     %根据上一时刻角速度和此时最佳角加速度，求此时角速度
%     Solution(4)=alf0 + dalf*dt; %α变化率
%     Solution(5)=bat0 + dbat*dt; %β变化率
%     
%     %根据此时角速度，求此时三个方向速度偏角
%     Solution(6)=Vmax * cos(Solution(5)) * cos(Solution(4)); %vx
%     Solution(7)=Vmax * cos(Solution(5)) * sin(Solution(4)); %vy
%     Solution(8)=Vmax * sin(Solution(4));                    %vz
%     
%     %根据此时三个方向速度，求此时三个方向的位置
%     Solution(1)=x0 + Solution(6)*dt;
%     Solution(2)=y0 + Solution(7)*dt;
%     Solution(3)=z0 + Solution(8)*dt;
% syms t;
t=t0:dt:tf;
alf =dalf .* t;
bat =dbat .* t;
vx  =Vmax .* cos(bat0 + bat) .* cos(alf0 + alf);
vy  =Vmax .* cos(bat0 + bat) .* sin(alf0 + alf);
vz  =Vmax .* sin(alf0 + alf);

% x   =vx;% .* t;
% y   =vy;%  .* t;
% z   =vz;%  .* t;
%%% 测试积分函数的简单公式
% alf = alf0 + dalf .* t;
% bat = bat0 + dbat .* t;
% vx = alf.*t;
% vy = alf.*t;
% vz = alf.*t;
% x = x0 + vx.*t;
% y = y0 + vy.*t;
% z = z0 + vz.*t;

Solution(4)=alf0 + trapz(t,alf);
Solution(5)=bat0 + trapz(t,bat);
% Solution(6)=Vmax * cos(Solution(5)) * cos(Solution(4));
% Solution(7)=Vmax * cos(Solution(5)) * sin(Solution(4));
% Solution(8)=Vmax * sin(Solution(4));
Solution(1)=x0 + trapz(t,vx);
Solution(2)=y0 + trapz(t,vy);
Solution(3)=z0 + trapz(t,vz);
