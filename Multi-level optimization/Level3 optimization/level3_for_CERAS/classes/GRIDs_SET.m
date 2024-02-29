classdef GRIDs_SET
    % 结构插值点    
    properties
        id;
        region;
        sub_region;
        GRIDs_num;
        GRIDs_id;
    end
    
    methods
        function obj = GRIDs_SET(id, region, sub_region)
            obj.id = id;
            obj.region = region;
            obj.sub_region = sub_region;
        end
        
        function obj=sort_x(obj,grids)
            n_grids = length(obj.GRIDs_num);
            for ii=1:n_grids-1
                max_x = -1e10; 
                j_max = 0;
                for jj=1:n_grids+1-ii
                    tmp = grids(obj.GRIDs_num(jj)).loc(1) + 1e-5 * grids(obj.GRIDs_num(jj)).loc(3);
                    if(tmp>max_x)
                        max_x = tmp;
                        j_max = jj;
                    end
                end
                mid = obj.GRIDs_num(j_max);
                obj.GRIDs_num(j_max) = obj.GRIDs_num(n_grids+1-ii);
                obj.GRIDs_num(n_grids+1-ii) = mid;     
            end
        end
        function plot(obj,grids,color)
            for ii = 1:length(obj.GRIDs_num)
                loc = grids(obj.GRIDs_num(ii)).loc;
                plot3(loc(1),loc(2),loc(3),color); hold on;
            end
        end
    end 
end
