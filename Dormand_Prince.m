%         Programa DOPRI
% Programa para resolver um PVI pelo metodo de Dormand-Prince
% Parametros de entrada : A , B , M , Y0
% Limite inferior ,limite superior, numero de subintervalos e valor inicial
% Parametros de saida : VetX, VetY , EG
% Abscissas , solucao do PVI e erro global
%           { DECLARAR VARIAVEIS }
% declare I , M inteiro
% declare Y0 , A , B , H , X , Xt , Y , Yt , Fxy , 
%         E2 , K1 , K2 , K3 , K4 , K5 , K6 , K7 , ErroGlobal , 
%         A21 , A31 , A32 , A41 , A42 , A43 , A51 , A52 , A53 , A54 ,
%         A61 , A62 , A63 , A64 , A65 , A71 , A73 , A74 , A75 , A76 , 
%         C2 , C3 , C4 , C5 , C6 , C7 , E1 , E3 , E4 , E5 , E6 , E7   real
% declare VetX[1:M+1] , VetY[1:M+1] , EG[1:M+1]  real
clear all; close all; clc
syms x y
%           { ENTRADA DE DADOS }
f = input('Expressao da derivada da fun��o PVI em linguagem MATLAB = x-2*y+1  :');
f = inline(f);
a = input('Entre com o limite inferior=  0   : ');
b = input('Entre com o limite superior =  1 : ');
m = input('Entre com o numero de subintervalos  10 : ');
y_0 = input('Entre com o valor inicial = 1 : ');
% Saida dos dados informados
clc
disp('Os parametros de entrada');
disp(['a = ' num2str(a)]);
disp(['b = ' num2str(b)]);
disp(['m = ' num2str(m)]);
disp(['y_0 = ' num2str(y_0)]);
%
%           { INICIAR VARIAVEIS }
%  
a21 = 1/5; a31 = 3/40; a32 = 9/40; a41 = 44/45; a42 = -56/15; a43 = 32/9;
a51 = 19372/6561; a52 = -25360/2187; a53 = 64448/6561; a54 = -212/729;
a61 = 9017/3168; a62 = -355/33; a63 = 46732/5247; a64 = 49/176; a65 = -5103/18656; 
a71 = 35/384; a73 = 500/1113; a74 = 125/192; a75 = -2187/6784; a76 = 11/84;
C2 = 1/5; C3 = 3/10; C4 = 4/5; C5 = 8/9; C6 = 1; C7 = 1;
E1 = 71/57600; E3 = -71/16695; E4 = 71/1920; E5 = -17253/339200; 
E6 = 22/525; E7 = -1/40;
%
VetX = zeros (1,m+1);
VetY = zeros (1,m+1);
EG = zeros (1,m+1);
h = (b - a) / m; 
xt = a;
yt = y_0;
VetX(1) = xt;
VetY(1) = yt;
EG(1) = 0;
fprintf('  Metodo de Dormand-Prince \n');
fprintf(' i \t\t   x \t\t  y \t\t Erro \n');
fprintf('%2i \t %10.5f %10.5f \n',i,xt,yt);
%
%           { EFETUANDO CALCULO }
%
i = 0;
for i = 1:m
    x = xt;
    y = yt;
    K1 = h * (fevAl(f,x,y));  % { AvAliAr f(x , y) }
    %
    x = xt + C2 * h;
    y = yt + a21 * K1;
    K2 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    x = xt + C3 * h;
    y = yt + a31 * K1 + a32 * K2;
    K3 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    x = xt + C4 * h;
    y = yt + a41 * K1 + a42 * K2 + a43 * K3;
    K4 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    x = xt + C5 * h;
    y = yt + a51 * K1 + a52 * K2 + a53 * K3 + a54 * K4;
    K5 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    x = xt + C6 * h;
    y = yt + a61 * K1 + a62 * K2 + a63 * K3 + a64 * K4 + a65 * K5;
    K6 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    x = xt + C7 * h;
    y = yt + a71 * K1 + a73 * K3 + a74 * K4 + a75 * K5 + a76 * K6;
    K7 = h * (feval(f,x,y));  % { avaliar f(x , y) }
    %
    xt = a + i * h;
    yt = yt + a71 * K1 + a73 * K3 + a74 * K4 + a75 * K5 + a76 * K6;
    erro_global = E1 * K1 + E3 * K3 + E4 * K4 + E5 * K5 + E6 * K6 + E7 * K7;
    %
    Vetx(i + 1) = xt;  % { abscissa }
    Vety(i + 1) = yt;  % { solu��o PVi }
    EG(i + 1) = erro_global;  % { erro cometido }
    %
    fprintf('%2i \t %10.5f %10.5f %15.3e \n',i,xt,yt,erro_global);
end  % { i }
%
%Fim do programa