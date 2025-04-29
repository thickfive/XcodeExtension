//
//  CommandInvocation.swift
//  SourceEditor
//
//  Created by vvii on 2025/4/26.
//

import Foundation
import XcodeKit

extension XCSourceEditorCommandInvocation {
    
    var lineIndexes: [Int] {
        var lineIndexes = [Int]()
        for range in buffer.selections {
            guard let range = range as? XCSourceTextRange else {
                continue
            }
            let start = range.start
            let end = range.end
            for i in start.line...end.line {
                lineIndexes.append(i)
            }
        }
        if line(at: lineIndexes[lineIndexes.count - 1]) == nil {
            lineIndexes.removeLast()
        }
        return lineIndexes
    }
    
    func line(at index: Int) -> String? {
        if index < buffer.lines.count {
            return buffer.lines[index] as? String
        } else {
            return nil // ⌘ + A 全选会多出一行
        }
    }
    
    func addLine(_ string: String) {
        buffer.lines.add(string)
    }
    
    func replaceLine(at index: Int, with string: String) {
        buffer.lines.replaceObject(at: index, with: string)
    }
    
    func insertLine(at index: Int, with string: String, ) {
        buffer.lines.insert(string, at: index)
    }
    
    func removeLine(at index: Int) {
        buffer.lines.removeObject(at: index)
    }
    
    func removeLastLine() {
        buffer.lines.removeLastObject()
    }
}
