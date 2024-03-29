# v6 について

## ネットワーク内の要素

|       | Consumer | Router | Producer |
| ----- | -------- | ------ | -------- |
| Count | 3        | 3      | 1        |

![v6のネットワーク](/src/public/image/v2/nw.png "v6のネットワーク")

## Consumer の周期

|        | Consumer1 | Consumer2 | Consumer3 |
| ------ | --------- | --------- | --------- |
| Period | 15        | 12        | 7         |

## Function 実行時間

|       | Router1 | Router2 | Router3 |
| ----- | ------- | ------- | ------- |
| Delay | 2       | 4       | 7       |

## Consumer の遅延（位相）

|        | Consumer1 | Consumer2 | Consumer3 |
| ------ | --------- | --------- | --------- |
| Period | 1         | 2         | 3         |

## 特徴

- 2 つの擬似コンシューマは提案手法
- 1 つの擬似コンシューマはランダムな起動周期
- 新たな要素として、擬似Consumerそれぞれに対する総リクエストと総utilityを持たせるようにする
