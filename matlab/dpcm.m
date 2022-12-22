predictor = [0 1]; % y(k)=x(k-1)
partition = [-1:.1:.9];
codebook = [-1:.1:1];
t = [0:pi/50:2*pi];
x = sawtooth(3*t); % Original signal
% Quantize x using DPCM.
encodedx = dpcmenco(x,codebook,partition,predictor);
% Try to recover x from the modulated signal.
decodedx = dpcmdeco(encodedx,codebook,predictor);
plot(t,x,t,decodedx,'--')
legend('Original signal','Decoded signal','Location','NorthOutside');
distor = sum((x-decodedx).^2)/length(x) % Mean square error

%%

%o último exemplo criou o preditor, a partição e o livro de códigos 
%de maneira direta, mas aleatória.

%este exemplo usa o mesmo livro de códigos (agora chamado initcodebook) 
%como uma estimativa inicial para um novo parâmetro do livro de códigos otimizado. 
%A função dpcmopt cria esses parâmetros otimizados, usando o sinal dente de serra x como dados de treinamento. 
%O exemplo prossegue para quantizar os próprios dados de treinamento; em teoria,
%os parâmetros otimizados são adequados para quantificar outros dados semelhantes a x

initcodebook = [-1:.1:1]; % Initial guess at codebook
% Optimize parameters, using initial codebook and order 1.
[predictor,codebook,partition] = dpcmopt(x,1,initcodebook);
% Quantize x using DPCM.
encodedx = dpcmenco(x,codebook,partition,predictor);
% Try to recover x from the modulated signal.
decodedx = dpcmdeco(encodedx,codebook,predictor);
plot(t,x,t,decodedx,'--')
legend('Original signal','Decoded signal','Location','NorthOutside');

distor = sum((x-decodedx).^2)/length(x) % Mean square error