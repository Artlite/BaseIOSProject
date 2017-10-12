//
//  WebImageView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 9/15/15.
//  Copyright (c) 2015 Magnet. All rights reserved.
//

#import "WebImageView.h"

IB_DESIGNABLE
@interface WebImageView ()
@property(nonatomic) IBInspectable UIImage *placeholderImage;
@end

@implementation WebImageView

/**
 * Method which provide the setting image by url
 */
- (void)setURLImage:(NSString *)imageURL {
    [self setURLImage:imageURL callback:nil];
}

/**
 *  Method which provide the image loading by url with callback
 *
 *  @param imageURL image URL
 *  @param callback callback
 */
-(void) setURLImage:(NSString *)imageURL callback: (OnImageLoadCallback ) callback {
    [self setImage:self.placeholderImage];
    
    __weak WebImageView *weakSelf = self;
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *url = [NSURL URLWithString:imageURL];
    [manager downloadImageWithURL:url
                          options:SDWebImageLowPriority
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,
                                    BOOL finished, NSURL *imageURL) {
                            BOOL success = YES;
                            if (image) {
                                [weakSelf setImage:image];
                            } else {
                                success = NO;
                                [weakSelf setImage:weakSelf.placeholderImage];
                            }
                            
                            if(callback != nil){
                                callback(success);
                            }
                        }];
}

@end
