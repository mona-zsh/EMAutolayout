//
//  EMView.h
//  EMAutolayout
//
//  Created by Mona Zhang on 10/27/15.
//  Copyright © 2015 Eskimona. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, EMViewType) {
    EMViewTypeDefault,
    EMViewTypePaddingExample,
    EMViewTypeContainerExample,
    EMViewTypeFrameExample,
    EMViewTypeOptionsExample,
    EMViewTypeMaskExample,
};

@interface EMView : UIView

@property (nonatomic) EMViewType viewType;

@end
