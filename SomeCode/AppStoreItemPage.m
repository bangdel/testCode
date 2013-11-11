//
//  AppStoreItemPage.m
//  UTSections
//
//  Created by urvashi on 03/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppStoreItemPage.h"

@interface AppStoreItemPage (private)
- (void)setRegularShadow;
- (void)setTrapezoidalShadow;
- (void)setEllipticalShadow;
- (void)setPaperCurlShadow;

- (void) initializeItemImage;
- (void) initializeLabels;

@end

@implementation AppStoreItemPage

@synthesize mItemImage = _itemImage;
@synthesize mItemName = _itemName;
@synthesize mItemDescription = _itemDescription;
@synthesize mItemPrice = _itemPrice;

- (void)dealloc{
    
    [_itemImage release];
    [_itemName release];
    [_itemPrice release];
    [_itemDescription release];
    
    [super dealloc];
    
}


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor: [UIColor clearColor]];
        [self initializeItemImage];
        [self initializeLabels];
        
    }
    return self;
}


- (void) initializeItemImage{
    
    _itemImage = [[UIImageView alloc] init];
    [_itemImage setBackgroundColor: [UIColor brownColor]];
    [self addSubview: _itemImage];

    _itemImage.layer.shadowColor = [UIColor blackColor].CGColor;
    _itemImage.layer.shadowOpacity = 0.8f;
    _itemImage.layer.shadowOffset = CGSizeMake(0.0f, 20.0f);
    _itemImage.layer.shadowRadius = 5.0f;
    _itemImage.layer.masksToBounds = NO;
    
}

- (void) initializeLabels{

    _itemName = [[UILabel alloc] init];
    [_itemName setText: @"this is a sample name"];
    [_itemName.layer setCornerRadius: 5.0f];
    [_itemName setFont: [UIFont systemFontOfSize: 15.0f]];
    [_itemName setBackgroundColor: [UIColor blackColor]];
    [_itemName setTextColor: [UIColor whiteColor]];
    [self addSubview: _itemName];

    _itemDescription = [[UILabel alloc] init];
    [_itemDescription setText: @"this is a sample description"];
    [_itemDescription.layer setCornerRadius: 5.0f];
    [_itemDescription setFont: [UIFont systemFontOfSize: 15.0f]];
    [_itemDescription setBackgroundColor: [UIColor blackColor]];
    [_itemDescription setTextColor: [UIColor whiteColor]];

    [self addSubview: _itemDescription];

    _itemPrice = [[UILabel alloc] init];
    [_itemPrice setText: @"this is a sample price"];
    [_itemPrice.layer setCornerRadius: 5.0f];
    [_itemPrice setFont: [UIFont systemFontOfSize: 15.0f]];
    [_itemPrice setBackgroundColor: [UIColor blackColor]];
    [_itemPrice setTextColor: [UIColor whiteColor]];
    [self addSubview: _itemPrice];

    NSLog(@"initializeLabels");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark - Different shadow styles
- (void)setRegularShadow{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_itemImage.bounds];
    _itemImage.layer.shadowPath = path.CGPath;
    
}

- (void)setTrapezoidalShadow{
    
    CGSize size = _itemImage.bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 0.66f, size.height * 0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
    [path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
    _itemImage.layer.shadowPath = path.CGPath;
}

-(void)setEllipticalShadow{
    
    CGSize size = _itemImage.bounds.size;
    CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    _itemImage.layer.shadowPath = path.CGPath;
    
}

- (void)setPaperCurlShadow{
    
    CGSize size = _itemImage.bounds.size;
    CGFloat curlFactor = 15.0f;
    CGFloat shadowDepth = 5.0f;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(size.width, 0.0f)];
    [path addLineToPoint:CGPointMake(size.width, size.height + shadowDepth)];
    [path addCurveToPoint:CGPointMake(0.0f, size.height + shadowDepth)
            controlPoint1:CGPointMake(size.width - curlFactor, size.height + shadowDepth - curlFactor)
            controlPoint2:CGPointMake(curlFactor, size.height + shadowDepth - curlFactor)];
    _itemImage.layer.shadowPath = path.CGPath;
    
}

-(void)layoutSubviews{
    
    CGRect mainFrame = self.frame;
    mainFrame.origin = CGPointZero;
    CGRect frameForImageView = CGRectInset(mainFrame, 150.0f, 150.0f);
    frameForImageView.origin.y -=50.0f;
    
    //  set frame for image
    [_itemImage setFrame: frameForImageView];
    
    
    CGRect frameForItemName = _itemImage.frame;
    frameForItemName.origin.y += frameForItemName.size.height + 70.0f;
    [_itemName sizeToFit];
    frameForItemName.size.height = _itemName.frame.size.height;
    frameForItemName.size.width = _itemName.frame.size.width;
    [_itemName setFrame: frameForItemName];
    
    CGRect frameForItemDescription = frameForItemName;
    frameForItemDescription.origin.y += frameForItemDescription.size.height + 10.0f;
    [_itemDescription sizeToFit];
    frameForItemDescription.size.height = _itemDescription.frame.size.height;
    frameForItemDescription.size.width = _itemDescription.frame.size.width;
    [_itemDescription setFrame: frameForItemDescription];
    
    CGRect frameForItemPrice = frameForItemDescription;
    frameForItemPrice.origin.y += frameForItemPrice.size.height + 10.0f;
    [_itemPrice sizeToFit];
    frameForItemPrice.size.height = _itemPrice.frame.size.height;
    frameForItemPrice.size.width = _itemPrice.frame.size.width;
    [_itemPrice setFrame: frameForItemPrice];
    
    [self setEllipticalShadow];
}

@end
