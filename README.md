# Xcode Source Editor Extension  

## 基本用法
[WWDC2016之初识Xcode Source Editor Extension](https://wuwen1030.github.io/2016/06/23/WWDC2016%E4%B9%8B%E5%88%9D%E8%AF%86Xcode-Source-Editor-Extension/)  
[Xcode Source Editor Extension Tutorial: Getting Started](https://www.vadimbulavin.com/xcode-source-editor-extension-tutorial/)  

Xcode 更新之后, 根据上面的教程, 代码可以运行但是 Xcode Editor 菜单里面啥也不显示

## 解决方案
[Xcode Extension isn't show up in the Editor menu](https://developer.apple.com/forums/thread/750811?answerId=786487022#786487022)

> There was a ‘recent’ change in the way that Xcode editor extensions should be built [1], and it seems that the Xcode template hasn’t caught up with that change (r. 59274389). So, to fix your problem, do this:
> 1. In the Project navigator, select your project on the left.
> 2. In the project editor, select your extension target.
> 3. In the General tab, scroll down to Frameworks and Libraries.
> 4. Find the XcodeKit.framework entry.
> 5. Change the Embed setting from Do Not Embed to Embed & Sign.
>> Minho-Park OP Apr 24  
>> Wow, I resolved it. I must set Signing team and Certificate properly. If it is None or Sign to Run Locally, isn't show up. Thank you

## 总结 
### 项目设置
- Xcode Version 16.3 (16E140), macOS 15.4.1 (24E263)
1. 新建项目 Project - `macOS` - `App`
2. 在项目里面新建 Target - `Xcode Source Editor Extension`
3. 主项目和 Extension 的 `Signing Certificate` 都选择 `Development`, 不能选 `Sign to Run Locally`
4. `XcodeKit.framework` 改为 `Embed & Sign`

### 调试
- `SourceEditorExtension` 里 `func extensionDidFinishLaunching()` 随便打印一些信息 
- 运行 Extension, Choose an app to run 选择 `Xcode`, 这样就看打开一个新的图标颜色不一样的 Xcode. 如果运行后能看到输出, 就说明创建成功了
- 在打开的 Xcode 里面顶部菜单 `Editor` 拉到最底下, 就可以看到新增的选项
- 在 `Xcode - Settings - Key Bingdings` 搜索, 设置需要绑定的快捷键, 注意不要与其他快捷键冲突即可

### 系统设置
在 `系统设置 - 登录项与扩展 - 扩展 - Xcode Source Editor` 里面打开需要开启的扩展, 不同版本的系统位置会不一样, 找到对应的即可

## 其他问题
1. 通过下载应用安装应用安装到 `应用程序` 目录的扩展, 直接删除应用(移动到废纸篓), 就能从系统设置扩展里移除
2. 通过代码直接运行的扩展, 找不到删除的地方, 会一直存在于系统设置扩展里, 重启也不行. 通过 Build 日志, 找到编译产物目录, 删除打包出来的应用即可 (如果还是不行, 需要清空废纸篓, 也就是要彻底删除) 
3. 修改 Bundle display name 不生效, 需要在导航栏左侧直接修改对应 `Target` 名称 

## 性能测试
- 大约 500 行左右就开始出现明显的卡顿, Xcode 自带的注释表现也差不多, 和 VSCode 10 万行相比简直就是个🤡
- Extension 耗费的时间并不多, 是 Xcode 自己渲染的问题
```
Example - Source Editor Command, lines: 1, time: 0.00010502338409423828
Example - Source Editor Command, lines: 2, time: 3.600120544433594e-05
Example - Source Editor Command, lines: 4, time: 6.902217864990234e-05
Example - Source Editor Command, lines: 8, time: 9.000301361083984e-05
Example - Source Editor Command, lines: 16, time: 0.00013399124145507812
Example - Source Editor Command, lines: 32, time: 0.00016605854034423828
Example - Source Editor Command, lines: 64, time: 0.00042998790740966797
Example - Source Editor Command, lines: 128, time: 0.0006719827651977539
Example - Source Editor Command, lines: 256, time: 0.0014719963073730469
Example - Source Editor Command, lines: 512, time: 0.003043055534362793
Example - Source Editor Command, lines: 1024, time: 0.0022090673446655273
Example - Source Editor Command, lines: 2048, time: 0.011175036430358887

Comment Selection, lines: 1, time: 0.00028395652770996094
Comment Selection, lines: 2, time: 0.0003910064697265625
Comment Selection, lines: 4, time: 0.00016605854034423828
Comment Selection, lines: 8, time: 0.0002720355987548828
Comment Selection, lines: 16, time: 0.00032210350036621094
Comment Selection, lines: 32, time: 0.0005909204483032227
Comment Selection, lines: 64, time: 0.0010449886322021484
Comment Selection, lines: 128, time: 0.0019589662551879883
Comment Selection, lines: 256, time: 0.0034449100494384766
Comment Selection, lines: 512, time: 0.008283019065856934
Comment Selection, lines: 1024, time: 0.009329080581665039
Comment Selection, lines: 2048, time: 0.027992963790893555
```

