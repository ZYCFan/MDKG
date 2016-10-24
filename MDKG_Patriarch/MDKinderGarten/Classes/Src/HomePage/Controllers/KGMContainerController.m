//
//  KGMMessageInfoController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/7.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMContainerController.h"
#import "SlipNavController.h"

#import "KGMClassNoticeController.h"
#import "KGMEducationNoticeController.h"

#import "KGMWeekCourseController.h"
#import "KGMTodayCourseController.h"

#import "KGMWeekRecipesController.h"
#import "KGMPersonalRecipesController.h"

@interface KGMContainerController ()

@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *controllers;
@property (nonatomic, copy) NSArray *controllerTitles;
@property (nonatomic, strong) SlipNavController *slipVC;

@property (nonatomic, assign) ContainerControllerType type;

@end

@implementation KGMContainerController
- (instancetype)init {
    return [self initWithType:ContainerControllerTypeNotice];
}

- (instancetype)initWithType:(ContainerControllerType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleArr[self.type];
    [self.slipVC addParentController:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (SlipNavController *)slipVC {
    if (!_slipVC) {
        _slipVC = [[SlipNavController alloc]initWithSubViewControllers:self.controllers titles:self.controllerTitles];
        _slipVC.navTabBarColor = HomePageBottomColor;
        _slipVC.navTabBarLineColor = VERSION_MAN ? GlobalColor_MAN : GlobalColor_Female;
    }
    return _slipVC;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"通知信息",@"课堂与作业",@"宝贝食谱"];
    }
    return _titleArr;
}

- (NSArray *)controllers {
    if (!_controllers) {
        switch (self.type) {
            case 0:
            {
                KGMClassNoticeController *classNoticeVC = [[KGMClassNoticeController alloc]init];
                KGMEducationNoticeController *educationVC = [[KGMEducationNoticeController alloc]init];
                _controllers = @[classNoticeVC, educationVC];
            }
                break;
            case 1:
            {
                KGMWeekCourseController *weekCourseVC = [[KGMWeekCourseController alloc]init];
                KGMTodayCourseController *todayCourseVC = [[KGMTodayCourseController alloc]init];
                _controllers = @[weekCourseVC, todayCourseVC];
            }
                break;
            case 2:
            {
                KGMWeekRecipesController *weekRecipesVC = [[KGMWeekRecipesController alloc]init];
                KGMPersonalRecipesController *personRepicesVC = [[KGMPersonalRecipesController alloc]init];
                _controllers = @[weekRecipesVC, personRepicesVC];
            }
                break;
            default:
                break;
        }
        
    }
    return _controllers;
}

- (NSArray *)controllerTitles {
    if (!_controllerTitles) {
        switch (self.type) {
            case 0:
                _controllerTitles = @[@"班级通知",@"教育局通知"];
                break;
            case 1:
                _controllerTitles = @[@"一周课程",@"今日作业"];
                break;
            case 2:
                _controllerTitles = @[@"一周食谱",@"私人定制"];
                break;
            default:
                break;
        }
    }
    return _controllerTitles;
}

@end
