classdef CQUAD
    %UNTITLED46 此处显示有关此类的摘要
    %   此处显示详细说明
    properties
        id;
        p_num;
        pid;
        region;
        GRID1_num;
        GRID2_num;
        GRID3_num;
        GRID4_num;
    end 
    %1-------2
    %|       |
    %|       |
    %4-------3
    methods
        function obj = CQUAD(id,p_num, GRID1_num,GRID2_num,GRID3_num,GRID4_num, region)
            obj.id = id;
            obj.p_num = p_num;
            obj.region = region;
            obj.GRID1_num = GRID1_num;
            obj.GRID2_num = GRID2_num;
            obj.GRID3_num = GRID3_num;
            obj.GRID4_num = GRID4_num;
        end       
        function [m, X] = mass_center(obj, grids,pshell,mat)
            P1 = grids(obj.GRID1_num).loc;
            P2 = grids(obj.GRID2_num).loc;
            P3 = grids(obj.GRID3_num).loc;
            P4 = grids(obj.GRID4_num).loc;
            S1 = S_triangle(P1,P2,P3);
            S2 = S_triangle(P1,P3,P4);
            X = ((P1+P2+P3)*S1 + (P1+P3+P4)*S2)/(S1+S2);    
            X = X/3;
            m = (S1+S2)*pshell(obj.p_num).thick * mat(pshell(obj.p_num).M_num).RHO;
        end
    end
    
end

