function w = hanning(N)

w = (1-cos(2*pi*[0:N-1]'/N))/2;