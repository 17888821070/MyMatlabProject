%
% ���ã����ݹؽڽǼ���ĩ��λ��
% �������ؽڽ�����
% �����ĩ��λ��
%
function solution = AnglesToPE(angles)
T = GetTnm(angles,0,7);
solution=TtoPE(T);