//
//  CheckBoxView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/7/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//
#import "CheckBoxView.h"
IB_DESIGNABLE
@interface CheckBoxView ()
@property(weak, nonatomic) IBOutlet UIImageView *imageCheckBox;
@property(weak, nonatomic) IBOutlet UIView *viewEditContent;
@property(nonatomic, strong) OnSelectCkeckbox callback;
@property(nonatomic, assign) BOOL needCallback;

#pragma mark - custom property
@property(nonatomic) IBInspectable UIColor *textColor;
@property(nonatomic) IBInspectable int textFontSize;
@property(nonatomic) IBInspectable int lines;
@property(nonatomic) IBInspectable BOOL isNeedHideEdit;
@property(nonatomic) IBInspectable UIImage *imageChecked;
@property(nonatomic) IBInspectable UIImage *imageNormal;
@property(nonatomic) IBInspectable NSString *labelText;
@end

@implementation CheckBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil][0];
        [view setFrame:self.bounds];
        [self addSubview:view];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view =
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil][0];
        [view setFrame:self.bounds];
        [self addSubview:view];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self firstInitialization];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide the first initialization
 */
- (void)firstInitialization {
    
    self.needCallback = true;
    
    if (self.imageNormal == nil) {
        self.imageNormal = [UIImage imageNamed:@"login_checkbox_off"];
    }
    
    if (self.imageChecked == nil) {
        self.imageChecked = [UIImage imageNamed:@"login_checkbox_on"];
    }
    
    if (self.isNeedHideEdit == YES) {
        self.viewEditContent.hidden = YES;
    } else {
        self.viewEditContent.hidden = NO;
    }
    
    if (self.textFontSize >= 0) {
        UIFont *textFont = [UIFont systemFontOfSize:self.textFontSize];
        self.labelName.font = textFont;
    }
    self.labelName.text = self.labelText;
    
    if (self.textColor != nil) {
        self.labelName.textColor = self.textColor;
    }
    
    self.labelName.numberOfLines = self.lines;
    
    [self sizeToFit];
    [self updateUI];
}

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    [self updateUI];
}

- (void)updateUI {
    if (self.isChecked) {
        [self.imageCheckBox setImage:self.imageChecked];
    } else {
        [self.imageCheckBox setImage:self.imageNormal];
    }
    if ((self.callback) && (self.needCallback == true)) {
        self.callback(self.isChecked);
    }
    self.needCallback = true;
}

- (IBAction)onCkeckBoxPressed:(id)sender {
    [self setIsChecked:!self.isChecked];
}

- (void)hideEdit {
    self.viewEditContent.hidden = YES;
}

- (void)setSelectedCallback:(OnSelectCkeckbox)callback {
    self.callback = callback;
}

-(void)setInitialSelection:(BOOL)isSelected {
    self.needCallback = false;
    self.isChecked = isSelected;
}

@end
