//
//  KGMClassAlbumCell.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassAlbumCell.h"
#import "UIImageView+WebCache.h"

@interface KGMClassAlbumCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation KGMClassAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl ?: @""] placeholderImage:[UIImage imageNamed:@"news_demo"]];
}

@end
