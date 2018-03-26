
% % to solve the e^t problem
% old approach
% dtheta = zeros(nsegs,nframes);
% exp_neg9to0 = exp(repmat([-9,-8,-7,-6,-5,-4,-3,-2,-1,0],nsegs,1));
% W10 = W(:,1:10);
% C10 = C(:,1:10);
% % dtheta(:,1:10) = e_term(:,1:10).^-1.*cumsum(F_m(:,1:10)./C(:,1:10).*e_term(:,1:10),2);
% 
% for n = 11:nframes
%     dtheta(:,n) = sum(F_m(:,n-9:n)./C10.*exp_neg9to0.^(W10./C10),2);
% end



% % integral solution 1
% tic
% e_term1 = exp_neg9to0.^(W10./C10)./C10;
% dtheta = zeros(nsegs,nframes);
% for i = 1:10000
%     for n = 11:nframes
%         dtheta(:,n) = sum(F_m(:,n-9:n).*e_term1,2);
%     end
% end
% toc

% solution 2
tic
C1 = C10(:,1);
W1 = W10(:,1);
e_term0 = exp(-ones(9,1)).^(W1./C1);
dtheta = zeros(nsegs,nframes);
F_m1 = F_m./C;
for i = 1:10000
    for n = 11:nframes
        dtheta(:,n) = dtheta(:,n-1).*e_term0 + F_m1(:,n);
    end
end
toc