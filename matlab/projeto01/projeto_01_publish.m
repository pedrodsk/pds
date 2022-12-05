%% Exemplo
% DESCRIPTIVE TEXT
b=1; 
a=[1,-1,0.9];
x=impseq(0,-20,120); 
n=-20:120;
h=filter(b,a,x);
figure(1)
stem(n,h);
title('Resposta ao Impulso'); 
xlabel('n'); 
ylabel('h[n]');

%% Questão 01 - Gerar sinal senoidal com e sem ruído.
% A função rand(1,N)do Matlab gera uma sequência aleatória de comprimento N, cujos
% elementos se encontram distribuídos uniformemente em [0,1]. Dada um sequência senoidal
% de amplitude 1 e frequência 0,01, adicione o ruído definido por rand(1,N) – 0,5 e trace os
% gráficos da senóide com e sem ruído (plot) . Troque a amplitude do ruído para 10 e 5
% vezes a da senóide e ilustre graficamente o que acontece.

t = 0:0.1:200;
f = 0.01;
a = 1;
y = a*sin(2*pi*f*t);
noise = rand(1,2001)-0.5;

%figure('units','normalized','outerposition',[0 0 1 1])
figure(2)
subplot(2,1,1);
plot(t,y);
title('Sinal puro'); 

subplot(2,1,2);
plot(t, noise)
title('Ruído puro'); 

%figure('units','normalized','outerposition',[0 0 1 1])
figure(3)
subplot(3,1,1);
plot(t, y+noise)
title('Sinal + ruído (amplitude 1)'); 

subplot(3,1,2);
plot(t, y+10*noise)
title('Sinal + ruído (amplitude 10)');

subplot(3,1,3);
plot(t, y+5*noise)
title('Sinal + ruído (amplitude 5)');

%% Questão 02 - Filtro passa-baixas pelo filtro da média móvel.
% a. Considere M = 3. Faça a implementação desse filtro no Matlab usando filter.
% b. Dado o sinal ruidoso obtido na primeira questão, realize a sua filtragem pelo
% filtro implementado e plote o resultado obtido. Experimente também outros
% valores de M e descreva as suas observações. Que filtro é esse?

B = 1/3*ones(3,1);
out = filter(B,1,y+noise);
figure(4)
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

%% Questão 03 - Considere dois filtros FIR S1 e S2, respectivamente:
% y[n] = 0,5x[n] – 0,5x[n-1] e y[n] = 0,5 x[n] + 0,5x[n-1]
% a. Escreva funções no Matlab para implementar esses filtros.
% b. Faça o download do arquivo musica.au. Use o comando auread para carregar
% o arquivo no Matlab e utilize a função sound para escutar o sinal. Em seguida,
% filtre o sinal de áudio em cada um dos sistemas S1 e S2 e escute os sinais
% filtrados. Como os filtros modificam o sinal de áudio? Descreva as suas
% observações.
% c. Obtenha a resposta em freqüência dos filtros. Classifique-os quanto a
% seletividade em freqüência.

a1=1;
b1=[0.5, -0.5];

a2=1;
b2 = [0.5, 0.5];

[y,Fs] = audioread('musica.au');
sound(y)
h1=filter(b1,a1,y);
sum(abs(h1))
figure(6)
freqz(b1,a1,Fs);
sound(h1)

h2=filter(b2,a2,y);
sum(abs(h2))
figure(7)
freqz(b2,a2,Fs);
sound(h2)

%% Questão 04 - 
% y[n] = x[n] + αy[n-N]
% a. Considere N = 2000 e α = 0,5. Faça a implementação desse filtro no Matlab e
% trace a resposta ao impulso do sistema. Usando o comando soundsc e escute o
% sinal obtido.
% b. Faça o download do arquivo audio1_lab.wav. Use o comando wavread para
% carregar o arquivo no Matlab e utilize a função sound para escutar o sinal. Para
% garantir que a saída não seja truncada, é conveniente prolongar o sinal x com
% amostras nulas:
% >> x = [x’ , zeros(1,4000)];
% Faça a filtragem do sinal pelo filtro implementado. Escute o resultado obtido.

b3=1;
N = 2000;
alfa = 0.5;
a3=zeros(N+1,1);
a3(1) = 1;
a3(N+1) = alfa;
soundsc(a3);
figure(8)
freqz(b3,a3);

[y2,Fs2] = audioread('audio1_lab.wav');
sound(y2)
h3=filter(b3,a3,y2);
%h3 = [h3' , zeros(1,400000)];
sound(h3)

%%
% Experimente também com N = 50. Descreva as suas observações para cada valor
% de N. Altere o valor de α para 0; 0,25; 0,75; 1; 1,75 e verifique o que acontece.
% Que filtro é esse?
i=0;
for alfa = 0:0.25:1.75
    disp(alfa)

    b3=1;
    N = 2000;
    a3=zeros(N+1,1);
    a3(1) = 1;
    a3(N+1) = alfa;
    %soundsc(a3);
    figure(9+i)
    freqz(b3,a3);

    [y2,Fs2] = audioread('audio1_lab.wav');
    %sound(y2)
    h3=filter(b3,a3,y2);
    sound(h3)
    i=i+1;
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