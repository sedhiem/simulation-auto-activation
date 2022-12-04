delay = stampEntity() - entity.timeStampRouter3;
u = 0;
if delay == 1
    u = 10;
else
    u = 11 - delay;
end
entity.Data = u;
entity.Utility = u;
entity.totalUtility = addUtility(u);
entity.totalUtilityAtRouter3 = addUtilityAtRouter3(u);
requestCount = sumRequestCount(1);
requestCountAtRouter3 = sumRequestCountAtRouter3(1);
coder.extrinsic('fprintf');
fprintf('requestCount: %d\n', requestCount);
fprintf('requestCountAtRouter3: %d\n', requestCountAtRouter3);
fprintf('ChainID: %d, u: %d , delay: %d utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtilityAtRouter3, stampEntity());
fprintf('ChainID: %d, u: %d , delay: %d totalUtility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtility, stampEntity());