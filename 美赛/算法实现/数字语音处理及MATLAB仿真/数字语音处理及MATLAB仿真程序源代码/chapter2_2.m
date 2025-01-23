%����2.2������ͼ����
clear all;
[x,sr]=wavread('Beijing.wav');                %srΪ����Ƶ��
if (size(x,1)>size(x,2))                      %size(x,1)Ϊx��������size(x,2)Ϊx������
    x=x';
end
s=length(x);
w=round(44*sr/1000);                     %����,ȡ��44*sr/100���������
n=w;                                   %fft�ĵ���
ov=w/2;                                %50%���ص�
h=w-ov;
% win=hanning(n)';                       %������
win=hamming(n)';                        %������
c=1;
ncols=1+fix((s-n)/h);                      %fix�����ǽ�(s-n)/h��С���hȥ
d=zeros((1+n/2),ncols);
for b=0:h:(s-n)
    u=win.*x((b+1):(b+n));
    t=fft(u);
    d(:,c)=t(1:(1+n/2))';
    c=c+1;
end
tt=[0:h:(s-n)]/sr;
ff=[0:(n/2)]*sr/n;
imagesc(tt/1000,ff/1000,20*log10(abs(d)));
colormap(gray);
axis xy
xlabel('ʱ��/s');
ylabel('Ƶ��/kHz');
