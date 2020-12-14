% 
%此函数将一组关节角根据其末端位姿将其加入到Map中
%输入：已有map，一组关节角,T的16个值的精度
%输出：加入了新的关节角的map =（编码T，[n][7]）
%

function solution = AddAnglesToMap(map,angles,e)
newmap = java.util.HashMap;
newmap=map
%%计算一组关节角对应的末端T阵
PE=AnglesToPE(angles);
%%将T阵按照一定格式编码，使其能作为map的key值
newT = PackPE(PE,e);
set = newmap.get(newT);
set = [set ;angles];
newmap.put(newT,set);
solution=newmap;

