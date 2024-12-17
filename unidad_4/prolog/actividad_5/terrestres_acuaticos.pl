% animal(ID, Nombre, Caparazon, Escamas, Plumas, Pulmones, Patas, EntornoID, HabitatID, AlimentacionID, TerminacionID, CategoriaID, Venenoso, Dientes, Comestible, Cola, Cuernos, Pelos, Predador, Vertebrado)
animal(1, 'Tiburon', no, si, no, no, 0, 2, 3, 1, 3, 5, si, no, no, si, no, no, si, si).
animal(2, 'Gato', no, no, no, si, 4, 3, 3, 2, 1, 2, no, si, si, no, no, si, no, si).
animal(3, 'Aguila', no, no, si, si, 2, 1, 1, 1, 1, 1, no, si, no, no, no, no, si, si).
animal(4, 'Vaca', no, no, no, si, 4, 3, 1, 3, 2, 3, no, si, si, no, si, no, no, si).
animal(5, 'Delfin', no, si, no, si, 0, 2, 3, 2, 3, 5, no, si, si, no, no, no, no, si).

% entorno(ID, Descripcion)
%entorno(1, 'Volador').
entorno(2, 'Acuatico').
entorno(3, 'Terrestre').

% habitat(ID, Descripcion)
habitat(1, 'granja').
habitat(2, 'ciudad').
habitat(3, 'salvaje').
habitat(4, 'granja y ciudad').

% alimentacion(ID, Descripcion)
alimentacion(1, 'carnivoro').
alimentacion(2, 'omnivoro').
alimentacion(3, 'hervivoro').

% terminacion_patas(ID, Descripcion)
terminacion_patas(1, 'dedos').
terminacion_patas(2, 'pezuñas').
terminacion_patas(3, 'otros').

% categoria(ID, Descripcion)
categoria(1, 'mamifero').
categoria(2, 'felino').
categoria(3, 'roedor').
categoria(4, 'marsupial').
categoria(5, 'otros').

% Características de los animales
caracteristica(1, no, si, si, no, no, no, si, no, no, 0, no, no, no, si, si, no).  % Tiburón
caracteristica(2, no, si, si, no, no, si, no, no, no, 4, si, no, no, si, si, no).  % Gato
caracteristica(3, no, no, si, no, si, no, no, no, no, 2, no, si, si, si, si, no).  % Aguila
caracteristica(4, no, si, si, no, no, si, no, si, no, 4, si, no, no, si, si, no).  % Vaca
caracteristica(5, no, si, no, si, no, si, no, no, no, 0, no, si, no, si, si, no).  % Delfin

% animal_entorno(ID, EntornoID)
animal_entorno(1, 2).  % Tiburon es acuático
animal_entorno(2, 3).  % Gato es terrestre
%animal_entorno(3, 1).  % Aguila es volador
animal_entorno(4, 3).  % Vaca es terrestre
animal_entorno(5, 2).  % Delfin es acuático

% animal_habitat(ID, HabitatID)
animal_habitat(1, 3).  % Tiburon en hábitat salvaje
animal_habitat(2, 2).  % Gato en hábitat ciudad
animal_habitat(3, 1).  % Aguila en hábitat granja
animal_habitat(4, 3).  % Vaca en hábitat salvaje
animal_habitat(5, 3).  % Delfin en hábitat salvaje

% animal_alimentacion(ID, AlimentacionID)
animal_alimentacion(1, 1).  % Tiburon es carnivoro
animal_alimentacion(2, 2).  % Gato es omnivoro
animal_alimentacion(3, 1).  % Aguila es carnivoro
animal_alimentacion(4, 3).  % Vaca es hervivoro
animal_alimentacion(5, 2).  % Delfin es omnivoro

% Un animal es acuático si tiene escamas y no tiene pulmones.
es_acuatico(Nombre) :-
    animal(_, Nombre, _, si, _, no, _, 2, _, _, _).

% Un animal es terrestre si tiene pulmones y patas.
es_terrestre(Nombre) :-
    animal(_, Nombre, _, _, _, si, Patas, 3, _, _, _),
    Patas > 0.

% Clasificación del animal por entorno
clasificar_animal(Nombre, 'Acuatico') :-
    es_acuatico(Nombre).
    
clasificar_animal(Nombre, 'Terrestre') :-
    es_terrestre(Nombre).

% Clasificación del animal por otras características
clasificar_animal(Nombre, Categoria) :-
    animal(_, Nombre, _, _, _, _, _, _, _, _, CategoriaID),
    categoria(CategoriaID, Categoria).

preguntar_y_clasificar :-
    %Pulmones
    writeln('¿El animal tiene pulmones? (s/n)'),
    read_line_to_string(user_input, PulmonesRaw),
    downcase_atom(PulmonesRaw, Pulmones),  % Convierte la respuesta a minúsculas
    %Patas
    writeln('¿Cuántas patas tiene el animal? (número)'),
    read_line_to_string(user_input, PatasString),
    atom_number(PatasString, Patas),
    %Escamas
    writeln('¿El animal tiene escamas? (s/n)'),
    read_line_to_string(user_input, EscamasRaw),
    downcase_atom(EscamasRaw, Escamas),  % Convierte la respuesta a minúsculas
    
    tomar_decision(Pulmones, Patas, Escamas).



% Clasificación de animales: acuático o terrestre
tomar_decision('n', 0, 'n') :- % Si no tiene pulmones, 0 patas y no tiene escamas
    writeln('El animal es probablemente ACUÁTICO').

tomar_decision('s', Patas, 'n') :- % Si tiene pulmones, patas > 0 y no tiene escamas
    Patas > 0,
    writeln('El animal es probablemente TERRESTRE').

tomar_decision('n', Patas, 's') :- % Si no tiene pulmones, tiene escamas, y patas > 0
    Patas > 0,
    writeln('El animal es probablemente ACUÁTICO').
%Evalúa el caso cuando el animal tiene escamas y patas. Esto cubre el caso de animales 
%acuáticos que pueden tener patas (como los anfibios, como ranas, etc.).
tomar_decision(_, _, _) :- % Para cualquier otra combinación
    writeln('No se pudo determinar con certeza el tipo de animal.').
