//
//  CHTableViewCell.m
//  Test
//
//  Created by CoderHong on 2020/3/21.
//  Copyright © 2020 CoderHong. All rights reserved.
//

#import "CHTableViewCell.h"

@implementation CHTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // self.layer.cornerRadius = 7.0;
        // self.layer.masksToBounds = YES;
        self.backgroundColor = QXRandColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    CGRect newFrame = frame;
    // newFrame.origin.x += 10;
    // newFrame.size.width -= 20;
    newFrame.size.height -= 10;
    [super setFrame:newFrame];
}

@end
