//
//  AppStoreUI.h
//  UTSections
//
//  Created by urvashi on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ITEM_IMAGE @"itemImage"
#define ITEM_NAME @"itemName"
#define ITEM_DESCRIPTION @"itemDescription"
#define ITEM_PRICE @"itemPrice"

@interface AppStoreUI : UIView <UIScrollViewDelegate>{
    
    UIScrollView *_appStoreScroller;
    
    
    NSMutableArray *_arrayOfItems;
    int pageNumber;

}

- (void)setAppStoreItemsWithArray:(NSMutableArray *) items;


@end
