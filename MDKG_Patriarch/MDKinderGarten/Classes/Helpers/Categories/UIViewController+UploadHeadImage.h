//
//  UIViewController+UploadHeadImage.h
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UploadHeadImage)<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  上传的二级制数据
 */
@property (strong, nonatomic) NSData *uploadPicData;
/**
 *  上传的图片
 */
@property (strong, nonatomic) UIImage *uploadImage;

/**
 *  上传头像
 *
 *  @param sender 上传按钮
 */
- (void)uploadButtonClicked:(UIButton *)sender;

@end
