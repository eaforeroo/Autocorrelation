clear all;
% Wave properties
A1=10;                           % Amplitude (dimensionless)
w1=50;                           % esta es la angular Frequency, frequency = w1/dos pi
frecuencia_teorica= w1/(2*pi)
periodo = 1/frecuencia_teorica  %% periodo de oscilacion
dt = periodo/10;
ndats = 1000;
t=[dt:dt:ndats*dt];
% Noise inclusion
noiseAmplitude=randi(5);
noise=noiseAmplitude* rand(1, length(t));
% Sum of a w1-Hz sinusoid and a noise
x=A1*cos(w1*t)+noise; 
plot(t,x,'k-o')
[y,lags]=xcorr(x,'unbiased');
plot(lags*dt,y), grid
hold on
tmax=dt*ndats;
df=1./tmax;
hold on
% Wave properties
A2=10;                           % Amplitude (dimensionless)
w2=50;                           % esta es la angular Frequency, frequency = w1/dos pi
frecuencia_teorica2= w2/(2*pi)
periodo2 = 1/frecuencia_teorica2  %% periodo de oscilacion
dt2 = periodo2/10;
ndats2 = 1000;
t2=[dt2:dt2:ndats2*dt2];
% Noise inclusion
noiseAmplitude2=randi(5);
noise2=noiseAmplitude2* rand(1, length(t2));
% Sum of a w1-Hz sinusoid and a noise
x2=A2*cos(w2*t)+noise; 
x2=x2 - mean(x2); % Deleting the mean value
x2=x2./std(x2); % Normalizing the time series
for tau=(0:1000) % We have to fix the negative values of tau (if)
    Rxx(tau+1)= 1; % Assuring the series starts at 1
    for n=1+tau:ndats2 % Ensuring vector index such as positive values
        Rxx(tau+1)=Rxx(tau+1)+x(n)*x(n-tau);
    end;
    Rxx(tau+1)=Rxx(tau+1)/(ndats2-tau);
    lag(tau+1)=tau*dt2; % Horizontal axis at the same as 
end;
plot(lag,Rxx)
grid;
title('Autocorrelation function of sine wave + noise function ');
xlabel('Lags');
ylabel('Autocorrelation');
