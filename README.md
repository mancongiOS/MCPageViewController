# pageLinkage

***
### key words
A simple way to show how the sliding of the page/
pageViewController,页面联动, pageLIinkage,多页面展示


***
### 如何使用?
1. 导入 'MCPageViewController'进自己的项目.
2. 实现init方法，并填充必要方法入参.
```
/**
titles              : 设置标题数组
vcArray             : 设置控制器数组
blockNormalColor    : 设置按钮文字未选中状态的颜色
blockSelectedColor  : 设置按钮文字已选中状态的颜色
currentPage         : 设置当前页
*/
- (void)initWithTitleArray:(NSArray *)titles vcArray:(NSArray *)vcArray blockNormalColor:(UIColor *)blockNormalColor blockSelectedColor:(UIColor *)blockSelectedColor currentPage:(NSInteger)currentPage;
```

3. 设置可选属性. (可选属性的设置要写在init方法之前才可生效！！！)
```
/** 可选
设置属性
*/

@property (nonatomic, assign) CGFloat   barHeight;            // 标题栏的高度  默认我40
@property (nonatomic, assign) CGFloat   blockFont;            // 标题块的字体的大小  默认18
@property (nonatomic, strong) UIColor * blockColor;           // 标题块的背景颜色
```

3. use
        创建控制器 并继承MCPageViewController.
```
NSMutableArray * vc = [NSMutableArray arrayWithCapacity:0];
NSMutableArray * title = [NSMutableArray arrayWithCapacity:0];
for (int i = 0; i < 15; i ++) {
SubViewController * one = [[SubViewController alloc] init];

one.str = [NSString stringWithFormat:@"第%d页",i];
[vc addObject:one];

// 子页面上点击事件的处理
__weak __typeof__(self) weakSelf = self;
one.oneBlock = ^(NSString *string, UIViewController *vc) {
vc.title = string;
[weakSelf.navigationController pushViewController:vc animated:YES];
};

[title addObject:[NSString stringWithFormat:@"第%d位",i]];
}

self.blockFont = 40;
self.barHeight = 100;
self.blockColor = [UIColor yellowColor];

[self initWithTitleArray:title vcArray:vc blockNormalColor:[UIColor lightGrayColor] blockSelectedColor:[UIColor redColor] currentPage:0];
```


***
### The sample
![1](https://github.com/mancongiOS/pageLinkage/blob/master/1.png)
![2](https://github.com/mancongiOS/pageLinkage/blob/master/2.png)
