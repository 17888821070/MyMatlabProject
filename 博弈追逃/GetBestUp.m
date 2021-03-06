% 获取策略集中最好的追捕卫星策略
function Solution=GetBestUp(Xpt,Xet,Up,t,onedt,dt,siz,Vpmax)
bestAlf=0;
bestBat=0;
J=10000000000000;
%遍历Ue，取使J最小的Ue

for i = 1:siz
    for j = 1:siz
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%积分法求位置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %          OneGameByDt(alf0,      bat0,      dalf,   dbat,   Vmax, x0,        y0,        z0,        t0,dt,   tf) 
%         Xpt(t,:) = OneGameByDt(Xpt(t-1,4),Xpt(t-1,5),Up(1,i),0,Vpmax,Xpt(t-1,1),Xpt(t-1,2),Xpt(t-1,3),0 ,onedt,dt);%Up(2,j)
      Xpt(t,:) = OneGameByDt(Xpt(t-1,4),Xpt(t-1,5),Up(1,i),Up(2,j),Vpmax,Xpt(t-1,1),Xpt(t-1,2),Xpt(t-1,3),0 ,onedt,dt);
%         Xpt(t,:) = OneGameByInt(Xpt(t-1,4),Xpt(t-1,5),Up(1,i),Up(2,j),Vpmax,Xpt(t-1,1),Xpt(t-1,2),Xpt(t-1,3),0 ,dt);
        newJ =GetJ(Xpt(t,:),Xet(t-1,:));
        if newJ<J
            J=newJ;
            bestAlf=Up(1,i);
            bestBat=Up(2,j);
        end
   end
    
end
Solution=[bestAlf,bestBat];