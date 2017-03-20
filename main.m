clear all;
close all;
clc;
%% Initialisation mosaique 1

load('mosaique1.mat');
matrix1 = bwlabel(mosaique > 0);
nb_object = max(matrix1(:));
figure
imshow(mosaique);

[result_matrix1, label_vector] = get_result_matrix(mosaique);

%% Initialisation de la mosaique 2

load('mosaique2.mat');
matrix2 = bwlabel(mosaique > 0);
figure
imshow(mosaique);
result_matrix2 = get_result_matrix(mosaique);


noms = {'ovale', 'polygone', 'etoile', 'monstre'};
success = 0;

confusion = zeros(size(noms,2));


%% Partie graphique - Visualisation de la recherche

% Extraction de la bounding box
 index = round(rand(1)*100);
 object1 = get_object(matrix1, index);
 figure();
 imshow(object1);
 title(strcat('Image a retrouver est de type:', noms(label_vector(index))));
 object_index = find_closest_object(index, nb_object, result_matrix1, result_matrix2);
 
 object2 = get_object(matrix2, object_index);
 figure();
 imshow(object2);
 title(strcat('Image retrouvée est de type:', noms(label_vector(object_index))));
 
%% Statistiques.
for j = 1 : nb_object

    %Distance manathan
    object_index = find_closest_object(j, nb_object, result_matrix1, result_matrix2);
    object_retrieved = get_object(matrix2, object_index);
   
    if label_vector(j) == label_vector(object_index)
        success = success + 1;
    end
   
   confusion(label_vector(j), label_vector(object_index)) = confusion(label_vector(j), label_vector(object_index)) + 1; 

end

success_percentage = success/nb_object*100

% Taux de succes par classe
taux_succ_classe = diag(confusion) ./ sum(confusion,2)

indices = find (label_vector == 1);
ovales = result_matrix1(indices, 4:end);

indices = find (label_vector == 2);
poly = result_matrix1(indices, 4:end);

indices = find (label_vector == 3);
stars = result_matrix1(indices, 4:end);

indices = find (label_vector == 4);
monster = result_matrix1(indices,4:end);

figure
hold on 

plot(ovales(:,1), ovales(:,2), 'ro');
plot(poly(:,1), poly(:,2), 'sb');
plot(stars(:,1), stars(:,2), 'py');
plot(monster(:,1), monster(:,2), 'gd');

xlabel('Compasity');
ylabel('Perimeter');



