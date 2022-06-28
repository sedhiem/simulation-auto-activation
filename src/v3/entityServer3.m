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
    case 3
        if delay < 10
            u = 10 - 0.1 .* delay .^ 2;
        else
            u = 0;
        end
end
entity.Data = u;
utility = addUtility(u);
entity.Utility = utility;
coder.extrinsic('fprintf');
fprintf('router3 ChainID: %d, u: %d , delay: %d Utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, utility, stampEntity());