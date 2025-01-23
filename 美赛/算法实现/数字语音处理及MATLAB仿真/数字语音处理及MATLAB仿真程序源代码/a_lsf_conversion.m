% a_lsf_conversion.m
function lsf = a_lsf_conversion(a)
%���a����ʵ�������������Ϣ��LSF�������ڸ�����ʽ�����
if ~isreal(a),
    error('Line spectral frequencies are not defined for complex polynomials.');
end
% ���a(1)������1�������һ��Ϊ1
if a(1) ~= 1.0,
    a = a./a(1);%������a��ÿ��Ԫ�س���a(1)�ٸ�������a
end
%�ж�����Ԥ�����ʽ�ĸ��Ƿ��ڵ�λԲ�ڣ�������ڣ������������Ϣ
if (max(abs(roots(a))) >= 1.0),
    error('The polynomial must have all roots inside of the unit circle.');
end
% ��Գƺͷ��Գƶ���ʽ��ϵ��
 p = length(a)-1;  % ��Գƺͷ��Գƶ���ʽ�Ľ״�
a1 = [a;0];        %���о���a������һ��Ԫ��Ϊ0����      
a2 = a1(end:-1:1); %a2�ĵ�һ��Ϊa1�����һ�У����һ��Ϊa1�ĵ�һ��
P1 = a1+a2;        % ��Գƶ���ʽ��ϵ��
Q1 = a1-a2;        % �󷴶Գƶ���ʽ��ϵ�� 
%����״�pΪż���Σ���P1ȡ��ʵ����z =-1����Q1ȡ��ʵ����z =1
%����״�Ϊ�����Σ���Q1ȡ��ʵ����z = 1��z =-1
if rem(p,2),  % ���p����2�����������pΪ�����Σ�����Ϊ1������Ϊ0
    Q = deconv(Q1,[1 0 -1]);%�����״Σ���Q1ȡ��ʵ����z = 1��z =-1
    P = P1;
else          % pΪż���״�ִ���������
    Q = deconv(Q1,[1 -1]);%��Q1ȡ��ʵ����z = 1
    P = deconv(P1,[1  1]);%��P1ȡ��ʵ����z =-1
end
rP  = roots(P);%��ȥ��ʵ����Ķ���ʽP�ĸ�
rQ  = roots(Q);%��ȥ��ʵ����Ķ���ʽQ�ĸ�
aP  = angle(rP(1:2:end));%������ʽP�ĸ�ת��Ϊ�Ƕȣ�Ϊ��һ����Ƶ�ʣ�����ap
aQ  = angle(rQ(1:2:end));%������ʽQ�ĸ�ת��Ϊ�Ƕȣ�Ϊ��һ����Ƶ�ʣ�����aQ
lsf = sort([aP;aQ]);%%��P��Q�ĸ�����һ����Ƶ�ʣ�����С����˳�������Ϊlsf
% EOF a_lsf_conversion.m
