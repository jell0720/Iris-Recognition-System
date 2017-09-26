% %% Make Gabor filter-bank
% f = [2];
% ori = [0];
% gb_filt = gabor(f, ori)


%% Visualization
for i = 1:4
	for j = 1:8
		gb_filt = SOGF{i,j};
		gb_real = real(gb_filt);

		figure(1); clf
		surf(gb_real)
	end
end

