%%%%%%%% 根据当前状态求解一轮博弈之后的结果(微分方式)
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
function Solution = OneGameByInt(alf0,bat0,dalf,dbat,Vmax,x0,y0,z0,t0,tf)
Solution =zeros(1,5);
syms t;
% syms alf0;
% syms bat0;
% syms dalf;
% syms dbat;
% syms Vmax;
% syms x0;
% syms y0;
% syms z0;
alf =dalf * t;
bat =dbat * t;
vx  =Vmax * cos(bat0 + bat) * cos(alf0 + alf);
vy  =Vmax * cos(bat0 + bat) * sin(alf0 + alf);
vz  =Vmax * sin(alf0 + alf);
%%% 测试积分函数的简单公式
% alf = alf0 + dalf * t;
% bat = bat0 + dbat * t;
% vx = alf*t;
% vy = alf*t;
% vz = alf*t;
% x = x0 + vx * t;
% y = y0 + vy * t;
% z = z0 + vz * t;

Solution(4)=alf0 + int(alf,t,t0,tf);
Solution(5)=bat0 + int(bat,t,t0,tf);
Solution(1)=x0 + int(vx,t,t0,tf);
Solution(2)=y0 + int(vy,t,t0,tf);
Solution(3)=z0 + int(vz,t,t0,tf);