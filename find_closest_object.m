function object_index = find_closest_object(j, nb_object, result_matrix1, result_matrix2)

object_index = 0;
object_value = 10000;
            
    for k = 1 : nb_object
	
        pixel = abs(result_matrix1(j,2) - result_matrix2(k,2));
        intensity = abs(result_matrix1(j,3) - result_matrix2(k,3));
        peri = abs(result_matrix1(j,4) - result_matrix2(k,4));
        compasity = abs(result_matrix1(j,5) - result_matrix2(k,5));
        result = pixel + intensity + peri + compasity;
        if object_value > result
            object_index = k;
            object_value = result;
        end
    end
end