function psth_process(xin, binsize, no_bins)
xx=mean(xin);
for ii=1:no_bins
    yy(ii) = sum(xx((ii-1)*binsize+1:ii*binsize));
    yy(ii) = yy(ii) * (1000 / binsize);
end
xlim([0 no_bins+10]);
%ylim([0 10]);
%xline(8,'g','LineWidth',1.5,'LineStyle','--');% start of the strim
%xline(no_bins-16,'g','LineWidth',1.5,'LineStyle','--');% end of the strim

%plot(yy,'k','LineWidth',1.5,'LineStyle','-');
hold on;
plot(gaussmoth(yy,1),'k','LineWidth',1,'LineStyle','-');
end
