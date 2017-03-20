function prop = myproportion(im)

	nb_pixel = sum(im(:));
	[w,h]= size(im);
	prop = nb_pixel/(w*h)*100;
end 