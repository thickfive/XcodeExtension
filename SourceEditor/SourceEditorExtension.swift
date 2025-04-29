// 
//  SourceEditorExtension.swift
//  SourceEditor
// 
//  Created by vvii on 2025/4/26.
// 

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
        print("⭐️", #function)
    }
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        // 注意 classNameKey 需要带上模块名 "SourceEditor.SourceEditorCommand"
        return [
            SourceEditorCommand.commandDefinition,
            CommentSelectionCommand.commandDefinition,
            SortImportCommand.commandDefinition
        ]
    }    
}
