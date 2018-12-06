# pageLinkage


***
### pods安装
```
platform :ios, '8.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'        #官方仓库地址

target '工程名' do
pod 'MCPageViewController'
end
```

***
### key words
A simple way to show how the sliding of the page/
pageViewController,页面联动, pageLIinkage,多页面展示

***

### 配置文件（MCPageConfig）的使用

```
// 具体请看MCPageConfig.swift的注释
@objc public var titles : [String] = [String]()
@objc public var vcs : [UIViewController] = [UIViewController]()

```
2. 页面初始化 （必须实现）
```
/**
let config = MCPageConfig.init()
config.titles = titles
config.vcs = vcArrayM as! [UIViewController]

initPagesWithConfig(config)
```
3. 自定义MCPageItem
```
// 可根据需求自行调整里面控件的位置和属性 具体请看demo
initCustomPageWithConfig(config, items: arrayM as! [UIButton])

```
4.  跳转到其他pageViewController的子页面 （可选）
```- (void)jumpToSubViewController:(NSInteger)index;```



5. 子页面上的事件，请单独处理。子页面上没法做push跳转，一定要让pageViewController去做跳转。具体请看demo。

***
### The sample
![1](https://github.com/mancongiOS/pageLinkage/blob/master/1.png)
