%% plot spikes
function plot_spikes(F_osc,t,position)

width = position(3);
height = position(4)/9;

cyan = [102,204,238]/255;
color1 = cyan;
color2 = [0.95,0.85,0.2];

nframes = size(F_osc,2);

n = 1;
y_position = position(2) + (n-1) * height;
subplot('position',[position(1) y_position width height])
subplot_spikes(F_osc,n,color1,color2,t);
ax = gca;
maxXTick = floor(nframes/50);
ax.XTick = 50*(0:1:maxXTick);
% ax.XTickLabel = {'0','50','100','150'};
ax.TickLength = [0 0];
xlabel('Time (ms)','FontSize',20);


for n = 2:8
    y_position = position(2) + (n-1) * height;
    subplot('position',[position(1) y_position width height])
    subplot_spikes(F_osc,n,color1,color2,t);
%     if n == 5
%     ylabel('Neural Spikes','rotation',90,'FontSize',20)  
%     end
end


% Axes handle 2 (unvisible, only for place the second legend)
n = 9;
y_position = position(2) + (n-1) * height;
subplot('position',[position(1) y_position width height])
hold on
h = zeros(2,1);
% h(1) = bar(0,1,'FaceColor',color1,'EdgeColor',color1);
% h(2) = bar(0,1,'FaceColor',color2,'EdgeColor',color2);
h(1) = plot(0,0,'color',color2,'LineWidth',5);
h(2) = plot(0,0,'color',color1,'LineWidth',5);
subplot_spikes(F_osc,n,color1,color2,t);
title('spike train','FontSize',24)
ah = axes('position',get(gca,'position'),'FontSize',20,'Linewidth',2,'visible','off');
legend(ah,h(1:2),'left','right','Location','east')
% legend('boxoff')


end

function subplot_spikes(F_osc,n,color1,color2,t)

spikes = F_osc(10-n,:);
nframes = size(F_osc,2);
spikes_left = -spikes;
spikes_left(spikes_left<0) = 0;
spikes_left(spikes_left==0) = nan;
spikes_right = spikes;
spikes_right(spikes_right<0) = 0;
spikes_right(spikes_right==0) = nan;
time_vline = zeros(size(spikes));
time_vline(t) = 200;
time_vline(time_vline==0) = nan;
vlinecolor = [0.9,0.1,0.1];

hold on
spikeplot_left = bar(spikes_left,2,'FaceColor',color1,'EdgeColor',color1);
spikeplot_right = bar(spikes_right,2,'FaceColor',color2,'EdgeColor',color2);
timeline = bar(time_vline,0.5,'FaceColor',vlinecolor,'EdgeColor',vlinecolor);
hold off
box on
ax = gca;
ax.LineWidth = 3;
xlim([0 nframes]);
ax.XTick = [];
ylim([0 200]);
ylabel(sprintf('%d',10-n),'rotation',0)  
ylabh = get(gca,'ylabel');
set(ylabh,'Position',get(ylabh,'Position') -[-2 40 0.5])
ax.YTick = [];
ax.FontSize = 20;
end

