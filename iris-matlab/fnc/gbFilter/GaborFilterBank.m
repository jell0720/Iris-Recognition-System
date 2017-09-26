function SetOfGaborfilters = GaborFilterBank(a, b, sze)
%a: Number of scales
%b: Number of orientations
% There will be N = axb filters

SetOfGaborfilters = cell(a,b);
core = (sze+1)/2;

for i = 1:a
    f = 1/(4*(sqrt(2))^(i-1));
    gamma = sqrt(2);
    alpha = f/gamma;
    eta = sqrt(2);
    beta = f/eta;
    
    for j = 1:b
        theta = pi/b*(j-1);
        Gabfilt = zeros(sze);
        for x = 1:sze
            for y = 1:sze
                x_nhay = (x-core)*cos(theta) + (y-core)*sin(theta);
                y_nhay = (y-core)*cos(theta) - (x-core)*sin(theta);
                Gabfilt(x,y) = f^2/(pi*gamma*eta)*exp(-(alpha^2)*(x_nhay^2) - (beta^2)*(y_nhay^2))*exp(1i*2*pi*f*x_nhay);
            end
        end
        SetOfGaborfilters{i,j} = Gabfilt;
    end
end