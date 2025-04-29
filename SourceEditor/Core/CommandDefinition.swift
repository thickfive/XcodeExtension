//
//  CommandDefination.swift
//  SourceEditor
//
//  Created by vvii on 2025/4/26.
//

import Foundation
import XcodeKit

protocol XCSourceEditorCommandDefinition: NSObjectProtocol, XCSourceEditorCommand {
    
    /// for XCSourceEditorCommandDefinitionKey.identifierKey
    static var commandIdentifier: String { get }
    
    /// for XCSourceEditorCommandDefinitionKey.nameKey
    static var commandName: String { get }
    
    /// for XCSourceEditorCommandDefinitionKey.classNameKey
    static var commandClassName: String { get }
    
    /// XCSourceEditorCommandDefinition
    static var commandDefinition: [XCSourceEditorCommandDefinitionKey: Any] { get }
}

extension XCSourceEditorCommandDefinition {
    
    static var commandIdentifier: String {
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""
        let commandName = commandName.replacingOccurrences(of: " ", with: "-").lowercased()
        return "\(bundleIdentifier).\(commandName)"
    }
    
    /// 唯一需要设置的就是命令名称, 其他的定义都可以自动生成
    static var commandName: String {
        fatalError("Need to set `commandName` of `\(self)`")
    }
    
    static var commandClassName: String {
        NSStringFromClass(self)
    }
    
    static var commandDefinition: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .identifierKey: commandIdentifier,
            .nameKey: commandName,
            .classNameKey: commandClassName
        ]
    }
}
