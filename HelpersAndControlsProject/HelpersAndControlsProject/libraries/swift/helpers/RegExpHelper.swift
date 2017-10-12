//
//  RegExpHelper.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 8/18/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

/// Class which provide the helping with regular expressions
public class RegExpHelper: NSObject {
    
    /// Method which provide the
    ///
    /// - Parameters:
    ///   - text: text with the item for serch
    ///   - pattern: pattern for search
    /// - Returns: founded items
    public static func search(itemsFromText text: String?, withPattern pattern: String?) -> [String] {
        var items: [String] = [];
        if let text = text, let pattern = pattern {
            let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let matches = regex.matches(in: text, range: NSMakeRange(0, text.characters.count))
            for match in matches {
                let range = match.rangeAt(0);
                let r = text.index(text.startIndex, offsetBy: range.location) ..<
                    text.index(text.startIndex, offsetBy: range.location + range.length)
                items.append(text.substring(with: r));
            }
            return items;
        }
        return items;
    }
    
    // MARK: - Create regexp functional
    
    
    /// Method which provide the create regexp from word
    ///
    /// - Parameter word: {@link String} value of the word
    /// - Returns: {@link String} value of regular expression
    public static func create(regexpFromWord word: String?) -> String? {
        var result: String? = nil;
        if let word = word {
            result = "(";
            for char in word.characters {
                let charText: String = "\(char)"
                let num = Int(charText);
                if (num != nil) {
                    result?.append("(\\d{0,})");
                } else if (charText == "."){
                    result?.append("(\\.{0,1})");
                } else if (charText == " "){
                    result?.append("(\\s{0,})");
                } else if (charText == "$"){
                    result?.append("(\\${0,1})");
                } else if (charText == ":"){
                    result?.append("(:{0,1})");
                }else if (charText == "-"){
                    result?.append("(-{0,1})");
                } else {
                    result?.append("(\(charText.uppercased())|\(charText.lowercased()))");
                }
            }
            result?.append(")");
            print("REGEXP FROM WORD: \(result ?? "")");
        }
        //    print("func create(regexpFromWord word: String?) -> \(result ?? "")");
        return result;
    }
    
    
    /// Method which provide the create regexp from words
    ///
    /// - Parameter words: {@link String} array of the words
    /// - Returns: {@link String} value of the regexp
    public static func create(regexpFromWords words: [String]?) -> String? {
        var result: String? = nil;
        if let words = words {
            var items: [String] = [];
            for word in words {
                let text = create(regexpFromWord: word);
                if let text = text {
                    items.append(text);
                }
            }
            result = items.joined(separator: "|");
        }
        //    print("func create(regexpFromWords words: [String]?) -> \(result ?? "")");
        return result;
    }


}
