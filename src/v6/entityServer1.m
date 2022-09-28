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
requestCount = sumRequestCount(1);
entity.utilityPerRequestCount = entity.totalUtility/requestCount;
coder.extrinsic('fprintf');
fprintf('requestCount: %d\n', requestCount);
fprintf('utility per requestCount: %d\n', entity.utilityPerRequestCount);
fprintf('ChainID: %d, u: %d , delay: %d Utility: %d, TimeStamp: %d\n', entity.ChainID, u, delay, entity.totalUtility, stampEntity());