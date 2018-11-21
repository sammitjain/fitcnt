N_vals = 3:15;
T_vals = 50:50:200;

load default_vals.mat
rule = 1;
acc_table = zeros(13,4);
kk = 1;
ll = 1;
for ii = N_vals
    ll = 1;
    for jj = T_vals
        disp([ii jj]);
        [~,~,~,acc_table(kk,ll)] = fitnt(data,K,L,type,d_range,trp,tep,crp,ii,jj,val,rule);
        ll = ll+1;
    end
    kk = kk+1;
end