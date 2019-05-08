# RACDemo+MVC +MVVM +MVP

##MVVM
基本规则：
1.View持有ViewModel  反之不持有
2.ViewModel持有Model 反之不持有

MVVM 的基本概念
在MVVM 中，view 和 view controller正式联系在一起，我们把它们视为一个组件

view 和 view controller 都不能直接引用model，而是引用视图模型（viewModel）

viewModel 是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他代码的地方

使用MVVM会轻微的增加代码量，但总体上减少了代码的复杂性
 
