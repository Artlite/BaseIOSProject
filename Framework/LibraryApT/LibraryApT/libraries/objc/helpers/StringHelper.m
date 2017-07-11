//
//  StringHelper.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/9/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper
/**
 * Method which provide the checking of the empty string value
 */
+ (BOOL)isEmptyString:(NSString *)str {
  if (str.length == 0 || [str isKindOfClass:[NSNull class]] ||
      [str isEqualToString:@""] ||
      [str isEqualToString:@"(null)"] || str == nil ||
      [str isEqualToString:@"<null>"]) {
    return YES;
  }
  return NO;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the checking containing one string in another
 *
 *  @param string    full string
 *  @param subString searching substring
 *
 *  @return search value
 */
+ (BOOL)isContainString:(NSString *)string subString:(NSString *)subString {
  if ((string == nil) || (subString == nil)) {
    return NO;
  }
  if ([string rangeOfString:subString].location == NSNotFound) {
    return NO;
  } else {
    return YES;
  }
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide to removing string from substring
 *
 *  @param string   main string
 *  @param subString string which should be removed
 *
 *  @return string with removed substring
 */
+ (NSString *)removeFromString:(NSString *)string
                     subString:(NSString *)subString {

  if ((string == nil) || (subString == nil)) {
    return nil;
  }

  NSRange replaceRange =
      [string rangeOfString:[NSString stringWithFormat:@"%@,", subString]];
  if (replaceRange.location != NSNotFound) {
    return [
        [string stringByReplacingCharactersInRange:replaceRange withString:@""]
        stringByTrimmingCharactersInSet:[NSCharacterSet
                                            whitespaceCharacterSet]];
  }
  replaceRange = [string rangeOfString:subString];
  if (replaceRange.location != NSNotFound) {
    return [
        [string stringByReplacingCharactersInRange:replaceRange withString:@""]
        stringByTrimmingCharactersInSet:[NSCharacterSet
                                            whitespaceCharacterSet]];
  }

  return string;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whih cprovide the removing of commas form begin and end
 *
 *  @param string current string
 *
 *  @return result string
 */
+ (NSString *)removeCommas:(NSString *)string {
  NSString *resultString = [self trim:string];
  if ([resultString hasSuffix:@","]) {
    resultString = [resultString substringToIndex:resultString.length - 1];
  }

  if ([resultString hasPrefix:@","] && [resultString length] > 1) {
    resultString = [resultString substringFromIndex:1];
  }

  return resultString;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the string comparasions
 *
 *  @param firstString   first string
 *  @param anotherString second string
 *
 *  @return comparasions result
 */
+ (BOOL)compareString:(NSString *)firstString
              another:(NSString *)anotherString {
  if ([self isEmptyString:firstString]) {
    return NO;
  }
  if ([self isEmptyString:anotherString]) {
    return NO;
  }
  return [[firstString lowercaseString]
      isEqualToString:[anotherString lowercaseString]];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the removing new line symbols from the NSString
 *
 *  @param requiredString original string
 *
 *  @return postprocessing string
 */
+ (NSString *)removeNewLineSymbols:(NSString *)requiredString {
  NSString *resultString = @"";
  if ([StringHelper isEmptyString:requiredString] == NO) {
    resultString = [requiredString stringByReplacingOccurrencesOfString:@"\n"
                                                             withString:@" "];

    resultString = [resultString stringByReplacingOccurrencesOfString:@"  "
                                                           withString:@" "];
    resultString = [resultString
        stringByTrimmingCharactersInSet:[NSCharacterSet
                                            whitespaceCharacterSet]];
  }
  resultString = [self trim:resultString];
  return resultString;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the NSString triming
 *
 *  @param originalText
 *  @param index
 *
 *  @return trimed string
 */
+ (NSString *)trimToIndex:(NSString *)originalText index:(int)index {

  if (originalText == nil) {
    return @"";
  }

  NSString *result = originalText;
  if (index <= originalText.length) {
    result = [originalText substringToIndex:index];
  }
  return result;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the triming of the whitespaces at start and end of the
 * string
 *
 *  @param originalText original text
 *
 *  @return trimed text
 */
+ (NSString *)trim:(NSString *)originalText {
  NSString *trimmedString = [originalText
      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  return trimmedString;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide to removing of the last char
 *
 *  @param originalText original text
 *
 *  @return performed string
 */
+ (NSString *)removeLastChar:(NSString *)originalText {
  int newLength = (int)originalText.length - 1;
  return [self trimToIndex:originalText index:newLength];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide to checking of the required fields
 *
 *  @return checking value
 */
+ (NSString *)checkPassword:(NSString *)password
                     retype:(NSString *)retypedPassword {

  NSString *newPass = password;
  NSString *retypePass = retypedPassword;

  if (([StringHelper isEmptyString:newPass]) ||
      ([StringHelper isEmptyString:retypePass])) {
    return @"Please fill all of required fields.";
  }

  NSCharacterSet *cset = [NSCharacterSet decimalDigitCharacterSet];
  NSRange range = [newPass rangeOfCharacterFromSet:cset];
  if (range.location == NSNotFound) {
    return @"Password must be at least six characters, contain one letter and "
           @"one number.";
  }

  cset = [NSCharacterSet
      characterSetWithCharactersInString:
          @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm"];
  range = [newPass rangeOfCharacterFromSet:cset];
  if (range.location == NSNotFound) {
    return @"Password must be at least six characters, contain one "
           @"letter and one number.";
  }

  if (newPass.length <= 5) {
    return @"Password must be at least six characters, contain one "
           @"letter and one number.";
  }

  if (![newPass isEqualToString:retypePass]) {
    return @"Please enter your new password and enter it again so that it "
           @"matches exactly.";
  }

  return nil;
}

@end
