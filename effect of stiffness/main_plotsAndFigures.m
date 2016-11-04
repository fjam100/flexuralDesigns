%% Draw pole-zero map
k=(1000:1:1000);
m_l=1;
m_m=1;
c=2*sqrt(k*(1/m_m+1/m_l))*(m_m*m_l)/(m_m+m_l);

P=-1000;
sys=cell(length(k),1);
for i=1:length(k)
    D(i)=-m_m*(2*sqrt((k(i)/m_m+k(i)/m_l-P/m_m))-c(i)/m_m-c(i)/m_l);
    ratio(i)=(c(i)/m_m+c(i)/m_l-D(i)/m_m)/sqrt((k(i)/m_m+k(i)/m_l-P/m_m));
    tfn=tf([k(i)/m_l],[1, c(i)/m_m+c(i)/m_l-D(i)/m_m, k(i)/m_m+k(i)/m_l-P/m_m]);
    sys{i}=tfn;
%     pzmap(sys{i});
%     hold on;
end


% To show effect of chanign k, first show the pole zero map to show how the
% settling time changes, but show how faster settling time with higher
% stiffness is offset by higher gains in bode plot