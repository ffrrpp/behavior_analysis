% pdf from 2D data

function [PPDF,XX,YY,Xrange,Yrange,cdata,N,D] = pdf_from_2d(pt,color,rr)

Border = 0.6;
Sigma = 0.2;
stepSize = 0.1;
if rr < 1
    Border = 0;
end

X = pt(:,1)';  
Y = pt(:,2)';
D = [X' Y'];
N = length(X);
Xrange = [min(X)-Border max(X)+Border];
Yrange = [min(Y)-Border max(Y)+Border];

%Setup coordinate grid
[XX,YY] = meshgrid(Xrange(1):stepSize:Xrange(2), Yrange(1):stepSize:Yrange(2));
YY = flipud(YY);

%Parzen parameters and function handle
pf1 = @(C1,C2) (1/N)*(1/((2*pi)*Sigma^2)).*...
         exp(-( (C1(1)-C2(1))^2+ (C1(2)-C2(2))^2)/(2*Sigma^2));

PPDF = zeros(size(XX));    

%Populate coordinate surface
[R,C] = size(PPDF);
% NN = length(D);
for c=1:C
   for r=1:R 
       for d=1:N 
            PPDF(r,c) = PPDF(r,c) + ...
                pf1([XX(1,c) YY(r,1)],[D(d,1) D(d,2)]); 
       end
   end
end

%Normalize data
m1 = max(PPDF(:));
PPDF = PPDF / m1;

% get rid of outliers
bw_PPDF = im2bw(PPDF,1/sqrt(N));
SE = strel('sphere',5);
bw2_PPDF = imdilate(bw_PPDF,SE);
PPDF = PPDF.*bw2_PPDF;

c_white = ones([size(PPDF),3]);
c_color = cat(3,ones(size(PPDF))*color(1),ones(size(PPDF))*color(2),ones(size(PPDF))*color(3));
cdata = c_white + (1-(1-repmat(PPDF,1,1,3)).^(N^(1/3))).*(c_color-c_white);
PPDF = (1-(1-PPDF).^(N^(rr/3)));