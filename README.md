#自定义TabbarPlus按钮, 自定义badgeValue背景色及文字颜色#
//  超简单使用说明: 继承CXJTabbarContoller即可

如需设置Plus按钮(仅需要实现父类方法)-(void)setPlusButton:(nonnull UIButton *)plusButton; 
如需修改badge属性可设置 self.badgeBackgroundColor 背景色 和 self.badgeTitleColor 字体颜色;

//(其它用法与原生无区别)
![Snip](https://github.com/dajun512/CXJTabbarController/blob/master/TabbarControllerImg.gif?raw=true)
