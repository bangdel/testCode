//
//  AppStoreItemPage.h
//  UTSections
//
//  Created by urvashi on 03/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppStoreItemPage : UIView {
    
    UIImageView *_itemImage;
    
    UILabel *_itemName;
    
    UILabel *_itemDescription;
    
    UILabel *_itemPrice;
    
}

@property (nonatomic, retain) UIImageView *mItemImage;

@property (nonatomic, retain) UILabel *mItemName;

@property (nonatomic, retain) UILabel *mItemDescription;

@property (nonatomic, retain) UILabel *mItemPrice;


@end
