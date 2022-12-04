%% Exemplo
% DESCRIPTIVE TEXT
b=1; 
a=[1,-1,0.9];
x=impseq(0,-20,120); 
n=-20:120;
h=filter(b,a,x);
stem(n,h);
title('Resposta ao Impulso'); 
xlabel('n'); 
ylabel('h[n]');

%% Questão 01
% DESCRIPTIVE TEXT
t = 0:0.1:200;
f = 0.01;
a = 1;
y = a*sin(2*pi*f*t);
noise = rand(1,2001)-0.5;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1);
plot(t,y);
title('Sinal puro'); 

subplot(2,1,2);
plot(t, noise)
title('Ruído puro'); 
pause;
close;

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1);
plot(t, y+noise)
title('Sinal + ruído (amplitude 1)'); 

subplot(3,1,2);
plot(t, y+10*noise)
title('Sinal + ruído (amplitude 10)');

subplot(3,1,3);
plot(t, y+5*noise)
title('Sinal + ruído (amplitude 5)');
pause;
close;

%% Questão 02 - Filtro passa-baixas
% DESCRIPTIVE TEXT
figure('units','normalized','outerposition',[0 0 1 1])
B = 1/3*ones(3,1);
out = filter(B,1,y+noise);
subplot(3,1,1)
plot(t, y+noise)
title('Sinal + ruído (amplitude 1)');

subplot(3,1,2)
plot(t, out)
title('Sinal + ruído com filtro M = 3'); 

C = 1/15*ones(15,1);
out = filter(C,1,y+noise);
subplot(3,1,3)
plot(t, out)
title('Sinal + ruído com filtro M = 15'); 

%% Questão 03 - 
% DESCRIPTIVE TEXT
a1=1;
b1=[0.5, -0.5];

a2=1;
b2 = [0.5, 0.5];

[y,Fs] = audioread('musica.au');
sound(y)
pause;
h1=filter(b1,a1,y);
sum(abs(h1))
freqz(b1,a1,Fs);
sound(h1)
pause;

h2=filter(b2,a2,y);
sum(abs(h2))
freqz(b2,a2,Fs);
sound(h2)

%% Questão 04 - 
% DESCRIPTIVE TEXT
b3=1;
N = 2000;
alfa = 0.5;
a3=zeros(N+1,1);
a3(1) = 1;
a3(N+1) = alfa;
soundsc(a3);
pause;
freqz(b3,a3);

[y2,Fs2] = audioread('audio1_lab.wav');
sound(y2)
pause;
h3=filter(b3,a3,y2);
%h3 = [h3' , zeros(1,400000)];
sound(h3)

%%
for alfa = 0:0.25:1.75
    disp(alfa)

    b3=1;
    N = 2000;
    a3=zeros(N+1,1);
    a3(1) = 1;
    a3(N+1) = alfa;
    %soundsc(a3);
    %pause;
    freqz(b3,a3);

    [y2,Fs2] = audioread('audio1_lab.wav');
    %sound(y2)
    %pause;

    h3=filter(b3,a3,y2);
    sound(h3)
    pause;
end

%% Funções extras 
% DESCRIPTIVE TEXT
function [x,n] = impseq(n0,n1,n2)
    % Generates x(n) = delta(n-n0); n1 <= n <= n2
    % ----------------------------------------------
    % [x,n] = impseq(n0,n1,n2)
    %
    n = n1:n2; 
    x = (n-n0) == 0;
end