//
//  CustomTableViewCell.m
//  searcher
//
//  Created by yasin aktimur on 29.03.2015.
//  Copyright (c) 2015 yasin aktimur. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //UIImage *bgImage = [UIImage imageNamed:@"orange.png"];
    //self.backgroundView =  [[UIImageView alloc] initWithImage:bgImage];
    [self setBackgroundColor:[UIColor clearColor]];
   
}

@end
