# TTCircularLoadingView

A circular loading view, can set up success or fail state.<br>
一个圆形的加载view，可以设置成功或失败的状态。<br><br>

Wide and high optional Settings, circular loading view will automatically match.<br>
宽高随意设置，圆形加载view会自动适配。


# GIF视图
![image](https://github.com/xushixun16/TTCircularLoadingView/blob/master/loadingView.gif)

# 使用
## 1.代码使用：
```
CGRect yourRect;
TTLoadingView *loadingView = [[TTLoadingView alloc] initWithFrame:yourRect];
[self.view addSubview:loadingView];
[loadingView startLoading];
```

## 2.Xib使用：
拉个系统View，将该View的class配置成TTLoadingView即可。
