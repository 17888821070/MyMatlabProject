%
% 说明：将double数组转换成一个字符串，可以在hashmap的key是数组的时候转化为字符串作为key
% 参数：PE 需要转化的数组n*1，e 想要保留的数组的精度n*1
% 输出：PE中的数据保留有效位数转化为字符串，各个数据用空格分隔
% 伴生方法PrasePE，将此输出的字符串恢复成数组（只保证打包的精度）
%
function solution = PackPE(PE,e)
                                                                                                            % % 末端位姿
                                                                                                            % PE=[1.666666666,22.11111111,3.2222222,4.333333,5.4444444,6.5555555]
                                                                                                            % % 保留位数
                                                                                                            % e=[0.1,0.1,0.1,0.1,0.1,0.1]
% 化整数
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
