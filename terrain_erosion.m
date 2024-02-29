function terrain_erosion()

TERRAIN_SIZE = 512;
PEAKS_NUM = 60;
STEEPNESS = 30;

a = ones(TERRAIN_SIZE,TERRAIN_SIZE);

m_start = 60;
m_end = 420;

inner_m_start = 120;
inner_m_end = 360;

m_low = 100;
m_high = 200;

peaks = zeros(PEAKS_NUM,3);

for i = 1:PEAKS_NUM
    peaks(i,1) = randi([inner_m_start,inner_m_end]);
    peaks(i,2) = randi([1,TERRAIN_SIZE]);
    peaks(i,3) = randi([m_low,m_high])/m_high*3;
end

for i = m_start:m_end
    for j = 1:TERRAIN_SIZE
        a(i,j) = a(i,j)+sin((i-m_start)/(m_end-m_start)*2*pi-pi/2)+1;
        for k = 1:PEAKS_NUM
            a(i,j) = a(i,j)+(peaks(k,3)*STEEPNESS-min(peaks(k,3)*STEEPNESS,norm([i,j]-[peaks(k,1),peaks(k,2)])))/(peaks(k,3)*STEEPNESS)*peaks(k,3);
        end
    end
end

surf(a)
zlim([-50,50])
colormap summer
shading interp