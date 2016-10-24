//
//  KGMMessageInfoController.h
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ContainerControllerType) {
    ContainerControllerTypeNotice,
    ContainerControllerTypeCourseAndTask,
    ContainerControllerTypeRecipes,
};

@interface KGMContainerController : UIViewController

- (instancetype)initWithType:(ContainerControllerType)type;

@end
