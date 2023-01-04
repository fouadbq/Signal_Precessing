%       TP3 - Traitement d’un signal ECG

clc
clear all; close all



% Chargement du signal ECG
load('ecg.mat');

N =     length(ecg);
fe =    500;
t=(0:N-1)*(1/fe);

% Tracé du signal ECG en fonction du temps
figure
    subplot(2,1,1)
    plot(t,ecg)
    xlabel('Temps (s)')
    ylabel('Amplitude')
    title('Signal ECG en fonction du temps')
    % Zoom sur une période du signal ECG
    subplot(2,1,2)
    plot(t(1:1000),ecg(1:1000))
    xlabel('Temps (s)')
    ylabel('Amplitude')
    title('Zoom sur une période du signal ECG')
    
%% Filtre passs-bas pour éliminer les fréquences inférieures à 0.5Hz

Signal_Spectrum=fft(ecg);

frequence= linspace(-fe/2, fe/2, N);

Index_0_5_Hz=ceil((0.5*N)/fe);

Filter_Passe_Haut=ones(size(Signal_Spectrum));
Filter_Passe_Haut(   1:Index_0_5_Hz       )=0;
Filter_Passe_Haut(   N-Index_0_5_Hz:N     )=0;

Filtered_Spectrum= Filter_Passe_Haut.*Signal_Spectrum  ;

Filtered_Signal=ifft(Filtered_Spectrum,'symmetric');


figure
    subplot(3,1,1)
        plot(t,ecg) 
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG')    
    subplot(3,1,2)
        plot(t,Filtered_Signal)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG filtré')
    subplot(3,1,3)
        plot(t,ecg-Filtered_Signal)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Le bruit éliminé')
        
        
        
%%  Suppression des interférences des lignes électriques 50Hz


Index_50_Hz=ceil((50*N)/fe);


Filtre_Pass_Notch = ones(size(ecg));
Filtre_Pass_Notch(Index_50_Hz)=0;
Filtre_Pass_Notch(N-Index_50_Hz+1)=0;


Filtered_Spectrum_V2   = Filtre_Pass_Notch.*Signal_Spectrum  ;

Filtered_Signal_V2 =ifft(Filtered_Spectrum_V2,'symmetric');


figure
    subplot(3,1,1)
        plot(t,Filtered_Signal) 
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG filtré')    
    subplot(3,1,2)
        plot(t,Filtered_Signal_V2)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG filtré V2')
    subplot(3,1,3)
        plot(t,Filtered_Signal-Filtered_Signal_V2)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Le bruit éliminé')
        
      
        
        



%       Amélioration du rapport signal sur bruit

%% Elimination bruit hautes frequences 

Min_Frequnecy = 20;

Indexe_Min_Frequnecy = ceil((Min_Frequnecy*N)/fe);

Pass_Bas_Ideal = zeros(size(ecg)); 

Pass_Bas_Ideal(1:Indexe_Min_Frequnecy)=1;
Pass_Bas_Ideal(N-Indexe_Min_Frequnecy+1:N)=1;


Filtered_Signal_V3 = Pass_Bas_Ideal .* fft(Filtered_Signal_V2);

Filtered_Signal_V3 = ifft(Filtered_Signal_V3,'symmetric');




figure
    subplot(2,1,1)
        plot(t,ecg) 
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG initial')    
    subplot(2,1,2)
        plot(t,Filtered_Signal_V3)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG filtré V3')


%% Elimination bruit basses frequences 

Max_Frequnecy = 0.8;

Indexe_Max_Frequnecy = floor((Max_Frequnecy*N)/fe);

Pass_Haut_Ideal = ones(size(ecg)); 

Pass_Haut_Ideal(1:Indexe_Max_Frequnecy)=0;
Pass_Haut_Ideal(N-Indexe_Max_Frequnecy:N)=0;


Filtered_Signal_V4 = Pass_Haut_Ideal .* fft(Filtered_Signal_V3);

Filtered_Signal_V4 = ifft(Filtered_Signal_V4,'symmetric');


figure
    subplot(2,1,1)
        plot(t,Filtered_Signal_V3) 
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG initial V3')    
    subplot(2,1,2)
        plot(t,Filtered_Signal_V4)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Signal ECG filtré V4')




%%  Identification de la fréquence cardiaque avec la fonction d’autocorrélation

% Calcul de la fonction d'autocorrélation
Autocorrelation = xcorr(Filtered_Signal_V3,Filtered_Signal_V3);

% localisation du maximum de la fonction d'autocorrélation
[~, Max_Index] = max(Autocorrelation);

% Calcule la période du signal en utilisant l'index du maximum
period = Max_Index / fe;

% Calcule la fréquence cardiaque en battements par minute
Frequence_Cardiaque = fe / period




