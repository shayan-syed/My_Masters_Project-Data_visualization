filename = 'filename';  % Update with your actual file name
data = readtable(filename);


GeneID = data.GeneID;
Mutated_miRNA = data.Mutated_miRNA;
Mutated_Binding_Energy = data.Mutated_Binding_Energy;


unique_GeneID = unique(GeneID);
unique_Mutated_miRNA = unique(Mutated_miRNA);


mutated_binding_energy_matrix = nan(length(unique_GeneID), length(unique_Mutated_miRNA));


for i = 1:length(GeneID)
    gene_idx = find(strcmp(unique_GeneID, GeneID{i}));
    mirna_idx = find(strcmp(unique_Mutated_miRNA, Mutated_miRNA{i}));
    mutated_binding_energy_matrix(gene_idx, mirna_idx) = Mutated_Binding_Energy(i);
end


figure;
h = heatmap(unique_Mutated_miRNA, unique_GeneID, mutated_binding_energy_matrix);


title(h, 'Heat Map of Pathway R-HSA-114294 for hsa-miR-146a-5p');
xlabel(h, 'Mutated miRNA');
ylabel(h, 'GeneID');


h.CellLabelColor = 'none';


ax = gca;
xlabels = string(ax.XDisplayLabels);


miRNA_to_highlight = 'miRNA_of_interest';  


for i = 1:length(xlabels)
    text(i, ax.YLim(1) - 0.5, xlabels{i}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'k', 'FontSize', 10);
end


highlight_idx = find(xlabels == miRNA_to_highlight);
if ~isempty(highlight_idx)
    text(highlight_idx, ax.YLim(1) - 0.5, miRNA_to_highlight, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Color', 'r', 'FontSize', 10, 'FontWeight', 'bold');
end


set(gcf, 'Position', [100, 100, 800, 600]);
