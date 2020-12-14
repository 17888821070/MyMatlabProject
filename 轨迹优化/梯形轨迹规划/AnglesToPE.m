%
% 作用：根据关节角计算末端位姿
% 参数：关节角序列
% 输出：末端位姿
%
function solution = AnglesToPE(angles)
T = GetTnm(angles,0,7);
solution=TtoPE(T);