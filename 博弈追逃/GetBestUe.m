% ��ȡ���Լ�����õ��������ǲ���
function Solution=GetBestUe(Xpt,Xet,Ue,t,onedt,dt,siz,Vemax)
bestAlf=0;
bestBat=0;
J=0;

%����Ue��ȡʹJ��С��Ue
for i = 1:siz
    for j = 1 : siz
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ַ���λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Xet(t,:) = OneGameByDt(Xet(t-1,4),Xet(t-1,5),Ue(1,i),0,Vemax,Xet(t-1,1),Xet(t-1,2),Xet(t-1,3),0,onedt,dt);
         Xet(t,:) = OneGameByDt(Xet(t-1,4),Xet(t-1,5),Ue(1,i),Ue(2,j),Vemax,Xet(t-1,1),Xet(t-1,2),Xet(t-1,3),0,onedt,dt);
%         Xet(t,:) = OneGameByInt(Xet(t-1,4),Xet(t-1,5),Ue(1,i),Ue(2,j),Vemax,Xet(t-1,1),Xet(t-1,2),Xet(t-1,3),onedt,dt);
        newJ=GetJ(Xpt(t-1,:),Xet(t,:));
        if newJ>J
            J=newJ;
            bestAlf=Ue(1,i);
            bestBat=Ue(2,j);
        end

    end

end

%plot(Js);
Solution=[bestAlf,bestBat];
