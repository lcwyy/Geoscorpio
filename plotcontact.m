%% plot contact information
a0 = importdata('deposit_contact_034');
a = a0.data;
b0 = importdata('deposit_particle_034');
b = b0.data;

%% particle position
Ptclid = b(:,1);
PtclX = b(:,6);
PtclY = b(:,7);
PtclZ = b(:,8);
PtclInfo = [Ptclid, PtclX, PtclY, PtclZ];

%% rose histogram plot for contacts
VecCX = a(:, 21);
VecCY = a(:, 22);
VecCZ = a(:, 23);
length = size(VecCX);
fabVecC = sqrt(VecCX.^2 + VecCY.^2 + VecCZ.^2);
angX = acos(VecCX./fabVecC);
angY = acos(VecCY./fabVecC);
angZ = acos(VecCZ./fabVecC);
angNum = zeros(1,18);
angBin = 0:10:180;
Bin = angBin*pi/180;
%%%%% yz plane
figure
fabVecYZ = sqrt(VecCY.^2 + VecCZ.^2);
angYZ = acos(VecCY./fabVecYZ);
plt1 = rose(angYZ, 36);
figure
fabVecXZ = sqrt(VecCX.^2 + VecCZ.^2);
angXZ = acos(VecCX./fabVecXZ);
plt2 = rose(angXZ, 36);
figure
fabVecXY = sqrt(VecCY.^2 + VecCX.^2);
angXY = acos(VecCX./fabVecXY);
plt3 = rose(angXY, 36);

%{
for i = 1:length
    if (angYZ(i) >= 0 && angYZ(i) < 10*pi/180)
        angNum (1) = angNum(1) + 1;
    end
    if (angYZ(i) >= 10*pi/180 && angYZ(i) < 20*pi/180)
        angNum (2) = angNum(2) + 1;
    end
    if (angYZ(i) >= 20*pi/180 && angYZ(i) < 30*pi/180)
        angNum (3) = angNum(3) + 1;
    end
    if (angYZ(i) >= 30*pi/180 && angYZ(i) < 40*pi/180)
        angNum (4) = angNum(4) + 1;
    end
    if (angYZ(i) >= 40*pi/180 && angYZ(i) < 50*pi/180)
        angNum (5) = angNum(5) + 1;
    end
    if (angYZ(i) >= 50*pi/180 && angYZ(i) < 60*pi/180)
        angNum (6) = angNum(6) + 1;
    end
    if (angYZ(i) >= 60*pi/180 && angYZ(i) < 70*pi/180)
        angNum (7) = angNum(7) + 1;
    end
    if (angYZ(i) >= 70*pi/180 && angYZ(i) < 80*pi/180)
        angNum (8) = angNum(8) + 1;
    end
    if (angYZ(i) >= 80*pi/180 && angYZ(i) < 90*pi/180)
        angNum (9) = angNum(9) + 1;
    end
    if (angYZ(i) >= 90*pi/180 && angYZ(i) < 100*pi/180)
        angNum (10) = angNum(10) + 1;
    end
    if (angYZ(i) >= 100*pi/180 && angYZ(i) < 110*pi/180)
        angNum (11) = angNum(11) + 1;
    end
    if (angYZ(i) >= 110*pi/180 && angYZ(i) < 120*pi/180)
        angNum (12) = angNum(12) + 1;
    end
    if (angYZ(i) >= 120*pi/180 && angYZ(i) < 130*pi/180)
        angNum (13) = angNum(13) + 1;
    end
    if (angYZ(i) >= 130*pi/180 && angYZ(i) < 140*pi/180)
        angNum (14) = angNum(14) + 1;
    end
    if (angYZ(i) >= 140*pi/180 && angYZ(i) < 150*pi/180)
        angNum (15) = angNum(15) + 1;
    end
    if (angYZ(i) >= 150*pi/180 && angYZ(i) < 160*pi/180)
        angNum (16) = angNum(16) + 1;
    end
    if (angYZ(i) >= 160*pi/180 && angYZ(i) < 170*pi/180)
        angNum (17) = angNum(17) + 1;
    end
    if (angYZ(i) >= 170*pi/180 && angYZ(i) < 180*pi/180)
        angNum (18) = angNum(18) + 1;
    end
end
%}

%% force chain network
fcntcinfo = fopen('deposit_contactplot.dat', 'w');
fprintf(fcntcinfo, '%s\n','TITLE = "Force chain plot"');
fprintf(fcntcinfo, '%s\n','VARIABLES = "X", "Y", "Z", "Normal Contact Force"');
NrmForce = abs(a(:,16)); %% normal contact force vector
VecID1 = a(:,1);
VecID2 = a(:,2);
figure
for i = 1:length
    fprintf(fcntcinfo, '%s\n','ZONE I=2, J=1, K=1, DATAPACKING=POINT');
    k1 = find(Ptclid == VecID1(i));
    k2 = find(Ptclid == VecID2(i));
    P1X = PtclInfo(k1,2);
    P2X = PtclInfo(k2,2);
    P1Y = PtclInfo(k1,3);
    P2Y = PtclInfo(k2,3);
    P1Z = PtclInfo(k1,4);
    P2Z = PtclInfo(k2,4);
    plot3([P1X P2X], [P1Y P2Y], [P1Z P2Z], 'r','LineWidth', NrmForce(i)/1000);
    hold on;
    fprintf(fcntcinfo, '%f%s%f%s%f%s%f\n', P1X, ' ', P1Y, ' ', P1Z, ' ', NrmForce(i));
    fprintf(fcntcinfo, '%f%s%f%s%f%s%f\n', P2X, ' ', P2Y, ' ', P2Z, ' ', NrmForce(i));
end
fclose(fcntcinfo);


