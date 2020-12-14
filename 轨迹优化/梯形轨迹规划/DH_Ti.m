function Solution=DH_Ti(m)
a=m;
b = [cos(a(4)),-sin(a(4)),0,a(1);
    sin(a(4))*cos(a(2)),cos(a(4))*cos(a(2)),-sin(a(2)),-a(3)*sin(a(2));
    sin(a(4))*sin(a(2)),cos(a(4))*sin(a(2)),cos(a(2)),a(3)*cos(a(2));
    0,0,0,1];
Solution=b;