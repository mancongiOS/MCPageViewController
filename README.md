# pageLinkage

***
### key words
A simple way to show how the sliding of the page/
pageViewController,页面联动, pageLIinkage,多页面展示


***

### 属性和方法的说明
1. 设置可选属性. (可选属性的设置要写在init方法之前才可生效！！！)
```
默认为40
当设置 barHeight 为负数时候，隐藏标题栏。 实例：当有有且只有一个子页面的时候
*/
@property (nonatomic, assign) CGFloat   barHeight;
@property (nonatomic, assign) CGFloat   blockFont;            // 标题块的字体的大小  默认15
@property (nonatomic, strong) UIColor * blockColor;           // 标题块的背景颜色
@property (nonatomic, assign) BOOL      isLeftPosition;       // 当title数量少的时候，是否居左
```
2. 页面初始化 （必须实现）
```
/**
titles              : 设置标题数组
vcArray             : 设置控制器数组
blockNormalColor    : 设置按钮文字未选中状态的颜色
blockSelectedColor  : 设置按钮文字已选中状态的颜色
*/
- (void)initWithTitleArray:(NSArray *)titles vcArray:(NSArray *)vcArray blockNormalColor:(UIColor *)blockNormalColor blockSelectedColor:(UIColor *)blockSelectedColor;

```
3.  跳转到其他pageViewController的子页面 （可选）
```- (void)jumpToSubViewController:(NSInteger)index;```


### 如何使用?
1. 导入 'MCPageViewController'进自己的项目.

2. use
        创建控制器 并继承MCPageViewController.
```
在viewDidLoad方法中设置可选属性并且实现initWithTitleArray方法
NSArray * dataArray = @[@"关注",@"推荐",@"热点",@"上海",@"娱乐",@"头条",@"问答",@"科技",@"视频"];

NSMutableArray * vcArrayM = [NSMutableArray arrayWithCapacity:0];
for (int i = 0; i < dataArray.count; i ++) {
SubViewController * one = [[SubViewController alloc] init];
one.title = dataArray[i];
one.str = dataArray[i];
[vcArrayM addObject:one];

// 子页面上点击事件的处理  --> push到下个页面
__weak __typeof__(self) weakSelf = self;
one.oneBlock = ^(NSString *string, UIViewController *vc) {
vc.title = string;
[weakSelf.navigationController pushViewController:vc animated:YES];
};

// 子页面上点击事件的处理  --> 跳转到其他pageViewController的子页面
one.twoBlock = ^(int index) {
[weakSelf jumpToSubViewController:index];
};

}
self.blockFont = 14;
self.barHeight = 40;

[self initWithTitleArray:dataArray vcArray:vcArrayM blockNormalColor:[UIColor lightGrayColor] blockSelectedColor:[UIColor redColor]];
```
3. 子页面上的事件，请单独处理。子页面上没法做push跳转，一定要让pageViewController去做跳转。具体请看demo。

***
### The sample
![1](https://github.com/mancongiOS/pageLinkage/blob/master/1.png)
![2](https://github.com/mancongiOS/pageLinkage/blob/master/2.png)
