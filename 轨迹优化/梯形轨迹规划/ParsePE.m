%
% 说明：PackPE打包得到的字符串恢复成数组
% 参数：bianmaPE 使用PackPE函数打包得到的字符串，e 打包时保留的数组的精度n*1
% 输出：恢复出来的数组 n*1
% 伴生方法PackPE，本方法是为了恢复PackPE打包字符串设计的
%
function solution =ParsePE(bianmaPE,e)
angles = split(bianmaPE);
len = length(angles)
for i=1:len
    solution(i)=double(angles(i))*e(i);
end
