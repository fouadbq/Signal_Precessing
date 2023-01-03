%Synthèse et analyse spectrale d’une gamme de musique
clc;
clear all;
close all;

[signal,fs]=audioread('Sound.au');

% sound(signal,fs)

t = (  0:length(signal)-1  )*(1/fs);

figure        
    plot(t, signal)
    xlabel('Temps (s)')
    ylabel('Amplitude')
    title('Le signal')


fs_slow=fs/2;
fs_acc=fs*2;

% sound(signal,fs_slow)
% sound(signal,fs_acc)

Indexes=1:length(signal);


figure 
    plot(Indexes, signal)
    xlabel('Temps (s)')
    ylabel('Amplitude')
    title('Le signal selon les indices de signal(t)')
    
    
% Indice de la fin du morceau « Rien ne sert de » selon une estimation visuelle
    End_Index=floor(length(signal)/3.85);   


% Comparaison des signaux élémentaires avec le signal original avant le Découpage 

    % signal extrait isole : « Rien ne sert de » 
        extracted_signal_1(1:length(signal) )=0;
        extracted_signal_1( 1:      End_Index  +1)=signal( 1:      End_Index  +1);     
        Rien_ne_sert_de = signal(1:End_Index);

    % sound(  Rien_ne_sert_de     ,fs)

    % signal extrait isole : « Courir » 
        extracted_signal_2(1 :length(signal) )=0;
        extracted_signal_2(End_Index+1:floor(length(signal)/2.5) )=signal(End_Index+1:floor(length(signal)/2.5) );
        Courir       = signal( End_Index  +1:      floor(length(signal)/2.5)   );

    % signal extrait isole : « Il faut »
        extracted_signal_3(1 :length(signal) )=0;
        extracted_signal_3( floor(length(signal)/2.5)  +1:      floor(length(signal)/1.9)   ) = signal( floor(length(signal)/2.5)  +1:      floor(length(signal)/1.9)   );
        Il_faut       = signal( floor(length(signal)/2.5)  +1:      floor(length(signal)/1.9)   );

    % signal extrait isole : « partir a point »
        extracted_signal_4(1 :length(signal) )=0;
        extracted_signal_4( floor(length(signal)/1.9)  +1:      length(signal) ) = signal( floor(length(signal)/1.9)  +1:      length(signal) );
        Partir_a_point       = signal( floor(length(signal)/1.9)  +1:      length(signal) );


    
% Comparaison des signaux élémentaires avec le signal roginal
figure
    subplot(5,1,1)
        plot(t,signal)
        title('Le signal original complet')
        xlabel('Temps en s')    ;   ylabel('Amplitude')    
    subplot(5,1,2)
        plot(   t, extracted_signal_1)
        title('Le signal extrait : « Rien ne sert de » ')
        xlabel('Temps en s')    ;   ylabel('Amplitude')
    subplot(5,1,3)
        plot(   t, extracted_signal_2)
        title('Le signal extrait : « Courir » ')
        xlabel('Temps en s')    ;   ylabel('Amplitude')
    subplot(5,1,4)
        plot(   t, extracted_signal_3)
        title('Le signal extrait : « Il faut » ')
        xlabel('Temps en s')    ;   ylabel('Amplitude')
    subplot(5,1,5)
        plot(   t, extracted_signal_4)
        title('Le signal extrait : « Partir a point » ')
        xlabel('Temps en s')    ;   ylabel('Amplitude')
        
        
        
%  Visualization des quatres sons extraits isolés
figure
        subplot(4,1,1)
            plot(t( 1:      End_Index  )      ,Rien_ne_sert_de)
            title('Le signal extrait : « Rien ne sert de » ')
            xlabel('Temps en s')    ;   ylabel('Amplitude')    
        subplot(4,1,2)
            plot(t( End_Index+1:      floor(length(signal)/2.5)  )      ,Courir)
            title('Le signal : « Courrir »')
            xlabel('Temps en s')    ;   ylabel('Amplitude')
        subplot(4,1,3)
            plot(   t( floor(length(signal)/2.5)  +1:      floor(length(signal)/1.9)   ), Il_faut)
            title('Le signal extrait : « Il faut » ')
            xlabel('Temps en s')    ;   ylabel('Amplitude')
        subplot(4,1,4)
            plot(   t(  floor(length(signal)/1.9)   +1:     length(signal) ), Partir_a_point)
            title('Le signal extrait : « Partir a point » ')
            xlabel('Temps en s')    ;   ylabel('Amplitude')
            
            
% La concatenation des morceaux 

phrase_sythetisee = Rien_ne_sert_de; 
phrase_sythetisee(  length(phrase_sythetisee)+1:        length(phrase_sythetisee)   +   length(Partir_a_point)   )=     Partir_a_point;
phrase_sythetisee(  length(phrase_sythetisee)+1:        length(phrase_sythetisee)   +   length(Il_faut)          )=     Il_faut;
phrase_sythetisee(  length(phrase_sythetisee)+1:        length(phrase_sythetisee)   +   length(Courir)           )=     Courir;

% sound(phrase_sythetisee,fs)


%   Visualization de la phrase sythetisée 
figure
    subplot(2,1,1)
    plot(phrase_sythetisee)
    title('La phrase sythetisée')
    xlabel('Temps en s')    ;   ylabel('Amplitude')  
    subplot(2,1,2)    
    plot(signal)
    title('La phrase original')
    xlabel('Temps en s')    ;   ylabel('Amplitude') 


%%



fs=8192;
t=0:1/fs:1;  % la longueur de l'axe est de 1 second
N=length(t)*8;

Do1=cos(2*pi*262*t) ;       % La note Do1
Re=cos(2*pi*294*t);         % La note Ré
Mi=cos(2*pi*330*t);         % La note Mi
Fa=cos(2*pi*349*t);         % La note Fa
So1=cos(2*pi*392*t);        % La note So1
La=cos(2*pi*440*t);         % La note La
Si=cos(2*pi*494*t);         % La note Si
Do2=cos(2*pi*523*t);        % La note Do2

Gamme_Musical=[Do1 Re Mi Fa So1 La Si Do2];  % Concatenation des huit notes 

Gamme_Musical_Spectrum=fftshift(abs(fft(    Gamme_Musical   )))/N; % Nprmalisation des amplitudes 


% signalAnalyzer(Gamme_Musical_Spectrum)

% sound(Gamme_Musical,fs)



% Calculer le spectre en décibels
Gamme_Musical_Spectrum_Db = db(Gamme_Musical_Spectrum);

% Afficher le spectre de fréquence en échelle en décibels
figure
    subplot(2,1,1)
        plot(frequence, Gamme_Musical_Spectrum)
        xlabel('Fréquence (Hz)')
        ylabel('Amplitude')
        title('Spectre de la gamme musicale (échelle linéaire)')
    subplot(2,1,2)
        plot(frequence, Gamme_Musical_Spectrum_Db)
        xlabel('Fréquence (Hz)')
        ylabel('Amplitude (dB)')
        title('Spectre  de la gamme musicale (échelle en décibels)')





