//
//  KGMForthCell.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/6.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGMForthCellDelegate <NSObject>

- (void)clickCollectionWithButton:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

@end

@class KGMTopicData;
@interface KGMForthCell : UITableViewCell

@property (nonatomic, strong) KGMTopicData *topicData;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<KGMForthCellDelegate> delegate;

@end
