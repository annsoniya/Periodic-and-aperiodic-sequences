% function rows1= container_map_for_roi(data.db)
    load('db_sig_cells_only.mat');
    db=db_sig_cells_only;
    fname_to_rows_map= containers.Map;
    fname_order = {}; % Cell array to store the order of the keys
    for u = 1:size(db,1)
        fname = db{u,1};
        fname = fname{1};
    
        if isKey(fname_to_rows_map, fname)
            rows = fname_to_rows_map(fname);
            rows = [rows; u];
            fname_to_rows_map(fname) = rows;
        else
            fname_to_rows_map(fname) = [u];
            fname_order = [fname_order; fname]; % Add the new key to the order array
        end
    end
    
    % Use fname_order instead of keys(fname_to_rows_map) to maintain the order
    for k = 1:length(fname_order)
     rows2{k}=fname_to_rows_map(fname_order{k});
    end
    
    end
