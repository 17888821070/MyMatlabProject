%
% ˵����PackPE����õ����ַ����ָ�������
% ������bianmaPE ʹ��PackPE��������õ����ַ�����e ���ʱ����������ľ���n*1
% ������ָ����������� n*1
% ��������PackPE����������Ϊ�˻ָ�PackPE����ַ�����Ƶ�
%
function solution =ParsePE(bianmaPE,e)
angles = split(bianmaPE);
len = length(angles)
for i=1:len
    solution(i)=double(angles(i))*e(i);
end
