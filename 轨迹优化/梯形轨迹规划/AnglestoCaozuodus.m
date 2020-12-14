%%%
%%%此函数是计算关节角序列对应的可操作度序列的函数
%%%输入：angle一组关节角n*7
%%%输出：这组关节角的可操作度n*1
%%%
function solution = AnglestoCaozuodus(angles)
angNum= length(angles)
Caozuodus=zeros(angNum,1);
for i=1:angNum
    Caozuodus(i)=CaozuoduOfAngles(angles(i,:));
end
solution=Caozuodus;