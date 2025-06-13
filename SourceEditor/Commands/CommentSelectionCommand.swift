//
//  CommentSelectionCommand.swift
//  SourceEditor
//
//  Created by vvii on 2025/4/26.
//

import Foundation
import XcodeKit

class CommentSelectionCommand: NSObject, XCSourceEditorCommandDefinition {
    
    static var commandName: String { "Comment Selection" }
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping ((any Error)?) -> Void) {
        defer {
            completionHandler(nil)
        }
        
        CommentSymbol.shared.contentUTI = invocation.buffer.contentUTI
        
        if let position = commentPosition(invocation: invocation) {
            addComment(at: position, invocation: invocation)
        } else {
            removeComment(invocation: invocation)
        }
    }
    
    func commentPosition(invocation: XCSourceEditorCommandInvocation) -> Int? {
        var position = Int.max
        var commentedLines = 0
        let lineIndexes = invocation.lineIndexes
        for index in lineIndexes {
            if let line = invocation.line(at: index) {
                let trimed = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                if trimed.hasPrefix(CommentSymbol.symbol) {
                    commentedLines += 1
                }
                var count = 0
                let chars = Array(line)
                for i in 0..<chars.count {
                    if chars[i] == Character(CommentSymbol.space) { // fix: Character("\n").isWhitespace == true
                        count += 1
                    } else {
                        break
                    }
                }
                position = min(position, count)
            }
        }
        return commentedLines < lineIndexes.count ? position : nil
    }
    
    func addComment(at position: Int, invocation: XCSourceEditorCommandInvocation) {
        let lineIndexes = invocation.lineIndexes
        for index in lineIndexes {
            if let line = invocation.line(at: index) {
                var chars = Array(line)
                chars.insert(contentsOf: Array(CommentSymbol.symbol + CommentSymbol.space), at: position)
                invocation.replaceLine(at: index, with: String(chars))
            }
        }
        invocation.resetSelections()
    }
    
    func removeComment(invocation: XCSourceEditorCommandInvocation) {
        let lineIndexes = invocation.lineIndexes
        for index in lineIndexes {
            if var line = invocation.line(at: index) {
                if let range = line.firstRange(of: Array(CommentSymbol.symbol)) {
                    line.removeSubrange(range)
                }
                if let range = line.firstRange(of: Array(CommentSymbol.space)) { // fix: 部分注释不包含空格, 需要分开移除
                    line.removeSubrange(range)
                }
                invocation.replaceLine(at: index, with: line)
            }
        }
        invocation.resetSelections()
    }
}


class CommentSymbol {
    static let shared = CommentSymbol()
    var contentUTI: String = ""
    
    static var symbol: String {
        switch shared.contentUTI {
        case "public.python-script", "public.shell-script", "public.perl-script", "public.ruby-script":
            return "#"
        default:
            return "//"
        }
    }
    
    static var space: String {
        return " "
    }
}

