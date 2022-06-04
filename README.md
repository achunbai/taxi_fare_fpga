# 这是一个数字系统设计（EDA）课程的大作业

设计要求如下：

​    1、设计一个出租车自动计费器，具有行车里程计费、等候时间计费、及起价三部分，用四位数码管显示总金额，最大值为99.99元；

​    2、行车里程单价1元/公里，等候时间单价0.5元/10分钟，起价3元（3公里起价）均能通过人工输入（使用BCD码输入）；

​    3、行车里程的计费电路将汽车行驶的里程数转换成与之成正比的脉冲数，然后由计数译码电路转换成收费金额，实验中以一个脉冲模拟汽车前进十米，则每100个脉冲表示1公里，然后用BCD码比例乘法器将里程脉冲乘以每公里单价的比例系数，每脉冲的价格可由开关预置。例如单价是1元/公里，则脉冲当量为0.01元/脉冲；

​    4、用四个数码管显示行驶公里数，两个数码管显示收费金额。

疫情原因没有拿到开发版，所以本次课程设计的要求只需要仿真通过即可。

# 主要功能模块



| 模块          | 功能                                      |
| ------------- | ----------------------------------------- |
| freq_div      | 分频模块，将50Mhz时钟分成分钟脉冲输出     |
| distance_fare | 计算里程价格和里程模块，采用BCD码输出结果 |
| wait_fare     | 计算时长价，以BCD码形式输出               |
|fare_total|计算总价格，若到了99.99，则停止|
| seg_disp      | 将总价和里程在数码管上显示                |

