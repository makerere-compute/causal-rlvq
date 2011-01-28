out_dir = '~/reports/thesis/figs/parameter_estimation';
width = 8.55;
height = 6.5;
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperSize',[width height]);
set(gcf,'PaperPosition',[0 0 width height]);

saveas(gcf,[out_dir '/bloodsample_train2.pdf']);
