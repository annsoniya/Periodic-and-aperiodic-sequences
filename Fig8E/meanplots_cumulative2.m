function[x,y] = meanplots_cumulative2(periodic,aperiodic)
%% periodic and aperiodic are mean rate for each segments( cumulative or segmentwise data )

for units= 1:size(periodic,1)
    % if sum(isnan(cell2mat(periodic(units,:)))) + sum(isnan(cell2mat(aperiodic(units,:)))) ==0
    for col=1:size(periodic,2)

        x(units,col)=nanmean(cell2mat(periodic(units,col)),1);
        y(units,col)=nanmean(cell2mat(aperiodic(units,col)),1);
        % end
    end



end
end
