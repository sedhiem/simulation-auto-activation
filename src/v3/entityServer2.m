delay = stampEntity() - entity.TimeStamp2;
u = 0;
switch entity.ChainID
    case 1
        if delay < 20
            u = 10;
        elseif delay < 25
            u = 25 - delay;
        end
    case 2
        if delay < 15
            u = 10;
        elseif delay < 20
            u = 20 - delay;
        end
end
entity.Data = u;
utility = addUtility(u);
entity.Utility = utility;
coder.extrinsic('fprintf');
fprintf('router2 ChainID: %d, u: %d , delay: %d Utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, utility, stampEntity());