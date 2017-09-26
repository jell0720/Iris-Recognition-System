function n = normalise(im, minval, maxval)

    if ~(nargin == 1 | nargin == 3)
       error('Number of arguments must be 1 or 3');
    end
    
    if nargin == 1 
        minval=0; maxval=1;
    end
	if ndims(im) == 3 
	    hsv = rgb2hsv(im);
	    v = hsv(:,:,3);
	    v = v - min(v(:)); 
	    v = v/max(v(:))*(maxval-minval)+minval;
	    hsv(:,:,3) = v;
	    n = hsv2rgb(hsv);
	else          
	    if ~isa(im,'double'), im = double(im); end
	    n = im - min(im(:));
	    n = n/max(n(:))*(maxval-minval)+minval;
    end