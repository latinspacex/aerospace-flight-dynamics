function status = odeProgressPlotter(t, ~, flag)
% ODEPROGRESSPLOTTER plots the ODE solver's step size in real-time.
%
%   Inputs:
%       t       - Time points for the current step
%       ~       - State vector y (unused)
%       flag    - A string indicating the solver's state ('init', '', or 'done')

    persistent hLine last_t; % Use fewer persistent variables
    status = 0; % A status of 0 tells the solver to continue

    switch flag
        case 'init'
            % This block runs once at the beginning of the simulation
            figure('Name', 'ODE Solver Progress', 'NumberTitle', 'off');
            hLine = plot(NaN, NaN, '-r.'); % Create an empty line object
            
            title('Solver Step Size vs. Time');
            xlabel('Simulation Time (s)');
            ylabel('Log_{10} of Step Size (s)');
            grid on;
            
            last_t = t(1); % Store the initial time

        case ''
            % This block runs after each successful integration step
            current_t = t(end);
            step_size = current_t - last_t;
            
            if step_size > 0
                % Get the existing data from the line handle
                x_data = get(hLine, 'XData');
                y_data = get(hLine, 'YData');
                
                % Append the new data point
                new_x = [x_data, current_t];
                new_y = [y_data, log10(step_size)];
                
                % Update the plot with the new data
                set(hLine, 'XData', new_x, 'YData', new_y);
                
                % Force MATLAB to process the graphics queue and update the figure
                drawnow;
            end
            
            last_t = current_t; % Update the time for the next step calculation

        case 'done'
            % This block runs once the integration is complete
            disp('Solver progress plotting complete.');
    end
end