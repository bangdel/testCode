//
//  AppStoreUI.m
//  UTSections
//
//  Created by urvashi on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AppStoreUI.h"
#import "DrawingHelpers.h"
#import "AppStoreItemPage.h"

@interface AppStoreUI (private)
- (void) initializeAppStoreScroller;
- (void)setAppStoreWithItems;
@end

@implementation AppStoreUI

#pragma mark - Memory management methods
- (void)dealloc{
    
    [_arrayOfItems release];
    [_appStoreScroller release];
    [super dealloc];
}


#pragma mark - Initialization methods

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor: [UIColor whiteColor]];
        pageNumber = 0;
        [self initializeAppStoreScroller];
    }
    return self;
}


//  initialize app store scroller
- (void) initializeAppStoreScroller{

    CGRect frameForScroller = self.frame;
    frameForScroller.origin = CGPointZero;
    
    _appStoreScroller = [[UIScrollView alloc] initWithFrame: frameForScroller];
    [_appStoreScroller setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    _appStoreScroller.delegate = self;
    [_appStoreScroller setShowsHorizontalScrollIndicator: NO];
    [_appStoreScroller setShowsVerticalScrollIndicator: NO];
    [_appStoreScroller setPagingEnabled: YES];
    [self addSubview: _appStoreScroller];
    
}


//  ****** CAUTION : entry point here *********
- (void)setAppStoreItemsWithArray:(NSMutableArray *) items{

    _arrayOfItems = [items retain];
    [self setAppStoreWithItems];
    
}

- (void)setAppStoreWithItems{
    
    if(_arrayOfItems && [_arrayOfItems count]>0){
        
        CGRect scrollerFrame = _appStoreScroller.frame;
        
        [_appStoreScroller setContentSize: CGSizeMake(_appStoreScroller.frame.size.width * [_arrayOfItems count], _appStoreScroller.frame.size.height)];

        
        for(int i=0;i<[_arrayOfItems count];i++){
        
            CGRect pageFrame = scrollerFrame;
            pageFrame.origin.x = i*scrollerFrame.size.width;
            
            AppStoreItemPage *page = [[AppStoreItemPage alloc] initWithFrame: pageFrame];
            [_appStoreScroller addSubview: page];
            [page setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
            
            //  setdata
            [page.mItemImage setImage: [UIImage imageNamed: [[_arrayOfItems objectAtIndex: i] valueForKey: ITEM_IMAGE]]];
            
            [page.mItemName setText: [NSString stringWithFormat:@"   %@   ", [[_arrayOfItems objectAtIndex: i] valueForKey: ITEM_NAME]]];
            [page.mItemName sizeToFit];
            
            [page.mItemDescription setText: [NSString stringWithFormat:@"   %@   ", [[_arrayOfItems objectAtIndex: i] valueForKey: ITEM_DESCRIPTION]]];
            [page.mItemDescription sizeToFit];
            
            [page.mItemPrice setText: [NSString stringWithFormat:@"   %@   ", [[_arrayOfItems objectAtIndex: i] valueForKey: ITEM_PRICE]]];
            [page.mItemPrice sizeToFit];
            
            [page release];
        }
    }
}

#pragma mark - Listener methods


#pragma mark - Graphics customization methods

- (void)drawRect:(CGRect)rect{
    
    [super drawRect: rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSaveGState(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect frameforHalo = rect;
    
    CGPathAddRect(path, nil, frameforHalo);
    CGContextAddPath(context, path);
    
    CGColorRef transparentWhite = [UIColor colorWithRed:1.0f
                                                  green:1.0f 
                                                   blue:1.0f
                                                  alpha:1.0f].CGColor;


    CGColorRef transparentBlack = [UIColor colorWithRed:0.0f
                                                  green:0.0f 
                                                   blue:0.0f
                                                  alpha:1.0f].CGColor;
    
    

    drawGradientInContextForPath(context, path, transparentWhite, transparentBlack,kRadial);
    
    CGContextRestoreGState(context);
    
}

-(void)layoutSubviews{
    
    if(_arrayOfItems && [_arrayOfItems count]>0){
        
        [_appStoreScroller setContentSize: CGSizeMake(_appStoreScroller.frame.size.width * [_arrayOfItems count], _appStoreScroller.frame.size.height)];
        
        [_appStoreScroller scrollRectToVisible: CGRectMake(pageNumber * _appStoreScroller.frame.size.width, _appStoreScroller.frame.size.height, _appStoreScroller.frame.size.width, _appStoreScroller.frame.size.height)
                                      animated: YES];
    }
}

#pragma mark - Delegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    pageNumber = (scrollView.contentOffset.x)/scrollView.frame.size.width;
    
}

#pragma mark - Helper methods

@end
