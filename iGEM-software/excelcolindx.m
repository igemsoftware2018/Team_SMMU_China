
function indx_str=excelcolindx(i)
%����ֵ�����ת��Ϊexcel�е����

if mod(i,26)~=0
    str=dec2base(i,26);
    indx_str=str;
    for j=1:length(str)
        if abs(str(j))>=abs('1')&&abs(str(j))<=abs('9')
            indx_str(j)=setstr(abs(str(j))+16);
        elseif abs(str(j))>=abs('A')&&abs(str(j))<=abs('P')
            indx_str(j)=setstr(abs(str(j))+9);
        else
            error('�����ܵĴ���');
        end
    end
else
    i=i-1;
    str=dec2base(i,26);
    indx_str=str;    
    for j=1:length(str)
        if abs(str(j))>=abs('1')&&abs(str(j))<=abs('9')
            indx_str(j)=setstr(abs(str(j))+17);
        elseif abs(str(j))>=abs('A')&&abs(str(j))<=abs('P')
            indx_str(j)=setstr(abs(str(j))+10);
        else
            error('�����ܵĴ���');
        end
    end    
end
end