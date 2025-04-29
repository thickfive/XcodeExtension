//
//  ContentView.swift
//  XcodeExtension
//
//  Created by vvii on 2025/4/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("安装 Xcode Extension")
                .font(.system(size: 20))
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.green, .orange, .blue]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
            Spacer().frame(height: 20)
            VStack(alignment: .leading) {
                Group {
                    Text("1. 把应用复制到 '应用程序' 目录, 打开应用")
                    Text("2. '系统设置 > 登录项与扩展 > 扩展 > Xcode Source Editor' 打开 'Xcode Extension'")
                    Text("3. 关闭应用")
                    Text("4. 去 'Xcode' 中设置绑定快捷键")
                }
                .font(.system(size: 13))
                .foregroundStyle(
                    Gradient(colors: [.black, .blue])
                )
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
