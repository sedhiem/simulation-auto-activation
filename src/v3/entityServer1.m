delay = stampEntity() - entity.TimeStamp2;
u = 0;
if delay < 20
    u = 10;
elseif delay < 25
    u = 25 - delay;
end
entity.Data = u;
utility = addUtility(u);
entity.Utility = utility;
coder.extrinsic('fprintf');
fprintf('router1 ChainID: %d, u: %d , delay: %d Utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, utility, stampEntity());