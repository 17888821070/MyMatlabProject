%%%
%%%�˺����Ǽ���ؽڽ����ж�Ӧ�Ŀɲ��������еĺ���
%%%���룺angleһ��ؽڽ�n*7
%%%���������ؽڽǵĿɲ�����n*1
%%%
function solution = AnglestoCaozuodus(angles)
angNum= length(angles);
Caozuodus=zeros(angNum,1);
for i=1:angNum
    Caozuodus(i)=CaozuoduOfAngle(angles(i,:));
end
solution=Caozuodus;