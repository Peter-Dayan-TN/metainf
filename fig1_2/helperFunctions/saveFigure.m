function [  ] = saveFigure(FigureName)

set(gcf,'PaperUnits','inches','PaperSize',[12 12],'PaperPosition',[1 1 6.65 5])
print(gcf,FigureName,'-dpng')
delete(gcf)
end

