%% Create final look-up tables that can switch between the 21 contact combinations
% Tanya Tebcherani

clear all

% Run through TouchSim reachable sets (1 = depths, 2 = ramps)
for reachable_set = 1:2
    clearvars -except reachable_set
    
    % Load Izad data
    c = [1 2 3 4 13 14 15];
    % Loop through the 7 contacts for contact 1
    for c1_index = 1:7
        % Loop through the 7 contacts for contact 2
        for c2_index = 1:7
            % Save c1 and c2 with the current contacts
            c1 = c(c1_index);
            c2 = c(c2_index);
            
            % Omit repeats (ex. contacts 1 and 2, and contacts 2 and 1)
            if c2 > c1
                % Load data based on reachable set
                switch reachable_set
                    case 1
                        load(['C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Depths\lookup_table_c' int2str(c1) 'c' int2str(c2) '_id.mat']);
                    case 2
                        load(['C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Ramps\lookup_table_c' int2str(c1) 'c' int2str(c2) '_ir.mat']);
                end
            end
        end
    end
    
    % Save error of each individual look-up table into one error matrix
    error(1,:) = lookup_table_c1c2(1,:);
    error(2,:) = lookup_table_c1c3(1,:);
    error(3,:) = lookup_table_c1c4(1,:);
    error(4,:) = lookup_table_c1c13(1,:);
    error(5,:) = lookup_table_c1c14(1,:);
    error(6,:) = lookup_table_c1c15(1,:);
    error(7,:) = lookup_table_c2c3(1,:);
    error(8,:) = lookup_table_c2c4(1,:);
    error(9,:) = lookup_table_c2c13(1,:);
    error(10,:) = lookup_table_c2c14(1,:);
    error(11,:) = lookup_table_c2c15(1,:);
    error(12,:) = lookup_table_c3c4(1,:);
    error(13,:) = lookup_table_c3c13(1,:);
    error(14,:) = lookup_table_c3c14(1,:);
    error(15,:) = lookup_table_c3c15(1,:);
    error(16,:) = lookup_table_c4c13(1,:);
    error(17,:) = lookup_table_c4c14(1,:);
    error(18,:) = lookup_table_c4c15(1,:);
    error(19,:) = lookup_table_c13c14(1,:);
    error(20,:) = lookup_table_c13c15(1,:);
    error(21,:) = lookup_table_c14c15(1,:);
    
    % Find size of the error matrix
    size_error = size(error);
    
    % Loop through all NAPs in the look-up tables
    for nap_index = 1:size_error(2)
        % Display NAP index
        nap_index
        
        % If we are not on the first NAP (first NAP  has no activation)
        if nap_index ~= 1
            % Loop through all 21 contact combinations
            for c_index = 1:21
                % If we are on the first contact combination, or if the
                % error of the current combination is less than the minimum
                % error that has been saved, update the error and contact
                % to the current values
                if (c_index == 1) || (error(c_index,nap_index) < min_error)
                    min_error = error(c_index,nap_index);
                    min_contact = c_index;
                end
            end
        
            % Create look-up table entry for the current NAP

            % One column per TouchSim NAP, with rows as follows:
            % Row 1: error
            % Row 2: Izad NAP PA C1
            % Row 3: Izad NAP PA C2
            % Row 4: Izad NAP PW
            % Row 5: Izad NAP index
            % Row 6-1709: TouchSim NAP (re-ordered)
            % Row 1710-3413: Izad NAP
            % Row 3414: contact 1
            % Row 3415: contact 2

            switch min_contact
                case 1
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c2(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 2;
                case 2
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c3(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 3;
                case 3
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c4(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 4;
                case 4
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c13(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 13;
                case 5
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c14(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 14;
                case 6
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 1;
                    lookup_table_alltc(3415,nap_index) = 15;
                case 7
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c2c3(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 2;
                    lookup_table_alltc(3415,nap_index) = 3;
                case 8
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c2c4(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 2;
                    lookup_table_alltc(3415,nap_index) = 4;
                case 9
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c2c13(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 2;
                    lookup_table_alltc(3415,nap_index) = 13;
                case 10
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c2c14(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 2;
                    lookup_table_alltc(3415,nap_index) = 14;
                case 11
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c2c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 2;
                    lookup_table_alltc(3415,nap_index) = 15;
                case 12
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c3c4(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 3;
                    lookup_table_alltc(3415,nap_index) = 4;
                case 13
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c3c13(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 3;
                    lookup_table_alltc(3415,nap_index) = 13;
                case 14
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c3c14(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 3;
                    lookup_table_alltc(3415,nap_index) = 14;
                case 15
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c3c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 3;
                    lookup_table_alltc(3415,nap_index) = 15;
                case 16
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c4c13(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 4;
                    lookup_table_alltc(3415,nap_index) = 13;
                case 17
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c4c14(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 4;
                    lookup_table_alltc(3415,nap_index) = 14;
                case 18
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c4c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 4;
                    lookup_table_alltc(3415,nap_index) = 15;
                case 19
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c13c14(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 13;
                    lookup_table_alltc(3415,nap_index) = 14;
                case 20
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c13c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 13;
                    lookup_table_alltc(3415,nap_index) = 15;
                case 21
                    lookup_table_alltc(1:3413,nap_index) = lookup_table_c14c15(:,nap_index);
                    lookup_table_alltc(3414,nap_index) = 14;
                    lookup_table_alltc(3415,nap_index) = 15;
            end

            % Clear unnecessary variables
            clear min_error
            clear min_contact
        % If we are on the first NAP, use contact 1 and 2 data but set the
        % contact numbers to 0 since we don't need any contacts to
        % stimulate no activation
        elseif nap_index == 1
            lookup_table_alltc(1:3413,nap_index) = lookup_table_c1c2(:,nap_index);
            lookup_table_alltc(3414,nap_index) = 0;
            lookup_table_alltc(3415,nap_index) = 0;
        end
    end
    
    % Plot results
    fig = figure;
        
    subplot(2,3,1)
    hold on
    scatter(1:size_error(2),lookup_table_alltc(1,:),3,'filled')
    title('Error')
    xlabel('TouchSim NAP Index')
    ylabel('Error')
    xlim([1 size_error(2)])
    hold off
        
    subplot(2,3,4)
    hold on
    histogram(categorical(lookup_table_alltc(1,:)))
    title('Error Histogram')
    xlabel('Error')
    ylabel('# of Occurances')
    hold off
        
    subplot(2,3,2)
    hold on
    scatter(1:size_error(2),sum(lookup_table_alltc(6:1709,:)),3,'filled')
    title('# of TouchSim Neurons On')
    xlabel('TouchSim NAP Index')
    ylabel('# of Neurons')
    xlim([1 size_error(2)])
    hold off
        
    subplot(2,3,5)
    hold on
    scatter(1:size_error(2),sum(lookup_table_alltc(1710:3413,:)),3,'filled')
    title('# of Izad Neurons On')
    xlabel('TouchSim NAP Index')
    ylabel('# of Neurons')
    xlim([1 size_error(2)])
    hold off
        
    subplot(2,3,3)
    hold on
    scatter(1:size_error(2),lookup_table_alltc(3414,:),3,'filled')
    scatter(1:size_error(2),lookup_table_alltc(3415,:),3,'filled')
    legend('C1','C2')
    title('Contact')
    xlabel('TouchSim NAP Index')
    ylabel('Contact')
    xlim([1 size_error(2)])
    hold off
        
    subplot(2,3,6)
    hold on
    histogram(categorical([lookup_table_alltc(3414,:) lookup_table_alltc(3415,:)]))
    title('Contact Histogram')
    xlabel('Contact')
    ylabel('# of Occurances')
    hold off
    
    % Save results and figure based on reachable set
    if reachable_set == 1
        save('C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Depths\lookup_table_alltc_id.mat','lookup_table_alltc')
        
        sgtitle('All Two Contacts Look-Up Table Results (IF Depth)')
        saveas(fig,'C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Depths\All Two Contacts Look-Up Table Results (IF Depths).jpg')
    elseif reachable_set == 2
        save('C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Ramps\lookup_table_alltc_ir.mat','lookup_table_alltc')

        sgtitle('All Two Contacts Look-Up Table Results (IF Ramp)')
        saveas(fig,'C:\Users\tt623\Box Sync\INI - Personal Files\3 Two-Contact Brute Force Method\3 Look-Up Table\Index Finger\Generated Data\Ramps\All Two Contacts Look-Up Table Results (IF Ramps).jpg')
    end
end