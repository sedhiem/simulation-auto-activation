delay = stampEntity() - entity.timeStampRouter1;
u = 0;
if delay == 1
    u = 10;
else
    u = 11 - delay;
end
entity.Data = u;
entity.Utility = u;
entity.totalUtility = addUtility(u);
entity.totalUtilityAtRouter1 = addUtilityAtRouter1(u);
requestCount = sumRequestCount(1);
requestCountAtRouter1 = sumRequestCountAtRouter1(1);
entity.utilityPerRequestCount = entity.totalUtility/requestCount;
entity.utilityPerRequestCountAtRouter1 = entity.totalUtilityAtRouter1/requestCountAtRouter1;
coder.extrinsic('fprintf');
fprintf('requestCount: %d\n', requestCount);
fprintf('requestCountAtRouter1: %d\n', requestCountAtRouter1);
fprintf('utility per requestCount: %d\n', entity.utilityPerRequestCount);
fprintf('utility per requestCountAtRouter1: %d\n', entity.utilityPerRequestCountAtRouter1);
fprintf('ChainID: %d, u: %d , delay: %d utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtilityAtRouter1, stampEntity());
fprintf('ChainID: %d, u: %d , delay: %d totalUtility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtility, stampEntity());