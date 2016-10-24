//
//  KGMClassAlbumController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassAlbumController.h"
#import "MWPhotoBrowser.h"
#import "KGMClassAlbumCell.h"

#import "KGMClassAlbumService.h"

static NSString *const CellIdentify = @"KGMClassAlbumCell";
@interface KGMClassAlbumController ()<MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableArray *thumbArr;
@property (nonatomic, strong) MWPhotoBrowser *browser;

@property (nonatomic, strong) KGMClassAlbumService *albumService;

@end

@implementation KGMClassAlbumController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班级相册";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.photoArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://121.42.178.16/kind/Public/Uploads/photo/2016-10-12/57fdaaf1d06e9.jpg"]]];
//    [self.photoArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://121.42.178.16/kind/Public/Uploads/photo/2016-10-12/57fdaaf1d06e9.jpg"]]];
//    
//    [self.thumbArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://121.42.178.16/kind/Public/Uploads/photo/2016-10-12/mini57fdaaf1d06e9.jpg"]]];
//    [self.thumbArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://121.42.178.16/kind/Public/Uploads/photo/2016-10-12/mini57fdaaf1d06e9.jpg"]]];
    
    [self.view addSubview:self.browser.view];
    [self addChildViewController:self.browser];
    
    [self fetchAlbumList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photoArr.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photoArr.count)
        return [self.photoArr objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.thumbArr.count)
        return [self.thumbArr objectAtIndex:index];
    return nil;
}

#pragma mark - networkRequest
- (void)fetchAlbumList {
    @weakify(self);
    [self.albumService fetchClassAlbumListWithClassId:[UserCenter sharedInstance].classId success:^(id data) {
        @strongify(self);
        NSArray *arr = ((KGMClassAlbumListDTO *)data).data;
        for (KGMClassAlbumListData *detailData in arr) {
            [self.photoArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:detailData.bimg]]];
            [self.thumbArr addObject:[MWPhoto photoWithURL:[NSURL URLWithString:detailData.simg]]];
        }
        [self.browser reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - getter
- (NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (NSMutableArray *)thumbArr {
    if (!_thumbArr) {
        _thumbArr = [NSMutableArray array];
    }
    return _thumbArr;
}

- (MWPhotoBrowser *)browser {
    if (!_browser) {
        _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        
        BOOL displayActionButton = NO;
        BOOL displaySelectionButtons = NO;
        BOOL displayNavArrows = NO;
        BOOL enableGrid = YES;
        BOOL startOnGrid = YES;
        BOOL autoPlayOnAppear = NO;
        _browser.displayActionButton = displayActionButton;
        _browser.displayNavArrows = displayNavArrows;
        _browser.displaySelectionButtons = displaySelectionButtons;
        _browser.alwaysShowControls = displaySelectionButtons;
        _browser.zoomPhotosToFill = YES;
        _browser.enableGrid = enableGrid;
        _browser.startOnGrid = startOnGrid;
        _browser.enableSwipeToDismiss = NO;
        _browser.autoPlayOnAppear = autoPlayOnAppear;
        [_browser setCurrentPhotoIndex:0];
    }
    return _browser;
}

- (KGMClassAlbumService *)albumService {
    if (!_albumService) {
        _albumService = [[KGMClassAlbumService alloc]init];
    }
    return _albumService;
}

@end
