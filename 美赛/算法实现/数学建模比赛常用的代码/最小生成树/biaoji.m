function re=biaoji(j,biao)  %�ж�j���Ƿ��ѱ����
    l=length(biao);
    for i=1:l
       if j==biao(i) 
            re=1;
            return;
       end
    end
    re=0;
    return;
end