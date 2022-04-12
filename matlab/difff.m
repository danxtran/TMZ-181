function diff_err_energy = difff(data0, data1, Title0, Title1, option)
% Plots two complex functions, their difference and ratio; plus a few 
% other stats like max min of the difference and ratio, and SNR.
%
%    difff(datain, dataout);
%    difff(datain, dataout,  Title0, Title1);
%    difff(datain, dataout,  Title0, Title1, 1);	% real data only
%    DiffErrEnergy = difff(data0, data1, Title0, Title1)
%	data0, data1	Complex data vectors
%	Title0, Title1	Character string names used in graph titles for
%			the two data vectors.
%	option 1	Compare only *real* portions of input data

% 2020/03/16  Added example exercising code
% 2006/03/11  Inverted dB calculation ratio so output is positive (SNR)
% 2001/06/20  Added optional diff_err_energy output
% 2001/04/11  Added option=1 for real-only input data
% 2001/01/02  Fixed separated mean part to remove 'Rank deficient' error
% 2000/06/07  Added Title0 and Title1 arguments.
% 2000/05/23  Added check for log(0)
%           Sped up calculation of Energy (oops, should've done it before)
%           Sped up plotting of ratio (oops, should've done it before)
% 2000/05/19  Added mean of ratio; needs work for when data1 == 0
% 2000/04/06  Added energy, SNR 
% 2000/01/28  Added plot of data0-data1
%           I can't get rid of that crazy "Warning:...axis limit..." message
%           that shows up sometimes!  axis([...]) arguments are fine!  Grr.
% 1999/12/17  Cleaned up ratio stuff when undefined
% 1999/12/10  Written
%
%--- Example code to exercise this function:
% clear;
% len     = 200;
% freq    = 5;
% noise_mag = 1/20;
% 
% t       = 0:len-1;
% a       = sin(freq*2*pi*t/200);
% noise   = (rand(1,len) - 0.5) * noise_mag;
% b       = a + noise;
% c       = a * 0.70;
% 
% figure(1); clf;
% plot(t, a);
% axis([0 len-1 -1.1 1.1]); grid on;
% 
% figure(2); clf;
% plot(t, b);
% axis([0 len-1 -1.1 1.1]); grid on;
% 
% figure(3); clf;
% plot(t, c);
% axis([0 len-1 -1.1 1.1]); grid on;
% 
% figure(4); clf;
% difff(a,b);
% 
% figure(5); clf;
% difff(a,c);
%
%--- Example text output:
%   >> difff(fft(in), out)
%   max(data0-data1) =  -0.000100 +0.000000i =  -1e-04 +0i
%   min(data0-data1) =  -0.000100 +0.000000i =  -0.0001 +0i
%   max(data0/data1) = -Inf -Infi
%   min(data0/data1) = +Inf +Infi
%   approx separated mean(data0/data1) = +0.984368+ +1.000000i
%   Energy_data0 = 174784.000000
%   Energy_diff  = 0.000021
%   Energy_diff/Energy_data0 = 0.000000 = 94.363217dB
%   >> 


%--- Check inputs
if (length(data0) ~= length(data1))
   fprintf('Warning: difff(): data0 and data1 are different lengths\n');
end

% Set default titles if needed
if (nargin == 2)
   Title0 = 'data 0';
   Title1 = 'data 1';
end

if (nargin == 3)
   Title1 = 'data 1';
end

if (nargin == 5)
   if (option ~= 1)
      fprintf('Error: difff(): Illegal option value\n');
      return;
      end
else
   option = 0;
end

%--- Init
% Resize inputs if they're of different lengths
len0 = length(data0);
len1 = length(data1);
if len0 == len1
   len = len0;
else
   len = min(length(data0), length(data1));
   temp = data0;  clear data0;  data0 = temp(1:len);
   temp = data1;  clear data1;  data1 = temp(1:len);
   clear temp;
end

min_r = +inf;
min_i = +inf;
max_r = -inf;
max_i = -inf;

clf;

%--- Calculate stuff
errR 	= real(data0)-real(data1);
errI 	= imag(data0)-imag(data1);
err  	= data0-data1;
if (option ~= 1)		% complex data
   Energy_data0 = sum(abs(data0.^2));
   Energy_diff  = sum(abs(err.^2));
else				% real-only data
   Energy_data0 = sum(abs(real(data0).^2));
   Energy_diff  = sum(abs(real(err).^2));
end

%--- plot data0
subplot(4,1,1);
plot(0:len-1, real(data0), 'r'); hold on;
if (option ~= 1)
plot(0:len-1, imag(data0), 'b');  end
axis tight; grid on; title(Title0);

%--- plot data1
subplot(4,1,2);
plot(0:len-1, real(data1), 'r'); hold on;
if (option ~= 1)
plot(0:len-1, imag(data1), 'b');  end
axis tight; grid on; title(Title1);

%--- plot difference
subplot(4,1,3);
plot(0:len-1, errR, 'rx'); hold on;
if (option ~= 1)
plot(0:len-1, errI, 'bo');  end
axis tight; grid on; title(strcat('(', Title0, ') - (', Title1, ')'));

%--- plot ratio
subplot(4,1,4);
%for j=1:len,
%   if real(data1(j)) ~= 0   % Real part
%      ratio = real(data0(j))/real(data1(j));
%      plot(j-1, ratio, 'rx');
%      if ratio < min_r  min_r = ratio; end
%      if ratio > max_r  max_r = ratio; end
%      if j == 1 hold on;  end
%   end
%   if imag(data1(j)) ~= 0   % Imag part
%      ratio = imag(data0(j))/imag(data1(j));
%      plot(j-1, ratio, 'bo');
%      if ratio < min_i  min_i = ratio; end
%      if ratio > max_i  max_i = ratio; end
%      if j == 1 hold on;  end
%   end
%end

% Improved vectorized method
denom	= real(data1);
temp	= find(denom == 0);
denom(temp) = 1;		% temporary to do division
ratio	= real(data0)./denom;
ratio(temp) = Inf;   		% Inf when ratio==infinity
plot(0:len-1, ratio, 'rx');
hold on;

if (option ~= 1)
   denom	= imag(data1);
   temp	= find(denom == 0);
   denom(temp) = 1;		% temporary to do division
   ratio	= imag(data0)./denom;
   ratio(temp) = Inf;   		% Inf when ratio==infinity
   plot(0:len-1, ratio, 'bo');
   end

%axis([0 len-1 min(min_r, min_i)/1.05 max(max_r, max_i)*1.05]);
axis tight; 
grid on;
title(strcat('(', Title0, ') \div (', Title1, ...
   '); Points not plotted if ratio is \infty'));

%----- Print some stats
fprintf('max(data0-data1) = ');
fprintf(' %+f',     max(real(data0)-real(data1)));
fprintf(' %+fi = ', max(imag(data0)-imag(data1)));
fprintf(' %+g',     max(real(data0)-real(data1)));
fprintf(' %+gi\n',  max(imag(data0)-imag(data1)));
fprintf('min(data0-data1) = ');
fprintf(' %+f',     min(real(data0)-real(data1)));
fprintf(' %+fi = ', min(imag(data0)-imag(data1)));
fprintf(' %+g',     min(real(data0)-real(data1)));
fprintf(' %+gi\n',  min(imag(data0)-imag(data1)));

fprintf('max(data0/data1) = %+f', max_r);
fprintf(' %+fi\n', max_i);
fprintf('min(data0/data1) = %+f', min_r);
fprintf(' %+fi\n', min_i);

numer		= real(data0);
denom		= real(data1);
temp		= find(denom == 0);
denom(temp)	= 1;		% temporary to do division
ratio		= numer ./ denom;
ratio(temp)	= 0;		% introduces error, should remove sample
fprintf('approx separated mean(data0/data1) = %+f', mean(ratio));
numer		= imag(data0);
denom		= imag(data1);
temp		= find(denom == 0);
denom(temp)	= 1;		% temporary to do division
ratio		= numer ./ denom;
ratio(temp)	= 0;		% introduces error, should remove sample
fprintf('+ %+fi\n', mean(ratio));

%----- Print more stats: energy, SNR
fprintf('Energy_data0 = %f\n', Energy_data0);
fprintf('Energy_diff  = %f\n', Energy_diff);
if Energy_diff ~= 0
   fprintf('Energy_data0/Energy_diff = %f', Energy_data0/Energy_diff);
   fprintf(' = %fdB', 10*log10(Energy_data0/Energy_diff));
   fprintf('\n');  
   end

%----- Return
if (nargout == 1)
   diff_err_energy = Energy_diff;
end

