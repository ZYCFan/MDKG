//
//  KGMSecCell.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGMClickButton.h"

@class KGMSecCell;
@protocol KGMSecCellDelegate <NSObject>

- (void)tableViewCell:(KGMSecCell *)cell clickButton:(KGMClickButton *)sender;

@end

@interface KGMSecCell : UITableViewCell

@property (nonatomic, weak) id<KGMSecCellDelegate> delegate;

@end
