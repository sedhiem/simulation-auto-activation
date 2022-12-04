delay = stampEntity() - entity.timeStampRouter2;
u = 0;
if delay == 1
    u = 10;
else
    u = 11 - delay;
end
entity.Data = u;
entity.Utility = u;
entity.totalUtility = addUtility(u);
entity.totalUtilityAtRouter2 = addUtilityAtRouter2(u);
requestCount = sumRequestCount(1);
requestCountAtRouter2 = sumRequestCountAtRouter2(1);
entity.utilityPerRequestCount = entity.totalUtility/requestCount;
entity.utilityPerRequestCountAtRouter2 = entity.totalUtilityAtRouter2/requestCountAtRouter2;
coder.extrinsic('fprintf');
fprintf('requestCount: %d\n', requestCount);
fprintf('requestCountAtRouter2: %d\n', requestCountAtRouter2);
fprintf('utility per requestCount: %d\n', entity.utilityPerRequestCount);
fprintf('utility per requestCountAtRouter2: %d\n', entity.utilityPerRequestCountAtRouter2);
fprintf('ChainID: %d, u: %d , delay: %d utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtilityAtRouter2, stampEntity());
fprintf('ChainID: %d, u: %d , delay: %d totalUtility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtility, stampEntity());