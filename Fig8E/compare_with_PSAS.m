function csi = compare_with_PSAS(x1,y1,x2,y2,x3,y3,x4,y4)

% Remove NaN and Inf values if sizes do not match
    nanInfIdx_x1 = isnan(x1) | isinf(x1);
    nanInfIdx_y1 = isnan(y1) | isinf(y1);
    nanInfIdx = nanInfIdx_x1 | nanInfIdx_y1; % Combine NaN and Inf indices
    x1(nanInfIdx) = [];
    y1(nanInfIdx) = [];


    nanInfIdx_x2 = isnan(x2) | isinf(x2);
    nanInfIdx_y2 = isnan(y2) | isinf(y2);
    nanInfIdx = nanInfIdx_x2 | nanInfIdx_y2; % Combine NaN and Inf indices
    x2(nanInfIdx) = [];
    y2(nanInfIdx) = [];

        nanInfIdx_x3 = isnan(x3) | isinf(x3);
    nanInfIdx_y3 = isnan(y3) | isinf(y3);
    nanInfIdx = nanInfIdx_x3 | nanInfIdx_y3; % Combine NaN and Inf indices
    x3(nanInfIdx) = [];
    y3(nanInfIdx) = [];


    nanInfIdx_x4 = isnan(x4) | isinf(x4);
    nanInfIdx_y4 = isnan(y4) | isinf(y4);
    nanInfIdx = nanInfIdx_x4 | nanInfIdx_y4; % Combine NaN and Inf indices
   x4(nanInfIdx) = [];
    y4(nanInfIdx) = [];
%     csi.ps_with=(x1-y1)./(x1+y1);
%     csi.as.with=(x2-y2)./(x2+y2);
%     csi.ps_without=(x3-y3)./(x3+y3);
%     csi.as.without=(x4-y4)./(x4+y4);
    %bootstrap
    for i=1:1000
        idx1=randi(length(x1),length(x1),1);
        idx2=randi(length(x2),length(x2),1);
        idx3=randi(length(x3),length(x3),1);
        idx4=randi(length(x4),length(x4),1);

        csi.ps_with_b(i,1)=mean((x1(idx1)-y1(idx1))./(x1(idx1)+y1(idx1)));
        csi.as_with_b(i,1)=mean((x2(idx2)-y2(idx2))./(x2(idx2)+y2(idx2)));
        csi.ps_without_b(i,1)=mean((x3(idx3)-y3(idx3))./(x3(idx3)+y3(idx3)));
        csi.as_without_b(i,1)=mean((x4(idx4)-y4(idx4))./(x4(idx4)+y4(idx4)));
    end
    %ci
    csi.ps_with_ci=prctile(csi.ps_with_b,[2.5 97.5]);
    csi.as_with_ci=prctile(csi.as_with_b,[2.5 97.5]);
    csi.ps_without_ci=prctile(csi.ps_without_b,[2.5 97.5]);
    csi.as_without_ci=prctile(csi.as_without_b,[2.5 97.5]);
    %plot

end
