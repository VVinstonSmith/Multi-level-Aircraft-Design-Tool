classdef FUSE_BLOCK
    %UNTITLED34 此处显示有关此类的摘要
    %   此处显示详细说明
    properties
        %% 结点信息
        GRID0_num;
        GRID1_num;
        GRID2_num;
        GRID0_id;
        GRID1_id;
        GRID2_id;
        %% 单元信息
        PBAR_num;
        PBAR_id;
        CBAR1_num;
        CBAR2_num;
        CBAR1_id;
        CBAR2_id;
        %% 质量参数
        RHO;% 单位长度结构质量
        MASS_STR;
        MASS_STR_num;
        MASS_STR_id;
        
        MASS_NSTR;% 非结构质量
        MASS_NSTR_loc;
        MASS_NSTR_num;
        MASS_NSTR_id;
        GRID_NSTR_num;
        GRID_NSTR_id;
        
       %% 材料和刚度参数
        mat_num;
        EI1;
        EI2;
        GJ;
        h;%机身高度
        b;%机身宽度
 
    end
    
    methods
        function plot_block(obj,grids)
            grid0_loc = grids(obj.GRID0_num).loc;
            grid1_loc = grids(obj.GRID1_num).loc;
            grid2_loc = grids(obj.GRID2_num).loc;
            
%             plot3(grid0_loc(1), grid0_loc(2), grid0_loc(3), 'r^');
            plot3([grid1_loc(1),grid0_loc(1)], [grid1_loc(2),grid0_loc(2)], [grid1_loc(3),grid0_loc(3)], '-*'); hold on;   
            plot3([grid2_loc(1),grid0_loc(1)], [grid2_loc(2),grid0_loc(2)], [grid2_loc(3),grid0_loc(3)], '-*'); hold on;   
            
            point1 = grid0_loc + [0,obj.b/2, obj.h/2];
            point2 = grid0_loc + [0, -obj.b/2, obj.h/2];
            point3 = grid0_loc + [0, -obj.b/2, -obj.h/2];
            point4 = grid0_loc + [0, obj.b/2, -obj.h/2];
            plot3([point1(1),point2(1)], [point1(2),point2(2)], [point1(3),point2(3)]); hold on;
            plot3([point2(1),point3(1)], [point2(2),point3(2)], [point2(3),point3(3)]); hold on;
            plot3([point3(1),point4(1)], [point3(2),point4(2)], [point3(3),point4(3)]); hold on;
            plot3([point4(1),point1(1)], [point4(2),point1(2)], [point4(3),point1(3)]); hold on;
            
%             for ii = 1:length(obj.MASS_NSTR)
%                 plot3(obj.MASS_NSTR_loc(ii,1), obj.MASS_NSTR_loc(ii,2), obj.MASS_NSTR_loc(ii,3), 'r^'); hold on;   
%                 plot3([grid0_loc(1),obj.MASS_NSTR_loc(ii,1)], [grid0_loc(2),obj.MASS_NSTR_loc(ii,2)], [grid0_loc(3),obj.MASS_NSTR_loc(ii,3)],'r'); hold on;
%             end
        end

    end
    
end

