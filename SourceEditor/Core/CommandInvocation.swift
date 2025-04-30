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

extension XCSourceEditorCommandInvocation {
    
    /// 重置选择范围, 避免光标出现在修改后的代码中间
    /// 否则文字变了但是光标位置不变, 造成光标相对移动的错觉
    /// 重置前: "abc|" => "// |abc", 重置后: "abc|" => "// abc|"
    func resetSelections() {
        if let first = buffer.selections.firstObject as? XCSourceTextRange,
            let last = buffer.selections.lastObject as? XCSourceTextRange {
            let newSelection = XCSourceTextRange(start: XCSourceTextPosition(line: first.start.line, column: 0),
                                                 end: XCSourceTextPosition(line: last.end.line, column: Int.max))
            buffer.selections.removeAllObjects()
            buffer.selections.add(newSelection)
        }
    }
}

