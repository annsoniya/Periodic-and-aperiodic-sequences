function[x,y] = meanplots_cumulative(periodic,aperiodic)
%% periodic and aperiodic are mean rate for each segments( cumulative or segmentwise data )

for units= 1:size(periodic,1)
    for col=1:size(periodic,2)

        x(units,col)=nanmean(cell2mat(periodic(units,col)),1);
        y(units,col)=nanmean(cell2mat(aperiodic(units,col)),1);
    end

end
t=find(isnan(y(:,1)));
y(t,:)=[];
x(t,:)=[];
t=find(isnan(x(:,1)));
y(t,:)=[];
x(t,:)=[];
end
