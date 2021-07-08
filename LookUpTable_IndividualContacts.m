%% Create look-up tables for 21 contact combinations (index error case)
% Tanya Tebcherani

clear all

% Capture current clock value so we can find total elapsed time of code
% later.
tic

% Run through TouchSim reachable sets (1 = depths, 2 = ramps)
for reachable_set = 1:2
    % Clear all variables except for reachable set
    clearvars -except reachable_set

    % Load mappings
    load('mapped_index_touchsim_index') % TS <-> Izad neuron  mapping
    load('mapped_index_type_index')     % Neuron type (SA, RA, PC)
    load('mapped_index_placement_index')% Neuron index finger placement (distal, middle, proximal)
    
    % Load reachable set
    if reachable_set == 1
        load('TouchSimReachableSet_Depths')
    elseif reachable_set == 2
        load('TouchSimReachableSet_Ramps')
    end

    touchsim_naps = nap_all(mapped_index_touchsim,:);
    size_touchsim_naps = size(touchsim_naps);
    clear nap_all
    clear mapped_index_touchsim

    % Create mapped_placement_type as we did in the single-contact case

    % 1 = SA distal
    % 2 = RA distal
    % 3 = PC distal

    % 4 = SA middle
    % 5 = RA middle
    % 6 = PC middle

    % 7 = SA proximal
    % 8 = RA proximal
    % 9 = PC proximal

    for i = 1:1704
        if (mapped_placement(i) == 1) && (mapped_type(i) == 1)
            mapped_placement_type(i) = 1;
        elseif (mapped_placement(i) == 1) && (mapped_type(i) == 2)
            mapped_placement_type(i) = 2;
        elseif (mapped_placement(i) == 1) && (mapped_type(i) == 3)
            mapped_placement_type(i) = 3;
        elseif (mapped_placement(i) == 2) && (mapped_type(i) == 1)
            mapped_placement_type(i) = 4;
        elseif (mapped_placement(i) == 2) && (mapped_type(i) == 2)
            mapped_placement_type(i) = 5;
        elseif (mapped_placement(i) == 2) && (mapped_type(i) == 3)
            mapped_placement_type(i) = 6;
        elseif (mapped_placement(i) == 3) && (mapped_type(i) == 1)
            mapped_placement_type(i) = 7;
        elseif (mapped_placement(i) == 3) && (mapped_type(i) == 2)
            mapped_placement_type(i) = 8;
        elseif (mapped_placement(i) == 3) && (mapped_type(i) == 3)
            mapped_placement_type(i) = 9;
        end
    end

    clear i
    clear mapped_placement mapped_type

    % Create placement and type matrix for TouchSim NAPs as we did in the
    % single-contact case

    % Each NAP has 1 column with 9 rows:

    % (1) Number of SA distal neurons
    % (2) Number of RA distal neurons
    % (3) Number of PC distal neurons

    % (4) Number of SA middle neurons
    % (5) Number of RA middle neurons
    % (6) Number of PC middle neurons

    % (7) Number of SA proximal neurons
    % (8) Number of RA proximal neurons
    % (9) Number of PC proximal neurons

    for i = 1:size_touchsim_naps(2)
        test_nap = touchsim_naps(:,i);
        index = find(test_nap);
        index_placement_types = mapped_placement_type(index);

        touchsim_placement_types(1,i) = sum(index_placement_types(:) == 1);
        touchsim_placement_types(2,i) = sum(index_placement_types(:) == 2);
        touchsim_placement_types(3,i) = sum(index_placement_types(:) == 3);
        touchsim_placement_types(4,i) = sum(index_placement_types(:) == 4);
        touchsim_placement_types(5,i) = sum(index_placement_types(:) == 5);
        touchsim_placement_types(6,i) = sum(index_placement_types(:) == 6);
        touchsim_placement_types(7,i) = sum(index_placement_types(:) == 7);
        touchsim_placement_types(8,i) = sum(index_placement_types(:) == 8);
        touchsim_placement_types(9,i) = sum(index_placement_types(:) == 9);
    end

    clear i
    clear test_nap index
    clear index_placement_types

    % Sweep through 21 combinations of contacts
    c = [1 2 3 4 13 14 15];
    for c_index1 = 1:7
        for c_index2 = 1:7
            % Make sure we don't repeat contacts (ex. contacts 1 and 2, and
            % contacts 2 and 1)
            if c_index2 > c_index1
                % Clear all variables except necessary variables
                clearvars -except c c_index1 c_index2 lookup_table_allsc mapped_placement_type reachable_set size_touchsim_naps touchsim_naps touchsim_placement_types

                % Set c1 and c2 to the current contacts we're on, and
                % display them
                c1 = c(c_index1)
                c2 = c(c_index2)
                
                % Load Izad data
                load(['/home/tanya/2CUniqueNaps/outputs_contact_c' int2str(c1) 'c' int2str(c2) '_unique_if.mat'])
                load(['/home/tanya/2CUniqueNaps/inputs_contact_c' int2str(c1) 'c' int2str(c2) '_unique_if.mat'])
        
                if (c1 == 1) && (c2 == 2)
                    izad_naps = outputs_contact_c1c2;
                    clear outputs_contact_c1c2

                    izad_pw = inputs_contact_c1c2(1,:);
                    izad_pa1 = inputs_contact_c1c2(16,:);
                    izad_pa2 = inputs_contact_c1c2(17,:);
                    clear inputs_contact_c1c2
                elseif (c1 == 1) && (c2 == 3)
                    izad_naps = outputs_contact_c1c3;
                    clear outputs_contact_c1c3

                    izad_pw = inputs_contact_c1c3(1,:);
                    izad_pa1 = inputs_contact_c1c3(16,:);
                    izad_pa2 = inputs_contact_c1c3(18,:);
                    clear inputs_contact_c1c3
                elseif (c1 == 1) && (c2 == 4)
                    izad_naps = outputs_contact_c1c4;
                    clear outputs_contact_c1c4

                    izad_pw = inputs_contact_c1c4(1,:);
                    izad_pa1 = inputs_contact_c1c4(16,:);
                    izad_pa2 = inputs_contact_c1c4(19,:);
                    clear inputs_contact_c1c4
                elseif (c1 == 1) && (c2 == 13)
                    izad_naps = outputs_contact_c1c13;
                    clear outputs_contact_c1c13

                    izad_pw = inputs_contact_c1c13(1,:);
                    izad_pa1 = inputs_contact_c1c13(16,:);
                    izad_pa2 = inputs_contact_c1c13(28,:);
                    clear inputs_contact_c1c13
                elseif (c1 == 1) && (c2 == 14)
                    izad_naps = outputs_contact_c1c14;
                    clear outputs_contact_c1c14

                    izad_pw = inputs_contact_c1c14(1,:);
                    izad_pa1 = inputs_contact_c1c14(16,:);
                    izad_pa2 = inputs_contact_c1c14(29,:);
                    clear inputs_contact_c1c14
                elseif (c1 == 1) && (c2 == 15)
                    izad_naps = outputs_contact_c1c15;
                    clear outputs_contact_c1c15

                    izad_pw = inputs_contact_c1c15(1,:);
                    izad_pa1 = inputs_contact_c1c15(16,:);
                    izad_pa2 = inputs_contact_c1c15(30,:);
                    clear inputs_contact_c1c15
                elseif (c1 == 2) && (c2 == 3)
                    izad_naps = outputs_contact_c2c3;
                    clear outputs_contact_c2c3

                    izad_pw = inputs_contact_c2c3(2,:);
                    izad_pa1 = inputs_contact_c2c3(17,:);
                    izad_pa2 = inputs_contact_c2c3(18,:);
                    clear inputs_contact_c2c3
                elseif (c1 == 2) && (c2 == 4)
                    izad_naps = outputs_contact_c2c4;
                    clear outputs_contact_c2c4

                    izad_pw = inputs_contact_c2c4(2,:);
                    izad_pa1 = inputs_contact_c2c4(17,:);
                    izad_pa2 = inputs_contact_c2c4(19,:);
                    clear inputs_contact_c2c4
                elseif (c1 == 2) && (c2 == 13)
                    izad_naps = outputs_contact_c2c13;
                    clear outputs_contact_c2c13

                    izad_pw = inputs_contact_c2c13(2,:);
                    izad_pa1 = inputs_contact_c2c13(17,:);
                    izad_pa2 = inputs_contact_c2c13(28,:);
                    clear inputs_contact_c2c13
                elseif (c1 == 2) && (c2 == 14)
                    izad_naps = outputs_contact_c2c14;
                    clear outputs_contact_c2c14

                    izad_pw = inputs_contact_c2c14(2,:);
                    izad_pa1 = inputs_contact_c2c14(17,:);
                    izad_pa2 = inputs_contact_c2c14(29,:);
                    clear inputs_contact_c2c14
                elseif (c1 == 2) && (c2 == 15)
                    izad_naps = outputs_contact_c2c15;
                    clear outputs_contact_c2c15

                    izad_pw = inputs_contact_c2c15(2,:);
                    izad_pa1 = inputs_contact_c2c15(17,:);
                    izad_pa2 = inputs_contact_c2c15(30,:);
                    clear inputs_contact_c2c15
                elseif (c1 == 3) && (c2 == 4)
                    izad_naps = outputs_contact_c3c4;
                    clear outputs_contact_c3c4

                    izad_pw = inputs_contact_c3c4(3,:);
                    izad_pa1 = inputs_contact_c3c4(18,:);
                    izad_pa2 = inputs_contact_c3c4(19,:);
                    clear inputs_contact_c3c4
                elseif (c1 == 3) && (c2 == 13)
                    izad_naps = outputs_contact_c3c13;
                    clear outputs_contact_c3c13

                    izad_pw = inputs_contact_c3c13(3,:);
                    izad_pa1 = inputs_contact_c3c13(18,:);
                    izad_pa2 = inputs_contact_c3c13(28,:);
                    clear inputs_contact_c3c13
                elseif (c1 == 3) && (c2 == 14)
                    izad_naps = outputs_contact_c3c14;
                    clear outputs_contact_c3c14

                    izad_pw = inputs_contact_c3c14(3,:);
                    izad_pa1 = inputs_contact_c3c14(18,:);
                    izad_pa2 = inputs_contact_c3c14(29,:);
                    clear inputs_contact_c3c14
                elseif (c1 == 3) && (c2 == 15)
                    izad_naps = outputs_contact_c3c15;
                    clear outputs_contact_c3c15

                    izad_pw = inputs_contact_c3c15(3,:);
                    izad_pa1 = inputs_contact_c3c15(18,:);
                    izad_pa2 = inputs_contact_c3c15(30,:);
                    clear inputs_contact_c3c15
                elseif (c1 == 4) && (c2 == 13)
                    izad_naps = outputs_contact_c4c13;
                    clear outputs_contact_c4c13

                    izad_pw = inputs_contact_c4c13(4,:);
                    izad_pa1 = inputs_contact_c4c13(19,:);
                    izad_pa2 = inputs_contact_c4c13(28,:);
                    clear inputs_contact_c4c13
                elseif (c1 == 4) && (c2 == 14)
                    izad_naps = outputs_contact_c4c14;
                    clear outputs_contact_c4c14

                    izad_pw = inputs_contact_c4c14(4,:);
                    izad_pa1 = inputs_contact_c4c14(19,:);
                    izad_pa2 = inputs_contact_c4c14(29,:);
                    clear inputs_contact_c4c14
                elseif (c1 == 4) && (c2 == 15)
                    izad_naps = outputs_contact_c4c15;
                    clear outputs_contact_c4c15

                    izad_pw = inputs_contact_c4c15(4,:);
                    izad_pa1 = inputs_contact_c4c15(19,:);
                    izad_pa2 = inputs_contact_c4c15(30,:);
                    clear inputs_contact_c4c15
                elseif (c1 == 13) && (c2 == 14)
                    izad_naps = outputs_contact_c13c14;
                    clear outputs_contact_c13c14

                    izad_pw = inputs_contact_c13c14(13,:);
                    izad_pa1 = inputs_contact_c13c14(28,:);
                    izad_pa2 = inputs_contact_c13c14(29,:);
                    clear inputs_contact_c13c14
                elseif (c1 == 13) && (c2 == 15)
                    izad_naps = outputs_contact_c13c15;
                    clear outputs_contact_c13c15

                    izad_pw = inputs_contact_c13c15(13,:);
                    izad_pa1 = inputs_contact_c13c15(28,:);
                    izad_pa2 = inputs_contact_c13c15(30,:);
                    clear inputs_contact_c13c15
                elseif (c1 == 14) && (c2 == 15)
                    izad_naps = outputs_contact_c14c15;
                    clear outputs_contact_c14c15

                    izad_pw = inputs_contact_c14c15(14,:);
                    izad_pa1 = inputs_contact_c14c15(29,:);
                    izad_pa2 = inputs_contact_c14c15(30,:);
                    clear inputs_contact_c14c15
                end
        
                % Find the number of Izad NAPs we generated
                size_izad_naps = size(izad_naps);

                % Create placement and type matrix for Izad NAPs as in the
                % single-contact case

                % Each NAP has 1 column with 9 rows:

                % (1) Number of SA distal neurons
                % (2) Number of RA distal neurons
                % (3) Number of PC distal neurons

                % (4) Number of SA middle neurons
                % (5) Number of RA middle neurons
                % (6) Number of PC middle neurons

                % (7) Number of SA proximal neurons
                % (8) Number of RA proximal neurons
                % (9) Number of PC proximal neurons

                for i = 1:size_izad_naps(2)
                    test_nap = izad_naps(:,i);
                    index = find(test_nap);
                    index_placement_types = mapped_placement_type(index);

                    izad_placement_types(1,i) = sum(index_placement_types(:) == 1);
                    izad_placement_types(2,i) = sum(index_placement_types(:) == 2);
                    izad_placement_types(3,i) = sum(index_placement_types(:) == 3);
                    izad_placement_types(4,i) = sum(index_placement_types(:) == 4);
                    izad_placement_types(5,i) = sum(index_placement_types(:) == 5);
                    izad_placement_types(6,i) = sum(index_placement_types(:) == 6);
                    izad_placement_types(7,i) = sum(index_placement_types(:) == 7);
                    izad_placement_types(8,i) = sum(index_placement_types(:) == 8);
                    izad_placement_types(9,i) = sum(index_placement_types(:) == 9);
                end

                clear i
                clear test_nap clear index
                clear index_placement_types

                % Create look-up table

                % One column per TouchSim NAP, with rows as follows:
                % Row 1: error
                % Row 2: Izad NAP PA C1
                % Row 3: Izad NAP PA C2
                % Row 4: Izad NAP PW
                % Row 5: Izad NAP index
                % Row 6-1709: TouchSim NAP(re-ordered)
                % Row 1710-3413: Izad NAP

                % Loop through each NAP in the TS reachable set. Note that
                % parfor means parallel processing and as such this code
                % must be run on Perseus.
                parfor touchsim_nap_index = 1:size_touchsim_naps(2)
                    % Save first profile as all 0's
                    if touchsim_nap_index == 1
                        error = 0;

                        % It seems redundant to save lt_temp and then put
                        % that into the look-up table rather than doing it
                        % all in one step, but this has to do with parallel
                        % processing requirements. lt_temp holds the
                        % look_up table values for the current NAP.
                        lt_temp = [error; 0; 0; 0; 1; touchsim_naps(:,touchsim_nap_index); izad_naps(:,1)];
                        lookup_table(:,touchsim_nap_index) = lt_temp;
                    % For all other profiles
                    else
                        % Loop through all Izad NAPs except the first one
                        for izad_nap_index = 2:size_izad_naps(2)
                            % Calculate error
                            new_error = sum(abs(touchsim_placement_types(:,touchsim_nap_index) - izad_placement_types(:,izad_nap_index)));

                            % Save first profile after all 0's or if error < prev. error
                            if (izad_nap_index == 2) || (new_error < error)
                                error = new_error;

                                lt_temp = [error; izad_pa1(izad_nap_index); izad_pa2(izad_nap_index); izad_pw(izad_nap_index);... 
                                    izad_nap_index; touchsim_naps(:,touchsim_nap_index); izad_naps(:,izad_nap_index)];
                                
                                lookup_table(:,touchsim_nap_index) = lt_temp;
                            end
                        end
                    end
                end
      
                % Plot results
                set(0,'DefaultFigureVisible','off');
                
                fig = figure;

                subplot(2,3,1)
                hold on
                scatter(1:size_touchsim_naps(2),lookup_table(1,:),3,'filled')
                title('Error')
                xlabel('TouchSim NAP Index')
                ylabel('Error')
                xlim([1 size_touchsim_naps(2)])
                hold off

                subplot(2,3,4)
                hold on
                histogram(categorical(lookup_table(1,:)))
                title('Error Histogram')
                xlabel('Error')
                ylabel('# of Occurances')
                hold off

                subplot(2,3,2)
                hold on
                scatter(1:size_touchsim_naps(2),sum(lookup_table(6:1709,:)),3,'filled')
                title('# of TouchSim Neurons On')
                xlabel('TouchSim NAP Index')
                ylabel('# of Neurons')
                xlim([1 size_touchsim_naps(2)])
                hold off

                subplot(2,3,5)
                hold on
                scatter(1:size_touchsim_naps(2),sum(lookup_table(1710:3413,:)),3,'filled')
                title('# of Izad Neurons On')
                xlabel('TouchSim NAP Index')
                ylabel('# of Neurons')
                xlim([1 size_touchsim_naps(2)])
                hold off

                subplot(2,3,3)
                hold on
                scatter(1:size_touchsim_naps(2),lookup_table(5,:),3,'filled')
                title('Izad NAP Index')
                xlabel('TouchSim NAP Index')
                ylabel('Izad NAP Index')
                xlim([1 size_touchsim_naps(2)])
                hold off

                subplot(2,3,6)
                hold on
                histogram(categorical(lookup_table(5,:)))
                title('Izad NAP Index Histogram')
                xlabel('Izad NAP Index')
                ylabel('# of Occurances')
                hold off
        
                % Rename and save look-up table
                if (c1 == 1) && (c2 == 2)
                    lookup_table_c1c2 = lookup_table;
                elseif (c1 == 1) && (c2 == 3)
                    lookup_table_c1c3 = lookup_table;
                elseif (c1 == 1) && (c2 == 4)
                    lookup_table_c1c4 = lookup_table;
                elseif (c1 == 1) && (c2 == 13)
                    lookup_table_c1c13 = lookup_table;
                elseif (c1 == 1) && (c2 == 14)
                    lookup_table_c1c14 = lookup_table;
                elseif (c1 == 1) && (c2 == 15)
                    lookup_table_c1c15 = lookup_table;
                elseif (c1 == 2) && (c2 == 3)
                    lookup_table_c2c3 = lookup_table;
                elseif (c1 == 2) && (c2 == 4)
                    lookup_table_c2c4 = lookup_table;
                elseif (c1 == 2) && (c2 == 13)
                    lookup_table_c2c13 = lookup_table;
                elseif (c1 == 2) && (c2 == 14)
                    lookup_table_c2c14 = lookup_table;
                elseif (c1 == 2) && (c2 == 15)
                    lookup_table_c2c15 = lookup_table;
                elseif (c1 == 3) && (c2 == 4)
                    lookup_table_c3c4 = lookup_table;
                elseif (c1 == 3) && (c2 == 13)
                    lookup_table_c3c13 = lookup_table;
                elseif (c1 == 3) && (c2 == 14)
                    lookup_table_c3c14 = lookup_table;
                elseif (c1 == 3) && (c2 == 15)
                    lookup_table_c3c15 = lookup_table;
                elseif (c1 == 4) && (c2 == 13)
                    lookup_table_c4c13 = lookup_table;
                elseif (c1 == 4) && (c2 == 14)
                    lookup_table_c4c14 = lookup_table;
                elseif (c1 == 4) && (c2 == 15)
                    lookup_table_c4c15 = lookup_table;
                 elseif (c1 == 13) && (c2 == 14)
                    lookup_table_c13c14 = lookup_table;
                elseif (c1 == 13) && (c2 == 15)
                    lookup_table_c13c15 = lookup_table;
                elseif (c1 == 14) && (c2 == 15)
                    lookup_table_c14c15 = lookup_table;
                end
        
                % Save data and figure based on reachable set
                if reachable_set == 1
                    save(['/home/tanya/2CLookupTableIF/Data/lookup_table_c' int2str(c1) 'c' int2str(c2) '_id.mat'],['lookup_table_c' int2str(c1) 'c' int2str(c2)])

                    sgtitle(['Contacts ' int2str(c1) ' and ' int2str(c2) ' Look-Up Table Results (IF Depth)'])
                    saveas(fig,['/home/tanya/2CLookupTableIF/Data/Contacts ' int2str(c1) ' and ' int2str(c2) ' Look-Up Table Results (IF Depths).jpg'])
                elseif reachable_set == 2
                    save(['/home/tanya/2CLookupTableIF/Data/lookup_table_c' int2str(c1) 'c' int2str(c2) '_ir.mat'],['lookup_table_c' int2str(c1) 'c' int2str(c2)])

                    sgtitle(['Contacts ' int2str(c1) ' and ' int2str(c2) ' Look-Up Table Results (IF Ramp)'])
                    saveas(fig,['/home/tanya/2CLookupTableIF/Data/Contacts ' int2str(c1) ' and ' int2str(c2) ' Look-Up Table Results (IF Ramps).jpg'])
                end
            end
        end
    end
end

toc