function[x,y] = meanplots_cumulative(periodic,aperiodic)
%% periodic and aperiodic are mean rate for each segments( cumulative or segmentwise data )
x=zeros(size(periodic,1),size(periodic,2));
y=zeros(size(aperiodic,1),size(aperiodic,2));
for units= 1:size(periodic,1)
    for col=1:size(periodic,2)

        x(units,col)=nanmean(cell2mat(periodic(units,col)),1);
        y(units,col)=nanmean(cell2mat(aperiodic(units,col)),1);
    end

end
end
