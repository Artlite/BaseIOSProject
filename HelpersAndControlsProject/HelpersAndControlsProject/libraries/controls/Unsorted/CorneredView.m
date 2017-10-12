//
//  CorneredView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/3/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "CorneredView.h"
static const int K_CORNER_RADIUS = 10;

@implementation CorneredView

-(void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = K_CORNER_RADIUS;
    self.layer.masksToBounds = YES;
}

@end
