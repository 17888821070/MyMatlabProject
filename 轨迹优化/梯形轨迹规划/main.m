
clear;
%%%%% ���������������
tf=20;
ts=8;
t0=0.05;

for i=1:10
    %��ʼ�ؽڽ�
    qini=[10,20,30,40,50,60,70];
    %Ŀ��ؽڽ�
    qend=[20+i,40+i,60+i,80+i,100+i,120+i,140+i];

    %�켣�滮����ؽڽ�����
    angles =QIQEtoAngles(qini,qend,tf,ts,t0);

    %��ÿ���ؽڽǶ�Ӧ�Ŀɲ�����
    caozuodus = AnglestoCaozuodus(angles);

    %�ӿ�ʼ����ֹÿһʱ�̵�ƽ���ɲ�����
    avgcaozuodus = AvgCZDs(caozuodus);

    plot(avgcaozuodus)
    hold on;
end



% e=[0.01,0.01,0.01,0.01,0.01,0.01];
% len = length(angles);
% map = java.util.HashMap;
% for i = 1:len
%     
%     %%����һ��ؽڽǶ�Ӧ��ĩ��λ��
%     PE=AnglesToPE(angles(i,:));
%     %%��T����һ����ʽ���룬ʹ������Ϊmap��keyֵ
%     newT = PackPE(PE,e)
%     set = map.get(newT);
%     ln = length(set);
%     
%     if ln==0
%         set = angles(i,:)
%     else
%         set(ln/7+1,:)=angles(i,:);
%     end
%     map.put(newT,set);
% end
% 
% map
% angl = [10,20,30,40,50,60,70];
% PE=AnglesToPE(angl);
% 
% bianmaPE = PackPE(PE,e);
% angleset = map.get(bianmaPE);

% 
% 
% % map = java.util.HashMap;
% % map.put(1,2);
% % map.put(2,4);
% % map.put(3,6);
% % map.put(4,8);
% % map.put(5,10);
% % map.get(5)
% 
% 
% 
% Caozuodus=AnglestoCaozuodus(angles);
% 
% avgs = AvgCZDs(Caozuodus);
% 
% qini1=[10,20,30,40,50,60,70];
% qend1=[1,21,31,41,51,61,71];
% 
% angles1 =QIQEtoAngles(qini1,qend1);
% Caozuodus1=AnglestoCaozuodus(angles1);
% 
% avgs1 = AvgCZDs(Caozuodus1);
% % plot(avgs);
% % hold on;
% % plot(avgs1);
% 
% 
% plot(Caozuodus);
% % hold on;
% plot(Caozuodus1);
% % 
% % % a = [1,2,3]'
% % % b = a
% % % for i = 1:10;
% % %     
% % %     b=[b,a];
% % % end
% % % b
% % 
% % % a=[1,1,1;2,2,2;3,3,3];
% % % a1=[1,1,1;2,2,2;3,3,3];
% % % b=[1,1,1;2,2,2;5,5,5];
% % % s=java.util.HashMap();
% % % s.put(1,a);
% % % s.put(2,a1);
% % % s.put(3,b);
% % % 
% % % s.get(3)
% % 
% % % s = java.util.HashMap();
% % % x = s.get(1)
% % % x=[x,[1,2,3]']
% % % s.put(1,x)
% % % y = s.get(1)
% % map = java.util.HashMap();
% % len = length(angles);
% % for i = 1;len   
% %     AddAnglesToMap(map,angles(i,:));
% % end
% % map
% % 
% % 
