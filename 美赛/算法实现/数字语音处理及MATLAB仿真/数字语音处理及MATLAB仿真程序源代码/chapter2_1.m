%����2.1��sanjiaobopinpu.m
%���ǲ�����Ƶ��
n=linspace(0,25,125);
g=zeros(1,length(n));
i=0;
for i=0:40
   if n(i+1)<=5
       g(i+1)=0.5*(1-cos(n(i+1)*pi/5));
   else
       g(i+1)=cos((n(i+1)-5)*pi/8);
   end
end
figure(1)
subplot(121)
plot(n,g)
xlabel('ʱ��/ms')
ylabel('����')
gtext('N1')
gtext('N1+N2')
axis([0,25,-0.4,1.2])

r=fft(g,1024);%���ź�g����1024�㸵��Ҷ�任
r1=abs(r);%��rȡ����ֵ r1��ʾƵ�׵ķ���ֵ
yuanlai=20*log10(r1);%�Է�ֵȡ����
signal(1:64)=yuanlai(1:64);%ȡ64���㣬Ŀ���ǻ�ͼ��ʱ��ά��һ��
pinlv=(0:1:63)*8000/512; %���Ƶ�ʵĶ�Ӧ��ϵ
subplot(122)
plot(pinlv,signal);
xlabel('Ƶ��/Hz')
ylabel('����/dB')
axis([0,620,0,30])
