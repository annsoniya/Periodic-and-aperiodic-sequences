% Assume u, v, w, x are the given matrices
clear;
    cd('D:\ann_project2\AUV_AUD_singleunit_data_analysis\codes\ann_project2_aud_auv\ann_project2_aud_auv\dataclassi_selectivity and generalisation\saved_mats_aud')
load('cum_perrand_gap_70.mat')
load('cum_perrand_gap_120.mat')
load('cum_perrand_gap_170.mat')
load('cum_perrand_gap_270.mat')
%%  periodic set - run both set seperately 
total=size(cum_perrand_gap_270.aperiodic270.cum_data_aper ,1);
u=cum_perrand_gap_70.periodic70.index  ;
v=cum_perrand_gap_120.periodic120.index    ;
w=cum_perrand_gap_170.periodic170.index   ;
x=cum_perrand_gap_270.periodic270.index  ;
% display number of elements in each matrix in a asingle line
disp(['Number of elements in u: ', num2str(numel(u)), ...
      ', v: ', num2str(numel(v)), ...
      ', w: ', num2str(numel(w)), ...
      ', x: ', num2str(numel(x))]);
      %calculate teh percentage of elements in each matrix by  total
disp(['Percentage of elements in u: ', num2str(numel(u)/total*100), ...
      ', v: ', num2str(numel(v)/total*100), ...
      ', w: ', num2str(numel(w)/total*100), ...
      ', x: ', num2str(numel(x)/total*100)]);

u_flat = u(:);
v_flat = v(:);
w_flat = w(:);
x_flat = x(:);

uv_intersection = intersect(u_flat, v_flat);
disp(['Number of elements in intersection of 70,120: ', num2str(numel(uv_intersection))]);
disp(['Percentage of elements in intersection of 70,120: ', num2str(numel(uv_intersection)/total*100)]);

% u,w
disp(['Number of elements in intersection of 70,170: ', num2str(numel(intersect(u_flat, w_flat)))]);
disp(['Percentage of elements in intersection of 70,170: ', num2str(numel(intersect(u_flat, w_flat))/total*100)]);
% u,x
disp(['Number of elements in intersection of 70,270: ', num2str(numel(intersect(u_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 70,270: ', num2str(numel(intersect(u_flat, x_flat))/total*100)]);
% v,w
disp(['Number of elements in intersection of 120,170: ', num2str(numel(intersect(v_flat, w_flat)))]);
disp(['Percentage of elements in intersection of 120,170: ', num2str(numel(intersect(v_flat, w_flat))/total*100)]);
% v,x   
disp(['Number of elements in intersection of 120,270: ', num2str(numel(intersect(v_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 120,270: ', num2str(numel(intersect(v_flat, x_flat))/total*100)]);
% w,x
disp(['Number of elements in intersection of 170,270: ', num2str(numel(intersect(w_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 170,270: ', num2str(numel(intersect(w_flat, x_flat))/total*100)]);

uvw_intersection = intersect(uv_intersection, w_flat);

final_intersection = intersect(uvw_intersection, x_flat);

disp('The intersection of the four matrices is:');
disp(final_intersection);

uv_union = union(u_flat, v_flat);
uvw_union = union(uv_union, w_flat);
final_union = union(uvw_union, x_flat);
disp('The union of the four matrices is:');
disp(final_union);

%% aperiodic set 
u=cum_perrand_gap_70.aperiodic70.index  ;
v=cum_perrand_gap_120.aperiodic120.index  ;
w=cum_perrand_gap_170.aperiodic170.index  ;
x=cum_perrand_gap_270.aperiodic270.index  ;

% display number of elements in each matrix in a asingle line
disp(['Number of elements in u: ', num2str(numel(u)), ...
      ', v: ', num2str(numel(v)), ...
      ', w: ', num2str(numel(w)), ...
      ', x: ', num2str(numel(x))]);
      %calculate teh percentage of elements in each matrix by  total
disp(['Percentage of elements in u: ', num2str(numel(u)/total*100), ...
      ', v: ', num2str(numel(v)/total*100), ...
      ', w: ', num2str(numel(w)/total*100), ...
      ', x: ', num2str(numel(x)/total*100)]);

u_flat = u(:);
v_flat = v(:);
w_flat = w(:);
x_flat = x(:);

uv_intersection = intersect(u_flat, v_flat);
disp(['Number of elements in intersection of 70,120: ', num2str(numel(uv_intersection))]);
disp(['Percentage of elements in intersection of 70,120: ', num2str(numel(uv_intersection)/total*100)]);

% u,w
disp(['Number of elements in intersection of 70,170: ', num2str(numel(intersect(u_flat, w_flat)))]);
disp(['Percentage of elements in intersection of 70,170: ', num2str(numel(intersect(u_flat, w_flat))/total*100)]);
% u,x
disp(['Number of elements in intersection of 70,270: ', num2str(numel(intersect(u_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 70,270: ', num2str(numel(intersect(u_flat, x_flat))/total*100)]);
% v,w
disp(['Number of elements in intersection of 120,170: ', num2str(numel(intersect(v_flat, w_flat)))]);
disp(['Percentage of elements in intersection of 120,170: ', num2str(numel(intersect(v_flat, w_flat))/total*100)]);
% v,x   
disp(['Number of elements in intersection of 120,270: ', num2str(numel(intersect(v_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 120,270: ', num2str(numel(intersect(v_flat, x_flat))/total*100)]);
% w,x
disp(['Number of elements in intersection of 170,270: ', num2str(numel(intersect(w_flat, x_flat)))]);
disp(['Percentage of elements in intersection of 170,270: ', num2str(numel(intersect(w_flat, x_flat))/total*100)]);

uvw_intersection = intersect(uv_intersection, w_flat);

final_intersection = intersect(uvw_intersection, x_flat);

disp('The intersection of the four matrices is:');
disp(final_intersection);

uv_union = union(u_flat, v_flat);
uvw_union = union(uv_union, w_flat);
final_union = union(uvw_union, x_flat);
disp('The union of the four matrices is:');
disp(final_union);