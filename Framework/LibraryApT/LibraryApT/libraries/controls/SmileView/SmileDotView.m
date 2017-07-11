//
//  SmileDotView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/2/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "SmileDotView.h"
@interface SmileDotView ()
@property(weak, nonatomic) IBOutlet UIView *defaultView;
@property(weak, nonatomic) IBOutlet UIView *selectedView;
@end

@implementation SmileDotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =
        [[NSBundle mainBundle] loadNibNamed:@"SmileDotView"
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
        [[NSBundle mainBundle] loadNibNamed:@"SmileDotView"
                                      owner:self
                                    options:nil][0];
        [view setFrame:self.bounds];
        [self addSubview:view];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.defaultView setAlpha:1];
                         [self layoutIfNeeded];
                     }];
}

/**
 *  Method which provide the setting of the current dot level
 *
 *  @param dotLevel current dot level value
 */
- (void)setCurrentDotLevel:(int)dotLevel {
    if (dotLevel == 1) {
        self.selectedView.hidden = NO;
    } else {
        self.selectedView.hidden = YES;
    }
}

@end
