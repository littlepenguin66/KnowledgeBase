% ����������Ӻ�������adpcm.m
function [coe,coe1,coe2,coe3,Dqk]=adpcm(Slk,coe,coe1,coe2,coe3,Dqk)  %��������뺯��  
	Yk_pre = coe2(1);    %��ֵ����
	Sek_pre = coe2(2);
	Ik_pre = coe2(3);
	Ylk_pre_pre = coe2(4);
	Srk_pre = coe2(5);
	Srk_pre_pre = coe2(6);
    a2=coe2(7);
    Tdk_pre =coe2(8);
    Trk_pre =coe2(9); 
	Num=coe2(10);
      
		coe2(10)=coe2(10)+1;
		[Sek,coe] = Sek_com(Srk_pre,Srk_pre_pre,Dqk,coe);  %����ӦԤ��
  
		Dk = Dk_com( Slk, Sek );   %����ֵ�����ֵ��ֵ����
        
		Yuk_pre = yu_result( Yk_pre, wi_result(abs(Ik_pre)) );   %���ٷ�����������Ӽ���

		if   Yuk_pre<1.06
            Yuk_pre=1.06;
        elseif  Yuk_pre>10.00 
            Yuk_pre=10.00;
        end 
        
		Ylk_pre = yl_result( Ylk_pre_pre, Yuk_pre );    %����������Ӽ���
        Trk_pre = Trk_com( a2, Dqk(6), Ylk_pre );  %խ���ź�˲���ж�
        Tdk_pre = Tdk_com( a2 );    %��Ƶ�ź��ж�
		[Alk,coe1]= Alk_com( Ik_pre, Yk_pre ,coe1,Tdk_pre,Trk_pre);     
        %����Ӧ�ٶȿ���������ӦԤ��
       
		if  Alk<0.0
            Alk=0.0;
        elseif  Alk>1.0
            Alk=1.0;
        end 
        
		[Yk,coe3]=Yk_com(Ik_pre,Alk,Yk_pre,coe3);     %�����׾�����Ӧ���Ӽ���

		Ik = Ik_com( Dk, Yk );     %����Ӧ�������������

        Yk_pre = Yk;
		Srk_pre_pre = Srk_pre;
		Sek_pre = Sek;
		Ylk_pre_pre = Ylk_pre;
		Ik_pre = Ik;
        
		coe2(1)= Yk;
		coe2(6)= Srk_pre;
		coe2(2)= Sek;
		coe2(4)= Ylk_pre;
		coe2(3)= Ik; 

		Dqk(1) = Dqk(2);
		Dqk(2) = Dqk(3);
		Dqk(3) = Dqk(4);
		Dqk(4) = Dqk(5);
		Dqk(5) = Dqk(6);
		Dqk(6) = Dqk(7);

		Dqk(7) = Dqk_com( Ik_pre,Yk_pre);     %����Ӧ�����������
 		Srk_pre = Srk_com( Dqk(7), Sek_pre);    %�ؽ��ź����
         coe2(5)=Srk_pre;
