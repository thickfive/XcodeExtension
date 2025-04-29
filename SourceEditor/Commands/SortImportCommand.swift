//
//  SortImportCommand.swift
//  SourceEditor
//
//  Created by vvii on 2025/4/26.
//

import Foundation
import XcodeKit

class SortImportCommand: NSObject, XCSourceEditorCommandDefinition {
    
    static var commandName: String { "Sort Import" }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping ((any Error)?) -> Void) {
        defer {
            completionHandler(nil)
        }
        var importLines = 0
        let lineIndexes = invocation.lineIndexes
        for index in lineIndexes {
            if let line = invocation.line(at: index) {
                let trimed = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                // import or #import
                if trimed.contains("import") || trimed.isEmpty {
                    importLines += 1
                } else {
                    break
                }
            }
        }
        if importLines == lineIndexes.count {
            let lines = lineIndexes.map({ invocation.line(at: $0) ?? "" }).sorted(by: { $0 < $1 })
            for i in 0..<lineIndexes.count {
                invocation.replaceLine(at: lineIndexes[i], with: lines[i])
            }
        }
    }
}
