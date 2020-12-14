function Solution=TtoPE(m)
a=m;
P=[a(1,4),a(2,4),a(3,4)];
R=m(1:3,1:3);
E=RbtTrtoEulerZyx(R);
PE=[P(1),P(2),P(3),E(1),E(2),E(3)];
Solution=PE;