//
//  KGMClassInfoCell.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/8.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGMClassInfoCellDelegate <NSObject>

- (void)btnKnowClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath;

@end

@class KGMClassNoteDetailData;
@interface KGMClassInfoCell : UITableViewCell

@property (nonatomic, strong) KGMClassNoteDetailData *detailData;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<KGMClassInfoCellDelegate> delegate;

@end
