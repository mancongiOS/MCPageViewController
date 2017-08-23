# pageLinkage

***
##key
A simple way to show how the sliding of the page/
pageViewController,页面联动, pageLIinkage,多页面展示


***
##How to use?
1. Create a page and inheritance The 'MCPageViewController'.
2. Give the title arrays and page array to fill in the data.
```
@property (nonatomic, strong) NSArray * titleArray;           // 存放标题的数组
@property (nonatomic, strong) NSArray * vcArray;              // 控制器的数组

@property (nonatomic, strong) UIColor * barColor;             // 标题栏的背景颜色
@property (nonatomic, assign) CGFloat   barHeight;            // 标题栏的高度  默认我40

@property (nonatomic, assign) CGFloat   blockWidth;           // 标题块的宽度  默认50
@property (nonatomic, assign) CGFloat   blockFont;            // 标题块的字体的大小  默认18
@property (nonatomic, strong) UIColor * blockColor;           // 标题块的背景颜色
@property (nonatomic, strong) UIColor * blockNormalColor;     // 标题块的默认颜色
@property (nonatomic, strong) UIColor * blockSelectedColor;   // 标题块的选择颜色


@property (nonatomic, assign) NSInteger currentPage;          // 需要显示的页面  默认为第零页

// 实现自身的方法. 必须调用
- (void)achieve;
```
3. Call method '[self achieve];'


![1](https://github.com/mancongiOS/pageLinkage/blob/master/1.png)
![2](https://github.com/mancongiOS/pageLinkage/blob/master/2.png)
