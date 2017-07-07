//
//  SmileRatingView.m
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 10/2/15.
//  Copyright © 2015 Magnet. All rights reserved.
//

#import "SmileRatingView.h"
#import "SmileDotView.h"
#import "TintedImageView.h"
#import "CLabel.h"

#define smileRatingMax 5 //0 - minimum
#define SmileImage(index) [NSString stringWithFormat:@"face_level_%@.png",@(index)]

#define K_TEXTS_IMPACT  \
@{     \
@(0) : @"No Impact Rating",   \
@(1) : @"Very Low Impact Rating",   \
@(2) : @"Low Impact Rating",    \
@(3) : @"Medium Impact Rating", \
@(4) : @"High Impact Rating",   \
@(5) : @"Very High Impact Rating"   \
}

static const int K_DOT_SIZE = 17;
static const int K_DOT_COUNT = 40;
static const int K_DOT_RADIUS = 110;

@interface SmileRatingView ()
@property(weak, nonatomic) IBOutlet UIView *smileView;
@property(weak, nonatomic) IBOutlet TintedImageView *imageSmile;
@property(weak, nonatomic) IBOutlet CLabel *labelImpactrating;
#pragma mark - smile functional variables
@property(nonnull, strong) NSMutableArray *dotsArray;
@end

@implementation SmileRatingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =
        [[NSBundle mainBundle] loadNibNamed:@"SmileRatingView"
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
        [[NSBundle mainBundle] loadNibNamed:@"SmileRatingView"
                                      owner:self
                                    options:nil][0];
        [view setFrame:self.bounds];
        [self addSubview:view];
    }
    return self;
}

- (void)awakeFromNib {
    self.dotsArray = [NSMutableArray new];
    self.rating = @(0);
}

- (void)didMoveToSuperview {
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(drawPoints)
                                   userInfo:nil
                                    repeats:NO];
}

/**
 *  Method which provide the getting of the coordinate list for the circle
 *object
 *
 *  @param pointCounts point count
 *  @param radius      radius value
 *  @param x           center x
 *  @param y           center y
 *  @param size        size for the view
 *
 *  @return circle points dictionary
 */
- (NSDictionary *)getCirclePoints:(int)pointCounts
                           radius:(int)radius
                          centerX:(float)x
                          centerY:(float)y
                             size:(int)size {
    double pi = 3.14159265359;
    NSMutableDictionary *points = [NSMutableDictionary new];
    
    points[@"x"] = [NSMutableArray new];
    points[@"y"] = [NSMutableArray new];
    
    double slice = 2 * pi / pointCounts;
    
    for (int i = 0; i < pointCounts; i++) {
        double angle = slice * i - (2 * pi / 4);
        int newX = (int)(x + radius * cos(angle));
        int newY = (int)(y + radius * sin(angle));
        [((NSMutableArray *)(points[@"x"]))addObject:@(newX - size / 2)];
        [((NSMutableArray *)(points[@"y"]))addObject:@(newY - size / 2)];
    }
    
    return points;
}

/**
 *  Method which provide the drawing smile points animated
 */
- (void)drawPoints {
    
    if([self isVisible] == NO){
        return;
    }
    
    [self layoutIfNeeded];
    // Get coordinate points
    NSDictionary *coordinates =
    [self getCirclePoints:K_DOT_COUNT
                   radius:K_DOT_RADIUS
                  centerX:self.smileView.frame.size.width / 2
                  centerY:self.smileView.frame.size.height / 2
                     size:K_DOT_SIZE];
    
    // Get x and y array
    NSArray *xArray = coordinates[@"x"];
    NSArray *yArray = coordinates[@"y"];
    
    // Add subviews animated
    [self.dotsArray removeAllObjects];
    
    for (int i = 0; i < xArray.count; i++) {
        NSNumber *xValue = xArray[i];
        NSNumber *yValue = yArray[i];
        SmileDotView *dotView = [[SmileDotView alloc]
                                 initWithFrame:CGRectMake(xValue.intValue, yValue.intValue, K_DOT_SIZE,
                                                          K_DOT_SIZE)];
        
        [self.dotsArray addObject:dotView];
        
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.smileView addSubview:dotView];
                             [self layoutIfNeeded];
                         }];
    }
    [self layoutIfNeeded];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    if ((sender.state == UIGestureRecognizerStateBegan) ||
        (sender.state == UIGestureRecognizerStateChanged)) {
        // Get point
        CGPoint point = [sender locationInView:self.smileView];
        // Check what view is located in this rect
        for (SmileDotView *view in self.dotsArray) {
            // If the view is contain in this rect than do next
            if (CGRectContainsPoint(view.frame, point)) {
                // Get current index
                int currentIndex = @([self.dotsArray indexOfObject:view]).intValue;
                // Set smile image
                [self setSmileImage:currentIndex];
                // Modify views state
                for (int i = 0; i <= self.dotsArray.count - 1; i++) {
                    SmileDotView *view = self.dotsArray[i];
                    if (i <= currentIndex) {
                        [view setCurrentDotLevel:1];
                    } else {
                        [view setCurrentDotLevel:0];
                    }
                }
                break;
            }
        }
    }
    [self layoutIfNeeded];
}

