N_vals = 3:8;
T_vals = 100:100:600;

load default_vals.mat
acc_table = zeros(6);
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