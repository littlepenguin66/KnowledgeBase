% ����5.3��formantdetect.m
waveFile='qinghua.wav '; 
[y, fs, nbits] = wavread(waveFile); 
time=(1:length(y))/fs; 
frameSize=floor(40*fs/1000);              % ֡��
startIndex=round(15000);                 % ��ʼ���
% startIndex=round(20000);                 % ��ʼ���
% endIndex=startIndex+frameSize-1;          % ������� 
endIndex=startIndex+frameSize-1;          % ������� 
frame = y(startIndex:endIndex);            % ȡ����֡ 
frameSize=length(frame);
frame2=frame.*hamming(length(frame));    % �� hamming window 
rwy= rceps(frame2);                     % ���� 
%ylen=length(rwy); 
ylen=max(size(rwy)) ;
cepstrum=rwy(1:floor(ylen/2)); 

%������� 
LF=floor(fs/500);
HF=floor(fs/70);
cn=cepstrum(LF:HF);
[mx_cep ind]=max(cn); 

%���������Ĵ��룺 
% �ҵ�����ͻ���λ�� 
NN=ind+LF; 
han= hamming (NN); 
cep=cepstrum(1:NN); 
ceps=cep.*han;                           % hamming window 
formant1=20*log(abs(fft(ceps))); 
formant(1:2)=formant1(1:2); 
for t=3:NN 
%--do some median filtering 
    z=formant1(t-2:t); 
    md=median(z); 
    formant2(t)=md; 
end 
for t=1:NN-1 
    if t<=2 
       formant(t)=formant1(t); 
    else
       formant(t)=formant2(t-1)*0.25+formant2(t)*0.5+formant2(t+1)*0.25;
    end 
end 

subplot(3,1,1); 
plot(cepstrum); 
title('����'); 
xlabel('������');
ylabel('����')
axis([0,220,-0.5,0.5])

spectral=20*log10(abs(fft(frame2))); 
subplot(3,1,2); 
xj=(1:length(spectral)/2)*fs/length(spectral); 
 plot(xj,spectral(1:length(spectral)/2));  
title('Ƶ��'); 
xlabel('Ƶ��/Hz');
ylabel('����/dB')
axis([0,5500,-100,50])

subplot(3,1,3); 
xi=(1:NN/2)*fs/NN; 
plot(xi,formant(1:floor(NN/2))); 
title('ƽ������������'); 
xlabel('Ƶ��/Hz');
ylabel('����/dB')
axis([0,5500,-80,0])
