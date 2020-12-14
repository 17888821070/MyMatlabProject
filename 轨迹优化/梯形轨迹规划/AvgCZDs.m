%%%
%%%此函数是计算一组关节角序列中前1，前2，前3......前n个关节角的平均可操作性度
%%%输入：一组关节角序列的每组关节角对应的可操作度
%%%输出：前1个，前2个，...前n个关节角的平均可操作度
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
