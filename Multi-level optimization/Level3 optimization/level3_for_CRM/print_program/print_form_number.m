function y = print_form_number(fid,x)
y=0;

if x==0
    fprintf(fid,'%-7.1f ',0);
    return;
end

if abs(x)>=1000
    if x<0
        x=-x;
        [front, back] = getmydata(x);
        fprintf(fid,'%-4.2f+',-front);
        fprintf(fid,'%1d ',back);
    else
        [front, back] = getmydata(x);
        fprintf(fid,'%-4.2f+',front);
        fprintf(fid,'%02d ',back);
    end    
elseif abs(x)>=100
    fprintf(fid,'%-7.2f ',x);
elseif abs(x)>=10
    fprintf(fid,'%-7.3f ',x);
elseif abs(x)>=0.01
    fprintf(fid,'%-7.4f ',x);
else
    if x<0
        if abs(x)<=1e-9
            x=-x;
            [front, back] = getmydata(x);
            fprintf(fid,'%-4.1f',-front);
            fprintf(fid,'%1d ',back);
        else
            x=-x;
            [front, back] = getmydata(x);
            fprintf(fid,'%-4.2f',-front);
            fprintf(fid,'%1d ',back);
        end    
    else
        if x<=1e-9
            [front, back] = getmydata(x);
            fprintf(fid,'%-4.2f',front);
            fprintf(fid,'%2d ',back);   
        else
            [front, back] = getmydata(x);
            fprintf(fid,'%-4.3f',front);
            fprintf(fid,'%2d ',back);
        end
    end    
end


end

