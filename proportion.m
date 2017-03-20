function propo = proportion(im)
	size(im)
	nb_pixel = sum(im(:));
	[w,h]= size(im)
	propo = nb_pixel/(w*h)*100
end 