% check fish length from coor
function len_swimbout = len_from_coor(coor_swimbout)

nframes = size(coor_swimbout,3);
len_swimbout = zeros(nframes,1);

for n = 1:nframes
    coor = coor_swimbout(:,:,n);
    dcoor = coor(:,1:9,:)-coor(:,2:10);
    len = sum(sum(dcoor.^2).^0.5);
    len_swimbout(n,:) = len;
end