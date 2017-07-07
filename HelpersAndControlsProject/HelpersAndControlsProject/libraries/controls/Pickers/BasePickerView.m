//
//  BasePickerView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/8/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "BasePickerView.h"

@interface BasePickerView ()
@property(nonatomic, strong) OnPickerViewCallback callback;
@end

@implementation BasePickerView

- (void)awakeFromNib {
  [self hideLines];
  self.delegate = self;
  self.dataSource = self;
  NSArray *array = [self getDataArrayValues];
  self.value = [array firstObject];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which procide the hiding of the lines
 */
- (void)hideLines {
  self.showsSelectionIndicator = [self getNeedsHideLines];
}

#pragma mark - picker view delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
  NSArray *array = [self getDataArrayValues];
  return array.count;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
  NSArray *array = [self getDataArrayValues];
  self.value = array[row];
  if (self.callback) {
    self.callback(self.value);
  }
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
  NSArray *array = [self getDataArrayValues];
  return array[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
  NSArray *array = [self getDataArrayValues];
  UILabel *label = nil;
  if (label == nil) {
    label =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self getWidthValue],
                                                  [self getHeightValue])];
    label.text = array[row];
    label.textAlignment = NSTextAlignmentCenter;
  }
  [label setTextColor:[UIColor blackColor]];
  [label setFont:[UIFont systemFontOfSize:[self getFontSizeValue]]];
  return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component {
  return @([self getHeightValue]).floatValue;
}

#pragma mark - overriden methods
/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the picker values from the child class
 *
 *  @return current array of values for the UIPickerView
 */
- (NSArray *)getDataArrayValues {
  [NSException
       raise:@"The method override exception"
      format:@"BasePickerView -> getDataArrayValues should be overriden"];
  return nil;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the setting values that allow to hide selection lines
 *
 *  @return result values
 */
- (BOOL)getNeedsHideLines {
  return NO;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the current font size
 *
 *  @return current font size
 */
- (int)getFontSizeValue {
  return 15;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the cell height
 *
 *  @return current picker height
 */
- (int)getHeightValue {
  return self.frame.size.height;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the getting of the picker view width
 *
 *  @return current width
 */
- (int)getWidthValue {
  return self.frame.size.width;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the adding of the picker callback inside the
 *UIPickerView
 *
 *  @param callback current callback
 */
- (void)addPickerCallback:(OnPickerViewCallback)callback {
  self.callback = callback;
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the setting of the initial picker value
 *
 *  @param initialValue initial picker value
 */
- (void)setInitialPickerView:(NSString *)initialValue {
  NSArray<NSString *> *values = [self getDataArrayValues];
  for (int i = 0; i < values.count; i++) {
    NSString *value = values[i];
    if ([value isEqualToString:initialValue]) {
      [self selectRow:i inComponent:0 animated:YES];
      self.value = value;
    }
  }
}

@end
