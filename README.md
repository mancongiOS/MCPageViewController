# MCPageViewController
[![Version](https://img.shields.io/cocoapods/v/MCPageViewController.svg?style=flat)](https://cocoapods.org/pods/MCPageViewController)




##功能说明
* 快速构建多页面控制器
* 分类栏和内容视图完全解耦
* 支持分类栏的自定义
* 支持分类栏添加在导航栏上
* 支持分类栏滑动悬停

## 功能示例
![示例1](https://github.com/mancongiOS/MCPageViewController/blob/master/Resources/demo1.png)

![示例2](https://github.com/mancongiOS/MCPageViewController/blob/master/Resources/demo2.png)

![示例3](https://github.com/mancongiOS/MCPageViewController/blob/master/Resources/demo3.png)

![示例gif](https://github.com/mancongiOS/MCPageViewController/blob/master/Resources/demoGif.gif)

##如何使用?

```
pod 'MCPageViewController'
```

## 代码说明
###### 1.创建分类栏和内容栏
```
    /// 分类条
    lazy var categoryBar: MCCategoryBar = {
        let view = MCCategoryBar()
        view.delegate = self
        return view
    }()
    
    /// 内容容器
    lazy var containerView: MCContainerView = {
        let view = MCContainerView()
        view.delegate = self
        return view
    }()
```
###### 2. 配置属性
```
    func loadPageViewController() {
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        config.defaultIndex = 0
        config.category.maxTitleCount = 10
        
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
```
**loadPageViewController方法一定要在约束布局之前执行**
###### 3.设置约束
```
    override func initUI() {

        view.addSubview(categoryBar)
        categoryBar.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(40)
        }
        
        view.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(categoryBar.snp.bottom)
        }
    }

```
###### 4.实现分类栏和内容栏的协议
```
extension MCBasicUseViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCBasicUseViewController: MCContainerViewDelegate {
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        categoryBar.categoryBarDidClickItem(at: index)
    }
}
```



---
###### 更多的详细使用方案请下载demo示例功能。
---
## 联系Author
 QQ群： 316879774


