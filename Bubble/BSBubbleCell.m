//
//  BSBubbleCell.m
//  Bubble
//
//  Created by iBlacksus on 10/1/15.
//  Copyright © 2015 iBlacksus. All rights reserved.
//

#import "BSBubbleCell.h"

@interface BSBubbleCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageLeadingConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageTrailingConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLabelLeadingConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLabelTrailingConstant;

@end

@implementation BSBubbleCell

- (void)configure
{
    self.bubbleImageView.image = self.bubbleImage;
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = (self.sideType == BSBubbleCellSideTypeOutgoing) ? NSTextAlignmentRight : NSTextAlignmentLeft;
    
    [self.messageLabel sizeToFit];
    
    CGFloat widthDifference = CGRectGetWidth(self.frame) - CGRectGetWidth(self.messageLabel.frame) - self.messageLabelLeadingConstant.constant - self.messageLabelTrailingConstant.constant - 10.f;
    
    if (self.sideType == BSBubbleCellSideTypeOutgoing) {
        self.bubbleImageTrailingConstant.constant = 0.f;
        self.bubbleImageLeadingConstant.constant = widthDifference;
    } else {
        self.bubbleImageTrailingConstant.constant = widthDifference;
        self.bubbleImageLeadingConstant.constant = 0.f;
    }
    
    [self.bubbleImageView setNeedsLayout];
    [self.bubbleImageView layoutIfNeeded];
}

@end
