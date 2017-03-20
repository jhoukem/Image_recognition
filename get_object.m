function [object, label] = get_object(matrix, k)
	object = (matrix == k);
	[i,j] = find(object ~= 0);
	min_x = min(j);
	min_y = min(i);
	max_x = max(j);
	max_y = max(i);
	object = object(min_y:max_y, min_x:max_x);
    
    av = (max_x + min_x) / 2;
    width = size(matrix, 2);
    
    if av < (width/4)
        label = 1;
    elseif av < 2*(width/4)
        label = 2;
    elseif av < 3*(width/4)
        label = 3;
    else
        label = 4;    
    end
    
end 