/**
 *  Method which provide the setting of the current smile image by dot progress
 *
 *  @param dotIndex current dot index
 */
- (void)setSmileImage:(int)dotIndex {
    int imageIndex = [self getImageIndex:dotIndex];
    [self setSmileImageByRating:imageIndex];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the setting of th smile image by rating
 *
 *  @param imageIndex rating
 */
- (void)setSmileImageByRating:(int)rating {
    UIColor *tintColor = self.imageSmile.tintColor;

    self.rating = @(rating);

    int imageIndex = rating;

    if (rating > smileRatingMax ) {
        imageIndex = smileRatingMax;
    }
    UIImage *image = [UIImage imageNamed:SmileImage(imageIndex)];

    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.imageSmile setTintedImage:image];
                         [self layoutIfNeeded];
                     }];
    [self.labelImpactrating setText:K_TEXTS_IMPACT[@(rating)]
                          textColor:tintColor
                      isNeedJustify:NO];
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method whihc provide the setting of the dot index
 *
 *  @param rating rating value
 */
- (void)setDotsIndex:(int)rating {
    int dotIndex = @(rating * (K_DOT_COUNT / 5)).intValue;
    for (int i = 0; i < dotIndex; i++) {
        if (i < self.dotsArray.count) {
            SmileDotView *dotView = self.dotsArray[i];
            [dotView setCurrentDotLevel:1];
        }
    }
}

/**
 *  @author Dmitriy Lernatovich
 *
 *  Method which provide to setting of the rating
 *
 *  @param rating
 */
- (void)setInitialRating:(int)rating {
    self.rating = @(rating);
    [self setDotsIndex:rating];
    [self setSmileImageByRating:rating];
}

/**
 *  Method which provide the getting of the current rating level
 *
 *  @param currentDotIndex current amount of the selected dots
 *
 *  @return current rating
 */
- (int)getImageIndex:(int)currentDotIndex {
    
    int index1 = (1 * (K_DOT_COUNT / 5));
    int index2 = (2 * (K_DOT_COUNT / 5));
    int index3 = (3 * (K_DOT_COUNT / 5));
    int index4 = (4 * (K_DOT_COUNT / 5));
    int index5 = (5 * (K_DOT_COUNT / 5));
    
    if ((currentDotIndex > 0) && (currentDotIndex <= index1)) {
        return 1;
    } else if ((currentDotIndex > index1) && (currentDotIndex <= index2)) {
        return 2;
    } else if ((currentDotIndex > index2) && (currentDotIndex <= index3)) {
        return 3;
    }
    if ((currentDotIndex > index3) && (currentDotIndex <= index4)) {
        return 4;
    } else if ((currentDotIndex > index4) && (currentDotIndex <= index5)) {
        return 5;
    }
    return 0;
}

-(BOOL)isVisible{
    if (self.window) {
        // viewController is visible
        return YES;
    }
    return NO;
}

#pragma mark - static methods

+ (UIImage *) getImageByRating: (int) rating{

    NSString * imageName = SmileImage(0);

    if (rating>=0) {
        imageName = SmileImage(rating);
    }
    
    UIImage * image = [UIImage imageNamed:imageName];
    return image;
}

+ (NSString *) getTextByRating: (int) rating{
    NSNumber * key = @(rating);
    if([K_TEXTS_IMPACT.allKeys containsObject:key] == NO){
        return [K_TEXTS_IMPACT.allValues lastObject];
    }
    
    return K_TEXTS_IMPACT[key];
}

@end
