function write_desvars(values_cp)

global span_num_cp
global wing_box_num 
global eta_y_seq
global var_mode
global filename_desvar

global XLB_skin XUB_skin XLB_web XUB_web
global XLB_spar XUB_spar XLB_str XUB_str

x_cp = linspace(0, 1., span_num_cp);
values_cp = reshape(values_cp, var_mode, span_num_cp);
values = zeros(var_mode, wing_box_num); 
for ii=1:var_mode
    bsp = BSpline([x_cp', values_cp(ii,:)'], 4);
    [xs, values(ii,:)] = bsp.evaluate_batch(eta_y_seq(ii,:));
end
 
var_id = 1;
pbar_id = 1;
pshell_id = 1;
for ii=1:wing_box_num
    if var_mode==6 || var_mode==5
        % fspar
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_spar, XUB_spar, [],...
                'wing', ii, 'fspar', ii);
        var_id = var_id + 1;
        % rspar
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_spar, XUB_spar, [],...
                'wing', ii, 'rspar', ii);
        var_id = var_id + 1;
    end
    if var_mode==6
        % str
        XINT = values(var_id);
        LABEL = ['PABR', num2str(pbar_id)]; pbar_id=pbar_id+1;
        desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_str, XUB_str, [],...
                'wing', ii, 'str', ii);
        var_id = var_id + 1;
    end
    % fweb
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_web, XUB_web, [],...
            'wing', ii, 'fweb', ii);
    var_id = var_id + 1;
    % rweb
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_web, XUB_web, [],...
            'wing', ii, 'rweb', ii);
    var_id = var_id + 1;
    % skin
    XINT = values(var_id);
    LABEL = ['PSHEL', num2str(pshell_id)]; pshell_id=pshell_id+1;
    desvar(var_id) = DESVAR(var_id, LABEL, XINT, XLB_skin, XUB_skin, [],...
            'wing', ii, 'skin', ii);
    var_id = var_id + 1;
end
%%  print card
fid=fopen(filename_desvar,'wt');
fprintf(fid,'$..1...||..2...||..3...||..4...||..5...||..6...||..7...||..8...||..9...||..10..|\n');
fprintf(fid,'$DESVAR  ID      LABEL   XINIT   XLB     XUB     DELXV\n');
for ii=1:length(desvar)
    desvar(ii).print_XINT(fid);
end
fclose(fid);


end

