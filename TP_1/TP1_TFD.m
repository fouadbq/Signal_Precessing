        %   TP1- Analyse spectrale d’un x Transformée de Fourier discrète
clc;
clear all;
close all;

fe = 10000; % Frequence d'echantillonnage 
N = 5000; % Nbr d'echantillons

t=0:1/fe:(N-1)/fe;

x = 1.2*cos(2*pi*440*t) + 3*cos(2*pi*550*t) + 0.6*cos(2*pi*2500*t);

x_Spectrum = abs(fft(x));
x_Spectrum = x_Spectrum / N; % Normalisation de la amplitudes de spectre
x_Spectrum_shifted = fftshift(  x_Spectrum    );

f= linspace(-fe/2, fe/2, N);


figure
    subplot(3,1,1)
        plot(t, x,'.')
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Le signal x(t)')
    subplot(3,1,2)
        plot(f,x_Spectrum)
        xlabel('Fréquence (Hz)')
        ylabel('Amplitude') 
        title('Spectre du signal x(t)')
    subplot(3,1,3)
        plot(f,x_Spectrum_shifted)  
        xlabel('Fréquence (Hz)')
        ylabel('Amplitude')
        title('Spectre du signal x(t) decale')
        
        
% Elimination de la frequence 2500 Hz


index=ceil((2400*N)/fe);

Filter_Passe_Bas=zeros(size(f));

Filter_Passe_Bas(1:index)=1;

Filter_Passe_Bas(5000-index:5000)=1;

Filtered_Spectrum=fftshift(Filter_Passe_Bas.*x_Spectrum);
figure
    subplot(3,1,1)
        plot(x_Spectrum)
        xlabel('Fréquence (Hz)') 
        ylabel('Amplitude') 
        title('Spectre du signal')
    subplot(3,1,2)
        plot(Filter_Passe_Bas)
        xlabel('Fréquence (Hz)') 
        ylabel('Amplitude') 
        title('Le filtre pass-bas')
    subplot(3,1,3)
        plot(Filtered_Spectrum)
        xlabel('Fréquence (Hz)') 
        ylabel('Amplitude') 
        title('Signal filtré')  
        
    
%%
    
bruit=4*randn(size(x));

% sound(bruit)

Signal_bruite= x + bruit;   % superposition du bruit et du signal x(t)
    
Noised_X_Spectrum=abs(fft(Signal_bruite));
Noised_X_Spectrum=Noised_X_Spectrum/N; % Normalisation 

Noised_X_Spectrum_Shifted=fftshift(Noised_X_Spectrum);

bruit_augmente=15*randn(size(x));
Sig_Bruit_Aug_Spectrum=fftshift(abs(fft(bruit_augmente+x)));

figure
    subplot(3,1,1)
        plot(t, Signal_bruite,'g')
        xlabel('Temps (s)') 
        ylabel('Amplitude') 
        title('Signal bruité')
    subplot(3,1,2)
        plot(f, Noised_X_Spectrum_Shifted,'g')
        xlabel('Temps (s)')
        ylabel('Amplitude') 
        title('Le spectre du signal bruité')
    subplot(3,1,3)
        plot(f, Sig_Bruit_Aug_Spectrum,'g') %   ce stade les composantes fréquentielles du signal s'interférent avec celles du bruit => la distinction entre les deux est devenue impossible
        xlabel('Temps (s)') 
        ylabel('Amplitude') 
        title('Le spectre du signal bruité (bruit augmenté)')


        
%%

[signal,fs]=audioread('bluewhale.au');

Bluewhale_Sound = signal(  2.45e4:3.10e4   ); % Sous-ensemble de données correspondant au chant du rorqual bleu

tt=( 0:length(Bluewhale_Sound)-1    )*( 10/fs );

n = 2^nextpow2(length(Bluewhale_Sound)); % La longueur de signal qui est une puissance de 2

Bluewhale_Sound_Spectrum=fftshift(  abs(fft(Bluewhale_Sound,n)).^2 / (n*fs)    );

freq =  fs/2*linspace(-0.5,0.5,n);

figure
    subplot(2,1,1)
        plot(tt, Bluewhale_Sound)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Chant du rorqual bleu')
    subplot(2,1,2)
        plot(freq, Bluewhale_Sound_Spectrum)
        xlabel('Temps (s)')
        ylabel('Amplitude')
        title('Le spectre du chant du rorqual bleu')

% sound(Bluewhale_Sound, fs)



















