% խ���ź�˲���ж��Ӻ���Trk_com.m 
function Trk=Trk_com( A2k, Dqk, Ylk)   %խ���ź�˲���ж�
  if ( ( A2k < -0.71875 ) & ( fabs(Dqk) > pow(24.2,Ylk) ) )    Trk=1;
  else    Trk=0;
  end
  Trk=Trk;
