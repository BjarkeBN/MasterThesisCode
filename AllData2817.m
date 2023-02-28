s = struct;
terval = 1;
sse = s.sse;
ne = s.ne(sse<1.25);
ter = Te_err(sse<1.25);
ne = ne(ter < terval);
Te = s.Te(sse<1.25);
Te = Te(ter < terval);
vf = s.vf(sse<1.25);
vf = vf(ter < terval);
t = s.times(sse<1.25);
t = t(ter < terval);
net = s.ne_err(sse<1.25);
net = net(ter < terval);

s2817c=figure;
s = stackedplot(t,[ne,Te,vf],'.');
s.XLabel = 'Time [ms]';
s.Title = 'Fitted parameters, Shot 2817';
s.DisplayLabels={'Density [m⁻³]','Temperature [Te]','Floating potential [V]'};
s.GridVisible = 'on';
%2817c
exportgraphics(s2817c, '2817c.pdf', 'ContentType', 'vector'); 
