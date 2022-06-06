function [kw_c, anova1_m, kw_p] = jgl_kw_mult_comp(data_cell, label_cell)

data = [];
group = {};
for n = 1:numel(data_cell)
    data = [data; data_cell{n}];
    labels = repmat(label_cell(n), size(data_cell{n}));
    group = [group; labels];
end
[kw_p,~,kw_stats] = kruskalwallis(data, group, 'off');
[~,~,anova1_stats] = anova1(data, group, 'off');
kw_c = multcompare(kw_stats, 'Display', 'off');
[~, anova1_m] = multcompare(anova1_stats, 'Display', 'off');