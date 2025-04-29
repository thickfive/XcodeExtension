//
//  SourceEditorCommand.swift
//  SourceEditor
//
//  Created by vvii on 2025/4/26.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommandDefinition {
    
    static var commandName: String { "Example - Source Editor Command" }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        defer {
            completionHandler(nil)
        }
        let lineIndexes = invocation.lineIndexes.reversed()
        for index in lineIndexes {
            if let line = invocation.line(at: index) {
                invocation.insertLine(at: index, with: "// \(line)")
            }
        }
    }
}
