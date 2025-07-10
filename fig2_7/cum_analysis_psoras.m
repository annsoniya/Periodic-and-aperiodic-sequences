function cum_perrand_gap = cum_analysis_psoras(data_per, data_aper, startBin, endBins, gap)
    % can b usedfor allgaps 
    cum_data_per = cell(size(data_per, 1), length(endBins));
    cum_data_aper = cell(size(data_aper, 1), length(endBins));

    p_t_both = zeros(size(data_per, 1), length(endBins));
    h_t_both = zeros(size(data_per, 1), length(endBins));

    p_t_rt = zeros(size(data_per, 1), length(endBins));
    h_t_rt = zeros(size(data_per, 1), length(endBins));

    p_t_lt = zeros(size(data_per, 1), length(endBins));
    h_t_lt = zeros(size(data_per, 1), length(endBins));


    [cum_data_per, cum_data_aper] = find_cumulativeMean(data_per, data_aper, startBin, endBins);

    % TOCLASSY-ttest
    for i = 1:size(cum_data_per, 1)
        for j = 1:size(cum_data_per, 2)
            % Exclude NaN 
            x = cum_data_per{i, j};
            y = cum_data_aper{i, j};
            x = x(~isnan(x));
            y = y(~isnan(y));

       
            [h_t_both(i, j), p_t_both(i, j)] = ttest2(x, y, 'Tail', 'both', 'Alpha', 0.05, 'Vartype', 'unequal');
            [h_t_rt(i, j), p_t_rt(i, j)] = ttest2(x, y, 'Tail', 'right', 'Alpha', 0.05, 'Vartype', 'unequal');
            [h_t_lt(i, j), p_t_lt(i, j)] = ttest2(x, y, 'Tail', 'left', 'Alpha', 0.05, 'Vartype', 'unequal');
        end
    end

    % Initialize the result structure
    %cum_perrand_gap = struct();
    h_sets = {h_t_both, h_t_rt, h_t_lt};
    p_sets = {p_t_both, p_t_rt, p_t_lt};
    categories = {'diff', 'periodic', 'aperiodic'};


    for k = 1:length(categories)
        h = h_sets{k};
        p = p_sets{k};


        numSegments_h1 = sum(h, 'omitnan');
        columnSums = sum(h, 1, 'omitnan');
        rowsWithOne = any(h == 1, 2);
        indicesOfNeurons = find(rowsWithOne);
        numberOfNeurons = numel(indicesOfNeurons);
        tot_nof_segments = sum(numSegments_h1);

     
        categoryName = sprintf('%s%d', categories{k}, gap);
        cum_perrand_gap.(categoryName).index = indicesOfNeurons;
        cum_perrand_gap.(categoryName).numberOfNeurons = numberOfNeurons;
        cum_perrand_gap.(categoryName).tot_nof_segments = tot_nof_segments;
        cum_perrand_gap.(categoryName).h = h;
        cum_perrand_gap.(categoryName).p = p;
        cum_perrand_gap.(categoryName).columnSums = columnSums;
        cum_perrand_gap.(categoryName).cum_data_per = cum_data_per;
        cum_perrand_gap.(categoryName).cum_data_aper = cum_data_aper;
    end
end
