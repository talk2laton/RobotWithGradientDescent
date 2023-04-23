fig = figure(Color='w',Position=[2000,329,560,550]);
axis equal off; axis([-3,7,-0.5,9.5]); hold on;
lrtxt = text(-2,9,"LearningRate = "+0.5,FontSize=15,Interpreter="latex");
LearningRate = uicontrol(fig,Style="slider",Units="normalized",Value=0.5,...
      Position=[0.1,0.02,0.8,0.04],SliderStep=[0.02,0.04],Min=0,Max=10,...
      Callback=@(v,e) slider_callback(v,e,lrtxt));
theta = [110,120,120,90]; R = Robot(theta);
tplt = plot(5,5,'or',MarkerFaceColor='r');
for n = 1:25
    target = ginput(1)';
    tplt.XData = target(1); tplt.YData = target(2); 
    fun = @(t) norm(R.Compute(t) - target);
    loss = fun(theta); 
    while(loss > 0.01)
        g = grad(fun,theta);
        theta = theta - LearningRate.Value*g;
        loss = fun(theta);
        R.Update();
        drawnow;
    end
end

function slider_callback(v,~,txt)
    txt.String = "LearningRate = " + v.Value;
end
