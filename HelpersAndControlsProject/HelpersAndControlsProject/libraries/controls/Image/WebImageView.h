//
//  WebImageView.h
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/15/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

typedef void (^OnImageLoadCallback)(BOOL success);

@interface WebImageView : UIImageView

- (void)setURLImage:(NSString *)imageURL;

- (void)setURLImage:(NSString *)imageURL callback:(OnImageLoadCallback)callback;

@end
