function plot_result(Result,fig_number,type,legend1,title1,fontsize,plot_type,sgofilter_strength)

    % Define X and Y values
    Ax = Result(:,1);
    Ay = Result(:,2);
    
    % Filter
    if (sgofilter_strength > 0)
        % 1st order filtering
        Ay = sgolayfilt(Ay,1,sgofilter_strength);
    end

    % Calculate eV values if needed
    if (strcmp(type,'ev'))
        Ax = nm_to_ev(Ax);
        xlabel1 = 'Energy [eV]';
    else
       xlabel1 = 'Wavelength [nm]';
    end

    % Detect same figure plot
    cf = get(0,'CurrentFigure');
    fill_info = 0;
    if (isempty(cf))
        fill_info = 1;
    end
    if (cf ~= fig_number)
       fill_info = 1; 
    end
    
    % Plot
    fig = figure(fig_number);

    if (fill_info)
        axes1 = axes('Parent',fig,'FontSize',fontsize);
        box(axes1,'on');
    
        hold(axes1,'all');
        hold on;
    end

    plot(Ax,Ay,plot_type);
    
    % If no figure exists, input info
    if (fill_info) % Don't add info twice
        legend(legend1);
        title(title1);
        ylabel('Counts');
        xlabel(xlabel1);
    end
end