function [entete, signal_complexe] = read_RAW(nom_fichier)
    entete = struct();
    data = [];
    
    
    f = fopen(nom_fichier, 'r');
    
    % Lire l'entête
    end_count = 0;
    count = 0;
    while end_count < 2
        line = fgetl(f)
        count = count + 1;
        
        if contains(line,'$END') == 1
            end_count = end_count + 1;
        elseif contains(line, '=')
            if strncmp(line, '$', 1) == 1
                parts = strsplit(line(2:end), '=');
            else
                parts = strsplit(line, '=');
            end
            if contains(parts{2},',')
                spstr=split(parts{2},',')
                parts{2}=spstr{1}
            end
            key = strtrim(parts{1});
            if contains(key,' ID')
                key='ID'
            end
            value = strtrim(parts{2});
            entete.(key) = value;
        end
    end
    
    % Lire les données
    while ~feof(f)
        line = fgetl(f);
        if isempty(strtrim(line))
            continue;
        end
        data = [data; str2num((line))]; %#ok<AGROW>
    end
    
    % Convertir en tableau NumPy
    data = data';
    
    % Séparer les parties réelles et imaginaires intercalées
    parties_reelles = data(1:2:end);
    parties_imaginaires = data(2:2:end);
    signal_complexe = parties_reelles + 1j * parties_imaginaires;
    
    fclose(f);
end
