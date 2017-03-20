
function [result_matrix, label_vector] = get_result_matrix(image)

matrix = bwlabel(image > 0);
nb_object = max(matrix(:));
label_vector = zeros(nb_object, 1);

% Je range toutes les formes de l'image dans la matrice.
result_matrix = zeros(nb_object, 5);

for k = 1 : nb_object
    [object, label] = get_object(matrix, k);
    nb_pixel = sum(object(:));
    result_matrix(k,1) = k;
    result_matrix(k,2) = nb_pixel;
    result_matrix(k,3) = myproportion(object);
    
    perimeter = regionprops(object,'Perimeter');
    perimeter = perimeter.Perimeter;
    
    result_matrix(k,4) = nb_pixel / (perimeter * perimeter); % Compasity
    result_matrix(k,5) = perimeter;
    label_vector(k) = label;
end

%Je normalise toutes les valeurs de la matrice:

moy_pixel = mean(result_matrix(:,2));
moy_prop = mean(result_matrix(:,3));
moy_perimeter = mean(result_matrix(:,4));
moy_compasity = mean(result_matrix(:,5));

ecarttype_pixel = std(result_matrix(:,2));
ecarttype_prop = std(result_matrix(:,3));
ecarttype_peri = std(result_matrix(:,4));
ecarttype_compa = std(result_matrix(:,5));

for k = 1:nb_object
    result_matrix(k,2) = (result_matrix(k,2) - moy_pixel) / ecarttype_pixel;
    result_matrix(k,3) = (result_matrix(k,3) - moy_prop) / ecarttype_prop;
    result_matrix(k,4) = (result_matrix(k,4) - moy_perimeter) / ecarttype_peri;
    result_matrix(k,5) = (result_matrix(k,5) - moy_compasity) / ecarttype_compa;
end

end