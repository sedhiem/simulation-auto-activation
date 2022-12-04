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
entity.utilityPerRequestCount = entity.totalUtility/requestCount;
entity.utilityPerRequestCountAtRouter3 = entity.totalUtilityAtRouter3/requestCountAtRouter3;
coder.extrinsic('fprintf');
fprintf('requestCount: %d\n', requestCount);
fprintf('requestCountAtRouter3: %d\n', requestCountAtRouter3);
fprintf('utility per requestCount: %d\n', entity.utilityPerRequestCount);
fprintf('utility per requestCountAtRouter3: %d\n', entity.utilityPerRequestCountAtRouter3);
fprintf('ChainID: %d, u: %d , delay: %d utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtilityAtRouter3, stampEntity());
fprintf('ChainID: %d, u: %d , delay: %d totalUtility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtility, stampEntity());