% ����Ӧ��������������Ӻ���Ik_com.m 
function f=Ik_com( Dk, Yk)    %�����������
	if  Dk>0  Dsk = 0;
    else    Dsk = 1;
    end
    if Dk==0  Dk=Dk+0.0001;
    end
Dlk = log( abs(Dk) ) / log(2);
Dlnk = Dlk - Yk;         %��һ������
	x=Dlnk;
    a=10;
	if  Dlnk < -0.98   Ik = 0 ;        %�������Ik
    end
    if -0.98 <= Dlnk & Dlnk <  0.62   Ik = 1;
    end
    if 0.62 <= Dlnk & Dlnk <  1.38    Ik = 2;
    end
    if 1.38 <= Dlnk & Dlnk <  1.91    Ik = 3;
    end
    if 1.91 <= Dlnk & Dlnk <  2.34    Ik = 4;
    end
    if  2.34 <= Dlnk & Dlnk <  2.72   Ik = 5;
    end
    if  2.72 <= Dlnk &Dlnk <  3.12    Ik = 6;
    end
    if  Dlnk >= 3.12     Ik = 7;
    end
    if Dsk == 1   Ik=-Ik;
    end
    f= Ik;
