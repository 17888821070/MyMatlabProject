% ����ĳ����״̬�µľ���֧��,����ƽ��/2
function Solution=GetJ(Xp,Xe)
D=[ 1,0,0,0,0;
    0,1,0,0,0;
    0,0,1,0,0];
Solution = 1/2 * ( D * (Xp' - Xe') )' * D * (Xp' - Xe');