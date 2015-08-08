function [phi, theta, ro] = polarization2normals(imgdataset, datasize, n)
%Calculates the degree of polarization, zenith and azimuth angles from
%dataset of images taken with different angle of polarizer

%profile on
% warning('off','all')
% warning
% opts = statset('nlinfit');
% opts.RobustWgtFun = 'bisquare';
[ymax, xmax, imax] = size(imgdataset);
I = zeros(ymax,xmax);
ro = zeros(ymax,xmax);
phi = zeros(ymax,xmax);
theta = zeros(ymax,xmax);
B = zeros(imax,3);
xvals = zeros(imax,1);
for i = 1:imax
    xvals(i) = (datasize/180)*3.14159265*(i-1)/imax;
end
% syms th
for y=1:ymax
%     disp(y);
    for x=1:xmax
        if (y==268)&&(x==57)
            y=268;
        end
        yvals = zeros(1,imax);
        for i = 1:imax
            yvals(1,i) = imgdataset(y,x,i);
            B(i,:) = [1; cos(2*xvals(i)); sin(2*xvals(i))];
        end
%         beta = nlinfit(xvals, yvals, @(b,xvals)(b(1).*cos(b(2).*xvals + b(3))+ b(4)), [1;2;1;1], opts);
%         beta1 = fit(xvals',yvals',@(b1,b2,b3,b4,x)(b1*cos(b2*x + b3)+ b4));
%         I(y,x) = beta(4) * 2;
%         ro(y,x) = beta(1)/beta(4);
%         phi(y,x) = -beta(3)/2;
%         solth = 0;
%         I(y,x) = beta1.b4 * 2;
%         ro(y,x) = beta1.b1/beta1.b4;
%         phi(y,x) = -beta1.b3/2;
        solth = 0;
        if (norm(yvals,1)==0)
            ro(y,x) = 0;
            theta(y,x) = 0;
            phi(y,x) = 0;
            continue;
        end
        x1 = B\(yvals');
        I(y,x) = 2*x1(1);
        ro(y,x) = (2*((x1(2))^2 + (x1(3))^2)^(1/2))/I(y,x);
        r = ro(y,x);
        if (x1(2)>0) && (x1(3)>=0)
                phi(y,x) = atan(x1(3)/x1(2))/2;
        elseif (x1(2)<0) && (x1(3)>=0)
                phi(y,x) = atan(x1(3)/x1(2))/2 + 1.570796;
        elseif (x1(2)>0) && (x1(3)<=0)
                phi(y,x) = atan(x1(3)/x1(2))/2;
        elseif (x1(2)<0) && (x1(3)<=0)
                phi(y,x) = atan(x1(3)/x1(2))/2 - 1.570796;
        else
            phi(y,x) = 0;
        end
        if (r>0) && (r<0.6)
            % solth1 = vpasolve(((n-1/n)^2*(sin(th))^2)/(2+2*n^2-(n+1/n)^2*(sin(th))^2 + 4*cos(th)*(n^2-(sin(th))^2)^(1/2))==r,th, [0,1.6]);
            alpha = (n-1/n)^2+r*(n+1/n)^2;
            bb = 4*r*(n^2+1)*(alpha-4*r);
            discr = bb^2 + 16*(r)^2*(16*(r)^2-alpha^2)*(n^2-1)^2;
            temp = ((-bb - discr^(1/2))/(2*(16*(r)^2-alpha^2)))^(1/2);
            solth = asin(temp);
        end
        theta(y,x) = solth;
    end
    %profile viewer
end
