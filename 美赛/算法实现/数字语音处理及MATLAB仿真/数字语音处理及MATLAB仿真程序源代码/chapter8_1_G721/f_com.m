% ����ӦԤ����f����ֵ�����Ӻ���f_com.m  
function b=f_com(a)     %f����ֵ����
 if  abs(a)<=0.5
     b=4*a;
     else b=2*sgn_com(a);
 end
