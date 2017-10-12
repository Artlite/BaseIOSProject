//
//  RandomHelper.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 8/11/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

/// Helper which provide the random functional
public class RandomHelper: NSObject {
    
    /// Method which provide the generating of the random string
    ///
    /// - Parameter length: length for the random string
    /// - Returns: random string value
    public static func random(stringWithLenght length: Int) -> String {
        return random(stringWithLenght: length, needOnlyLetters: false);
    }
    
    
    /// Method which provide the generating of the random string
    ///
    /// - Parameter length: length for the random string
    /// - Returns: random string value
    public static func random(stringWithLenght length: Int, needOnlyLetters isOnlyLetters: Bool) -> String {
        let letters : NSString = (isOnlyLetters == true) ? "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789QWERTYUIOPASDFGHJKLZXCVBNM" : "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789QWERTYUIOPASDFGHJKLZXCVBNM<>?±!@#$%^&*()_+{}:|";
        let len = UInt32(letters.length);
        var randomString = "";
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len);
            var nextChar = letters.character(at: Int(rand));
            randomString += NSString(characters: &nextChar, length: 1) as String;
        }
        return randomString;
    }
    
    /// Method which provide the generating of the random integer value
    ///
    /// - Parameters:
    ///   - start: {@link Int} value of the start range
    ///   - end: {@link Int} value of the end range
    /// - Returns: {@link Int} value of the generated number
    public static func random(integerFromStart start: Int, andEnd end: Int) -> Int {
        let lower : UInt32 = UInt32(start);
        let upper : UInt32 = UInt32(end);
        let randomNumber = arc4random_uniform(upper - lower) + lower;
        return Int(randomNumber);
    }

}
