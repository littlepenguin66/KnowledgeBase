% �����׾�����Ӧ���Ӽ����Ӻ���Yk_com.m 
function [Yk,coe3]=Yk_com(Ik_pre,Alk,Yk_pre,coe3)     %�����׾�����Ӧ���Ӽ���
    Yl_pre_pre=coe3;
    Yu_pre = ( 1 - 2^(-5) ) * Yk_pre + 2^(-5) * wi_result(abs(Ik_pre));    %���ٷ�����������Ӽ���
    Yl_pre = yl_result(Yl_pre_pre,Yu_pre);    %����������Ӽ���
    coe3=Yl_pre;
    Yk=Alk * Yu_pre + ( 1 - Alk) * Yl_pre;

