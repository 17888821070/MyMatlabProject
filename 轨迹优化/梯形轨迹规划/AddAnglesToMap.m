% 
%�˺�����һ��ؽڽǸ�����ĩ��λ�˽�����뵽Map��
%���룺����map��һ��ؽڽ�,T��16��ֵ�ľ���
%������������µĹؽڽǵ�map =������T��[n][7]��
%

function solution = AddAnglesToMap(map,angles,e)
newmap = java.util.HashMap;
newmap=map
%%����һ��ؽڽǶ�Ӧ��ĩ��T��
PE=AnglesToPE(angles);
%%��T����һ����ʽ���룬ʹ������Ϊmap��keyֵ
newT = PackPE(PE,e);
set = newmap.get(newT);
set = [set ;angles];
newmap.put(newT,set);
solution=newmap;

