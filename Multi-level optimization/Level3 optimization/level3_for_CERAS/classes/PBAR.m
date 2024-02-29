classdef PBAR
    %UNTITLED29 此处显示有关此类的摘要
    %   此处显示详细说明
    properties
        id;
        region;
        M_id;
        M_num;
        A;
        Izz;
        Iyy;
        J;
        h;
        b;
        %
        DVPREL1_A_num;
        DVPREL2_A_num;
        DVPREL2_I1_num;
        DVPREL2_I2_num;
        DVPREL2_J_num;
        desvar_id;
        component;
    end
    
    methods
        function obj = PBAR(id, M_num, A, Izz, Iyy, J, h,b, region)
            obj.id = id;
            obj.M_num = M_num;
            obj.A = A;
            obj.Izz = Izz;
            obj.Iyy = Iyy;
            obj.J = J;
            obj.h = h;
            obj.b = b;
            obj.region = region;
        end

    end
    
end

