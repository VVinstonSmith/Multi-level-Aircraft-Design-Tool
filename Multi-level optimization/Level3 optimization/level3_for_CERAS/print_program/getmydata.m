function [front, back] = getmydata( a )

s = num2str(a,'%1.4e');
id = find(s=='e');
s = s(1:id-1);
front = str2num(s);

s = num2str(a,'%1.4e');
id = find(s=='e');
s = s(id+1:end); 
back = str2num(s); 
 
end

