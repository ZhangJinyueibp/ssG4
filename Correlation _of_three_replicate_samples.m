data=importdata('result3.rep1_rep2_rep3.selectPart.txt');
rep1=log10(data(:,1)+1);
rep2=log10(data(:,2)+1);
rep3=log10(data(:,3)+1);
zero=log10(data(:,4)+1);

plot3(rep1,rep2,zero,'r.')
hold on
plot3(rep1,zero,rep3,'g.')
plot3(zero,rep2,rep3,'b.')
plot3(rep1,rep2,rep3,'k.')


data=importdata('result3.rep1_rep2_rep3.txt');
rep1=log10(data(:,1)+1);
rep2=log10(data(:,2)+1);
rep3=log10(data(:,3)+1);
corr(rep1,rep2)
corr(rep1,rep3)
corr(rep2,rep3)

