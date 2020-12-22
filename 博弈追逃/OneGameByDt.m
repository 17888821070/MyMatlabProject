%%%%%%%% ���ݵ�ǰ״̬���һ�ֲ���֮��Ľ��(��ֵ��ʽ)
%%%% ���룺���ֲ��Ľ��
%         ��:alf0
%         ��:bat0
%         ���仯��:dalf
%         �±仯��:dbat
%         ����ٶ�:Vmax
%         x:x0
%         y:y0
%         z:z0
%         ���ֿ�ʼʱ��:t0
%         ���ֽ���ʱ��:tf
%%%% �����[1x,2y,3z,4����5�£�6vx,7vy,8vz]
function Solution = OneGameByDt(alf0,bat0,dalf,dbat,Vmax,x0,y0,z0,t0,dt,tf)

Solution =zeros(1,5);

%     %������һʱ�̽��ٶȺʹ�ʱ��ѽǼ��ٶȣ����ʱ���ٶ�
%     Solution(4)=alf0 + dalf*dt; %���仯��
%     Solution(5)=bat0 + dbat*dt; %�±仯��
%     
%     %���ݴ�ʱ���ٶȣ����ʱ���������ٶ�ƫ��
%     Solution(6)=Vmax * cos(Solution(5)) * cos(Solution(4)); %vx
%     Solution(7)=Vmax * cos(Solution(5)) * sin(Solution(4)); %vy
%     Solution(8)=Vmax * sin(Solution(4));                    %vz
%     
%     %���ݴ�ʱ���������ٶȣ����ʱ���������λ��
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
%%% ���Ի��ֺ����ļ򵥹�ʽ
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
