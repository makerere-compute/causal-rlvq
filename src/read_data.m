function [data0, data1, data2] = read_data(dataset)
%% Function to read in the different datasets
%

switch dataset
    case 'lucas'
        load ./data/lucas/lucas
        data0 = lucas0;
        data1 = lucas1;
        data2 = lucas2;
        
    case 'reged'
        load ./data/reged
        data0 = reged0;
        data1 = reged1;
        data2 = reged2;

    case 'cina'
        load ./data/cina
        data0 = cina0;
        data1 = cina1;
        data2 = cina2;

    case 'sido'
        load ./data/sido
        data0 = sido0;
        data1 = sido1;
        data2 = sido2;

    case 'marti'
        load ./data/marti
        data0 = marti0;
        data1 = marti1;
        data2 = marti2;
end
end