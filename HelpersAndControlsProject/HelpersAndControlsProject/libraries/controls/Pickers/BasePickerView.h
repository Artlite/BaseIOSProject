//
//  BasePickerView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/8/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnPickerViewCallback)(NSString *value);

@interface BasePickerView
    : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic, strong) NSString *value;

- (NSArray<NSString *> *)getDataArrayValues;

- (BOOL)getNeedsHideLines;

- (int)getFontSizeValue;

- (int)getHeightValue;

- (int)getWidthValue;

- (void)addPickerCallback:(OnPickerViewCallback)callback;

- (void)setInitialPickerView:(NSString *)initialValue;

@end
