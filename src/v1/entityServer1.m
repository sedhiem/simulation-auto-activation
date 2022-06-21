delay = stampEntity() - entity.TimeStamp2;
u = 0;
if delay < 5
    u = 10;
elseif delay < 10
    u = 10 - delay;
end
entity.Data = u;
utility = addUtility(u);
entity.Utility = utility;
coder.extrinsic('fprintf');
fprintf('ChainID: %d, u: %d , delay: %d Utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, utility, stampEntity());