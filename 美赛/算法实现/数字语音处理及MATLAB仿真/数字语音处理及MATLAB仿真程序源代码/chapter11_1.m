% ����11.1��speechenhancement.m
clear all;
%-------------------------------���������ļ�------------------------------------------------------------
[speech,fs,nbits]=wavread('speech_clean1.wav');                            %��������
%-------------------------------��������----------------------------------------------------------------
winsize=256;                                                             %����
n=0.04;                                                             %����ˮƽ
size=length(speech);                                                   %��������
numofwin=floor(size/winsize);                                              %֡��
ham=hamming(winsize)';                                             %����������
hamwin=zeros(1,size);                                         %����������ĳ���
enhanced=zeros(1,size);                                      %������ǿ�����ĳ���
x=speech'+ n*randn(1,size);                                         %���������ź�
noisy=n*randn(1,winsize);                                              %��������
N = fft(noisy);                                                 %����������Ҷ�任
nmag= abs(N);                                                      %����������
%-------------------------------��֡--------------------------------------------------------------------
for q=1:2*numofwin-1
frame=x(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2);      %�Դ�������֡���ص�һ��ȡֵ
hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
hamwin(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+ham;                        %�Ӵ�
y=fft(frame.*ham);                                         %�Դ�����������Ҷ�任
mag = abs(y);                                                   %��������������
phase = angle(y);                                                  %����������λ
%-------------------------------�����׼�-------------------------------------------------------------------
for i=1:winsize
if mag(i)-nmag(i)>0
clean(i)= mag(i)-nmag(i);
else
clean(i)=0;
end
end
%---------------------------%��Ƶ�������ºϳ�����-------------------------------------------------
spectral= clean.*exp(j*phase);
%------------------------������Ҷ�任���ص����---------------------------------------------------
enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)=...
enhanced(1+(q-1)*winsize/2:winsize+(q-1)*winsize/2)+real(ifft(spectral));
end
%---------------------------��ȥHamming�����������-----------------------------------------------
for i=1:size
if hamwin(i)==0
enhanced(i)=0;
else
enhanced(i)=enhanced(i)/hamwin(i);
end
end
%-----------------------������ǿǰ�������--------------------------------------------------------
SNR1 = 10*log10(var(speech')/var(noisy));                           %�������������
SNR2 = 10*log10(var(speech')/var(enhanced-speech'));                 %��ǿ���������
wavwrite(x,fs,nbits,'noisy.wav');                                     %��������ź�
wavwrite(enhanced,fs,nbits,'enhanced.wav');                           %�����ǿ����
%-------------------------------������-----------------------------------------------------------
figure(1);
subplot(3,1,1);plot(speech');
title('ԭʼ��������');
xlabel('������');ylabel('����'); 
axis([0 2.5*10^4 -0.3 0.3]);
subplot(3,1,2);plot(x);
title('������������');
xlabel('������');ylabel('����');
axis([0 2.5*10^4 -0.3 0.3]);
subplot(3,1,3);plot(enhanced);
title('��ǿ��������');
xlabel('������');ylabel('����');axis([0 2.5*10^4 -0.3 0.3]); 
