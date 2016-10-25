//
//  UIViewController+UploadHeadImage.m
//  MDKinderGarten
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UIViewController+UploadHeadImage.h"
#import <MobileCoreServices/MobileCoreServices.h>

static const char *uploadPicDataKey = "uploadPicDataKey";
static const char *uploadImageKey = "uploadImage";
@implementation UIViewController (UploadHeadImage)

- (void)uploadButtonClicked:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍照", @"从本地获取", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"%ld",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:^{}];
        }
            break;
        case 1:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:^{}];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        self.uploadImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(120, 120)];
        self.uploadPicData = UIImageJPEGRepresentation(self.uploadImage, 1.0);
        [self performSelector:@selector(savePicture:) withObject:self.uploadPicData afterDelay:0.5];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private methods
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark - getters and setters
- (NSData *)uploadPicData {
    return (NSData *)objc_getAssociatedObject(self, uploadPicDataKey);
}

- (UIImage *)uploadImage {
    return (UIImage *)objc_getAssociatedObject(self, uploadImageKey);
}

- (void)setUploadPicData:(NSData *)uploadPicData {
    objc_setAssociatedObject(self, uploadPicDataKey, uploadPicData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setUploadImage:(UIImage *)uploadImage {
    objc_setAssociatedObject(self, uploadImageKey, uploadImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
