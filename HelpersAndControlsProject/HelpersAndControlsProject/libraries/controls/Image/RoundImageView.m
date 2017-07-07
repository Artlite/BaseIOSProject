//
//  RoundImageView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/7/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "RoundImageView.h"

@implementation RoundImageView

-(void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width/ 2.0;
    self.clipsToBounds = YES;
}

@end
