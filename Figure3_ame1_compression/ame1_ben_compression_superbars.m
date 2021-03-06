% Script for creating superbars
conditions_cell = {'untreated', 'ben20', 'ben100'};
label_cell = {'Untreated'; '68 \muM'; '313 \muM'};
S = intensity_quant('ame1_ben_data.mat', conditions_cell);
metrics_cell = {...
    'c1_mean_bgsub_array', ...
    'c1_sum_bgsub_array', ...
    'c1_ints_bg_sub', ...
    'c1_int_vol_array', ...
    'c1_vol_array', ...
    'c1_std_bgsub_array' ...
    };
for m = 1:numel(metrics_cell)
    data_cell = {};
    for c = 1:numel(conditions_cell)
        data_cell{c} = S.(conditions_cell{c}).(metrics_cell{m})(:);
    end
    [KW.(metrics_cell{m}).kw_c, KW.(metrics_cell{m}).anova1_m] = ...
        jgl_kw_mult_comp(data_cell, label_cell);
    figure;
    KW.(metrics_cell{m}).sym_p = symmetric_probs(KW.(metrics_cell{m}).kw_c);
    superbar( ...
        KW.(metrics_cell{m}).anova1_m(:,1), ...
        'E', ...
        KW.(metrics_cell{m}).anova1_m(:,2), ...
        'P', ...
        KW.(metrics_cell{m}).sym_p, ...
        'PStarBackgroundColor', ...
        'none', ...
        'PStarFontSize', ...
        12, ...
        'BarFaceColor', ...
        repmat([.4, .8, .4], [3,1]) ...
        );
    xlim([0.5, (size(KW.(metrics_cell{m}).kw_c,1) + 0.5)]);
    xticks(1:size(KW.(metrics_cell{m}).kw_c,1));
    xticklabels(label_cell);
    switch m
        case 1
            y_charray = {'Total Signal' ,'Mean Intensity (AU)'};
        case 2
            y_charray = {'Total Signal', 'Integrated Intensity(AU)'};
        case 3
            y_charray = {'Kinetochore Spot', 'Maximum Intensity(AU)'};
        case 4
            y_charray = {'Total Signal', 'Mean Intensity/\mum^3'};
        case 5
            y_charray = {'Total Signal', 'Volume (\mum^3)'};
        case 6
            y_charray = {'Total Signal', 'STD Rescaled Intensity (AU)'};
    end
    ylabel(y_charray);
    set(gcf, 'Units', 'inches');
    set(gcf, 'Position', [5,5,3.25, 2.5]);
    set(gca, 'LineWidth', 1);
    set(gca, 'FontSize', 12);
    InSet = get(gca, 'TightInset');
    set(gca, 'Position', [InSet(1:2), 1-InSet(1)-InSet(3), 1-InSet(2)-InSet(4)])
end

