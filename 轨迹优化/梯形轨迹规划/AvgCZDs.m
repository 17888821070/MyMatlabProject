%%%
%%%�˺����Ǽ���һ��ؽڽ�������ǰ1��ǰ2��ǰ3......ǰn���ؽڽǵ�ƽ���ɲ����Զ�
%%%���룺һ��ؽڽ����е�ÿ��ؽڽǶ�Ӧ�Ŀɲ�����
%%%�����ǰ1����ǰ2����...ǰn���ؽڽǵ�ƽ���ɲ�����
%%%
function solution = AvgCZDs(czd)
N = length(czd);
dp = zeros(N,1);
dp(1)=czd(1);
for i=2:N
    dp(i)=dp(i-1)*(i-1)+czd(i);
    dp(i)=dp(i)/i;
end
solution = dp;
