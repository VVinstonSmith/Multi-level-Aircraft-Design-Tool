function [WEIGHT, stress_vio_max,...
            disp_vio_max, twist_vio_max, roll_eff_vio, flutter_vio] = read_obj_paras(file_name)

fid = fopen(file_name);

stress_vio_max = 0;
disp_vio_max = 0;
twist_vio_max = 0;
roll_eff_vio = 0;
flutter_vio = 0;

%% read results
while ~feof(fid)
    tline=fgetl(fid);
    if length(tline)>80
        if ~isempty(strfind(tline, 'R E S P O N S E S    IN    D E S I G N    M O D E L'))
            %disp(tline);
            break;
        end
    end
end

while ~feof(fid)
    tline=fgetl(fid);
    %% STRESS RESPONSES
    if ~isempty(strfind(tline, '-----    STRESS RESPONSES    -----'))
        fgetl(fid); tline=fgetl(fid);
        while length(tline)>10 && isempty(strfind(tline, 'NASTRAN'))
            if ~isempty(strfind(tline, 'V'))
                string = strsplit(tline(end-44:end));
                if strcmp(string(end),'V') || strcmp(string(end-3),'V')
                    if strcmp(string(end),'V')
                        violate = str2double(string(end-2)) - str2double(string(end-1));
                        %val = str2double(string(end-2));
                        %string(end-2)
                    elseif strcmp(string(end-3),'V')
                        violate = str2double(string(end-2)) - str2double(string(end-4));
                        %val = str2double(string(end-2));
                        %string(end-2)
                    else
                        disp('error');
                    end
                    if abs(violate)>abs(stress_vio_max)
                        stress_vio_max = violate;
                        %stress_violate_value = val;
                    end
                end
            end
            tline=fgetl(fid);
        end
    end
    %% DRESP2 RESPONSES
    if ~isempty(strfind(tline, '---- RETAINED DRESP2 RESPONSES ----'))
        fgetl(fid); tline=fgetl(fid);
        while length(tline)>10 && isempty(strfind(tline, 'NASTRAN'))
            if ~isempty(strfind(tline, 'V'))
                string = strsplit(tline(end-50:end));
                if strcmp(string(end),'V') || strcmp(string(end-3),'V')
                    dresp_name = strsplit(tline(1:48));
                    dresp_name = dresp_name{4};
                    if strcmp(string(end),'V')
                        violate = str2double(string(end-2)) - str2double(string(end-1));
                        %val = str2double(string(end-2));
                        %string(end-2)
                    elseif strcmp(string(end-3),'V')
                        violate = str2double(string(end-2)) - str2double(string(end-4));
                        %val = str2double(string(end-2));
                        %string(end-2)
                    else
                        disp('error');
                    end
                    % which dresp2
                    if ~isempty(strfind(dresp_name, 'DISP'))
                        if abs(violate)>abs(disp_vio_max)
                            disp_vio_max = violate;
                            %disp_violate_value = val;
                        end
                    elseif ~isempty(strfind(dresp_name, 'TWIST'))
                        if abs(violate)>abs(twist_vio_max)
                            twist_vio_max = violate;
                            %twist_violate_value = val;
                        end
                    elseif ~isempty(strfind(dresp_name, 'ROLLEFF'))
                        if abs(violate)>abs(roll_eff_vio)
                            roll_eff_vio = violate;
                            %roll_eff_violate_value = val;
                        end
                    elseif ~isempty(strfind(dresp_name, 'GDAMP'))
                        if abs(violate)>abs(flutter_vio)
                            flutter_vio = violate;
                        end 
                    else
                        disp('error');
                    end
                end
            end
            tline=fgetl(fid);    
        end
    end
    %% WEIGHT RESPONSES
    if ~isempty(strfind(tline, '-----    WEIGHT RESPONSE    -----'))
        fgetl(fid); tline=fgetl(fid);
        while length(tline)>10 && isempty(strfind(tline, 'NASTRAN'))
            if ~isempty(strfind(tline, 'WEIGHT'))
                string = strsplit(tline(80:98));
                WEIGHT = str2double(string(2));
                break;
            end
            tline=fgetl(fid);
        end
    end
end

fclose(fid);


end

