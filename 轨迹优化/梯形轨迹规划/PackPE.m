%
% ˵������double����ת����һ���ַ�����������hashmap��key�������ʱ��ת��Ϊ�ַ�����Ϊkey
% ������PE ��Ҫת��������n*1��e ��Ҫ����������ľ���n*1
% �����PE�е����ݱ�����Чλ��ת��Ϊ�ַ��������������ÿո�ָ�
% ��������PrasePE������������ַ����ָ������飨ֻ��֤����ľ��ȣ�
%
function solution = PackPE(PE,e)
                                                                                                            % % ĩ��λ��
                                                                                                            % PE=[1.666666666,22.11111111,3.2222222,4.333333,5.4444444,6.5555555]
                                                                                                            % % ����λ��
                                                                                                            % e=[0.1,0.1,0.1,0.1,0.1,0.1]
% ������
newPE =  PE./e;
bianmaPE=string("");
len = length(e);
for i=1:len
    newPE(i)=round(newPE(i));
    if i==1
        bianmaPE= newPE(i);
    else
        bianmaPE= bianmaPE + " " + newPE(i);
    end
end
solution=bianmaPE;
% res = ParsePE(solution,e)
