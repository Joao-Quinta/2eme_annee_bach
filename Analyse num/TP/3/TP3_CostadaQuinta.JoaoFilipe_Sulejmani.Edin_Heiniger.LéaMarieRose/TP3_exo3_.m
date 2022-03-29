% Joao Costa, Edin Sulejmani, Lea Heiniger

%%% Exo 3:
%% (A) 

    %commande: <format long e, format compact ;>
        % format long e -> permet d'afficher les nombres en entier long
        % format compact -> permet d'afficher les nombres de fa?on compacte
    %commande <eps, eps('double'), eps ('single')
        % eps -> retourne la distance depuis 1.0 au suivant grand nb de
        % eps ('double') -> affiche l'epsilon en double pr?cision, meme
            % chose que eps(1.0)
        % eps ('single') -> affiche l'epsilon en simple pr?cision
    %commande <realmax, realmin>
        % realmax -> retourne le plus grand fini floating nb:
            % (2-2^(-52))*2^1023
        % realmin -> retourne le plus petit nb positif normalis?
            % (floating-point) en double pr?cision: 2^(-1022)
    %commande <single, double>
        % single -> variable en pr?cision simple, enregistr? en 32 bits.
        % double -> variable en double pr?cision, enregistr? en 64 bits,
            % utilis? comme type par d?faut

%% (B)
    
    %commande: <var1 =1; ...... B=single(A);>
        %var1 = 1 -> var1 vaut 1, en pr?cision double par d?faut
        %var2 = single(var1) -> var1 en pr?cision simple
        %var3 = 1 + 1j * 2 -> 
        %A = rand(5,5) -> A est une matrice taille 5x5 en double pr?cision
        %B = single(A) -> toutles les valeurs de A, sont mtn en pr?cision
            %simple
    %commande: whos
        %affiche un "tableau" o? pour toutes les variables d?finies, on
        %peut trouver plein d'informations -> Nom, Taille (matricille),
        %Bytes, classe (simple ou double) et leurs Attribus.

%% (C) 

    %la boucle s'arrte car x se raproche de tellement de 0 qu'il finit par
        %le consid?rer comme ?tant 0 par la machine, ce qui arr?te la boucle infinie
        
        %? la fin de la boucle x est tellement petit, que eps - x > 0
        
    %pr?cision simple: en simple pr?cision x est consid?r? comme 0, alors
    %qu'il est plus grand que eps

%% (D)

    epsilon=1.0;

    while (1.0+0.5 *epsilon)~= 1.0
        epsilon=epsilon*0.5;
    end
    
    epsilon
    
    diffeps=abs(epsilon-eps) %on peut voir que epsilon est egal a eps
    
    emachTheorique=2^(-52);
    
    diffemach=abs(epsilon-emachTheorique) %la aussi la difference est nulle

%% (E)

clear all;
xSimple=1;
%while xSimple > 0
while single(xSimple) > 0
    xSimple = xSimple / 2
end
xSimple
    
    %output:
        %xDouble = 4.940656458412465e-324
        %xSimple = 7.006492321624085e-46
        %realmin = 2.225073858507201e-308
            
            %xDouble est bien plus petit que realmin, alors que xSimple est
                %bien plus grand