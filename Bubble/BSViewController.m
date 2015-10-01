//
//  ViewController.m
//  Bubble
//
//  Created by iBlacksus on 10/1/15.
//  Copyright © 2015 iBlacksus. All rights reserved.
//

#import "BSViewController.h"
#import "BSBubbleCell.h"

static NSString * const kMessageOne = @"Lorem ipsum...";
static NSString * const kMessageTwo = @"Vestibulum dapibus, lacus eget aliquam gravida, ipsum nisi tristique ex, a pretium erat diam efficitur urna. Morbi a hendrerit metus.";
static NSString * const kMessageThree = @"Aenean vulputate commodo tortor non finibus. Vestibulum rutrum blandit massa, vehicula volutpat ligula dapibus vitae. Curabitur posuere, lectus nec vehicula ultrices, nulla felis ultrices nisi, a finibus augue urna id turpis. Etiam tempor facilisis maximus. Nulla et varius libero. Nunc commodo ut massa quis lacinia. Sed porttitor diam elit, in blandit quam placerat sit amet. Maecenas at elit non risus aliquam laoreet. Cras ullamcorper, odio quis consequat porta, nibh libero vestibulum diam, eu ullamcorper eros diam vitae tellus. Curabitur eros felis, iaculis pulvinar ligula ut, vestibulum lobortis nibh. Vestibulum laoreet est turpis, a fermentum ex luctus quis. Mauris at enim at justo eleifend dapibus.";

@interface BSViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *data;
@property (nonatomic) UIImage *incomingBubbleImage;
@property (nonatomic) UIImage *outgoingBubbleImage;

@end

@implementation BSViewController

#pragma mark - Life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureCollectionView];
    [self createBubbleImages];
    [self createData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([BSBubbleCell class]);
    
    BSBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.bubbleImage = (indexPath.row % 2) ? self.outgoingBubbleImage : self.incomingBubbleImage;
    cell.message = self.data[indexPath.row];
    cell.sideType = (indexPath.row % 2) ? BSBubbleCellSideTypeOutgoing : BSBubbleCellSideTypeIncoming;
    
    [cell configure];
    
    return cell;
}

#pragma mark - General methods -

- (void)createData
{
    self.data = [NSMutableArray array];
    
    for (NSInteger i=0; i < 30; i++) {
        [self.data addObject:[self randomMessage]];
    }
}

- (NSString *)randomMessage
{
    NSInteger randomInteger = rand() % 3;
    
    switch (randomInteger) {
        case 0: return kMessageOne;
        case 1: return kMessageTwo;
        case 2: return kMessageThree;
        default: return kMessageOne;
    }
}

- (void)configureCollectionView
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
}

- (void)createBubbleImages
{
    UIImage *bubbleImage = [UIImage imageNamed:@"bubble"];
    self.incomingBubbleImage = [self applyMaskWithColor:[UIColor colorWithRed:0.8977 green:0.9119 blue:0.9166 alpha:1.0] toImage:bubbleImage];
    self.outgoingBubbleImage = [self applyMaskWithColor:[UIColor colorWithRed:0.3865 green:0.7232 blue:0.8772 alpha:1.0] toImage:bubbleImage];
    // flip incoming image horizontaly
    self.incomingBubbleImage = [UIImage imageWithCGImage:self.incomingBubbleImage.CGImage
                                                   scale:self.incomingBubbleImage.scale
                                             orientation:UIImageOrientationUpMirrored];
    
    self.incomingBubbleImage = [self getStretchableImage:self.incomingBubbleImage];
    self.outgoingBubbleImage = [self getStretchableImage:self.outgoingBubbleImage];
}

- (UIImage *)applyMaskWithColor:(UIColor *)color toImage:(UIImage *)image
{
    CGRect imageRect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, image.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.f, -1.f);
    CGContextTranslateCTM(context, 0.f, -imageRect.size.height);
    CGContextClipToMask(context, imageRect, image.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imageRect);
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return maskedImage;
}

- (UIImage *)getStretchableImage:(UIImage *)image
{
    CGPoint center = CGPointMake(image.size.width / 2.0f, image.size.height / 2.0f);
    UIEdgeInsets insets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

@end
