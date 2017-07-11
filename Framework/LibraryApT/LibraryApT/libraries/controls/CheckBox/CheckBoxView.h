//
//  CheckBoxView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/7/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnSelectCkeckbox)(BOOL isChecked);

@interface CheckBoxView : UIView
@property(nonatomic, assign) BOOL isChecked;
@property(weak, nonatomic) IBOutlet UILabel *labelName;
@property(weak, nonatomic) IBOutlet UITextField *editContent;

//- (void)hideEdit;

//- (void)setUp:(NSString *)text hideEdit:(BOOL)isNeedHideEdit;
//
//- (void)setUp:(NSString *)text
//     hideEdit:(BOOL)isNeedHideEdit
// imageChecked:(NSString *)checkdImageName
//  imageNormal:(NSString *)normalImageName
//    textColor:(UIColor *)textColor;

- (void)setSelectedCallback:(OnSelectCkeckbox)callback;
- (void)setInitialSelection:(BOOL) isSelected;
@end
