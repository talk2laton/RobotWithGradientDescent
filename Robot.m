classdef Robot < handle
    properties(Access = private)
        Lengths, Points, Members, Joints, Pins
    end
    properties
        Update, Compute
    end

    methods (Access = private)
        function pt = compute(R, theta)
            t = cumsum(theta) - 180*(0:3);
            R.Points = [[0;0], cumsum([cosd(t);sind(t)].*R.Lengths,2)];
            pt = R.Points(:,end);
        end
        
        function update(R)
            R.Members.XData = R.Points(1,:);
            R.Members.YData = R.Points(2,:);
            R.Joints.XData = R.Points(1,:);
            R.Joints.YData = R.Points(2,:);
            R.Pins.XData = R.Points(1,1:end-1);
            R.Pins.YData = R.Points(2,1:end-1);
        end
    end

    methods
        function R = Robot(theta)
            plot([-1,1],[0,0], Color=0.6*[1,1,1], LineWidth=15);
            R.Lengths = 4:-1:1; compute(R,theta);
            R.Members = plot(R.Points(1,:), R.Points(2,:), '-k', ...
                        LineWidth=5);
            R.Joints = plot(R.Points(1,:), R.Points(2,:), 'ok', ...
                      LineWidth=2, MarkerFaceColor='w', MarkerSize=15);
            R.Pins = plot(R.Points(1,1:end-1), R.Points(2,1:end-1), ...
                     'ok', LineWidth=5, MarkerFaceColor='k', MarkerSize=4);
            R.Update = @()update(R);
            R.Compute = @(theta)compute(R, theta);
        end
    end
end