% ����4.4��ShortTimeAdd.m
clear all;
s=wavread('speech.wav');      %����һ������
s=s';                       %��sת��
N=length(s);                %���������ĳ���
L=280;                    %����
R=L/4;                    %֡��
w=hamming(L);            %������
w=w';                    %��wת��
k=((N-mod(N,R))/R);        %��N����R�ı����������ʣ���ȥ����������
%ȡһ֡������ֱ��ȡ��
for i=0:k-1
for n=(1+i*R):((i+1)*R)
    y(n)=s(n)*(w((i+1)*R-n+1)+w((i+2)*R-n+1)+w((i+3)*R-n+1)+w((i+4)*R-n+1));
end
b=[y((1+i*R):((i+1)*R)),zeros(1,3*R)];  %��y��3R���㣬ʹ�ﵽL��
c=fft(b,L);                         % ��b����L�㸵��Ҷ�任
d=ifft(c,L);                        %��c����L�㸵��Ҷ��任
e((1+i*R):((i+1)*R))=d(1:R);         %�洢����
end
e=e/max(abs(e));
wavwrite(e,'wnt.wav');              %��eд��wav�ļ�wnt
wavplay(e,8000);                  %����wnt�ļ�
%��ͼ
figure(1);
subplot(2,1,1);
plot(s);
title('��������');
xlabel('������');
ylabel('����');
subplot(2,1,2);
plot(e);
title('�������');
xlabel('������');
ylabel('����');
