//
//  BSBubbleCell.h
//  Bubble
//
//  Created by iBlacksus on 10/1/15.
//  Copyright © 2015 iBlacksus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BSBubbleCellSideType) {
    BSBubbleCellSideTypeIncoming,
    BSBubbleCellSideTypeOutgoing
};

@interface BSBubbleCell : UITableViewCell

@property (nonatomic) UIImage *bubbleImage;
@property (nonatomic) NSString *message;
@property (nonatomic) BSBubbleCellSideType sideType;

- (void)configure;

@end
