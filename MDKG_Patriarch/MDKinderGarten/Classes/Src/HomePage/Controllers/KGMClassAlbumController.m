//
//  KGMClassAlbumController.m
//  MDKinderGarten
//
//  Created by 周永超 on 16/10/20.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "KGMClassAlbumController.h"
#import "IDMPhotoBrowser.h"
#import "KGMClassAlbumCell.h"

#import "KGMClassAlbumService.h"

static NSString *const CellIdentify = @"KGMClassAlbumCell";
@interface KGMClassAlbumController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photoArr;//小图集合
@property (nonatomic, strong) NSMutableArray *thumbArr;//大图集合
@property (nonatomic, strong) NSMutableArray *photos;//图片轮播器集合

@property (nonatomic, strong) KGMClassAlbumService *albumService;

@end

@implementation KGMClassAlbumController

#pragma mark - life cycle

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班级相册";
    
    [self fetchAlbumList];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KGMClassAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentify forIndexPath:indexPath];
    
    [self p_configurationCell:cell indexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 3.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kDeviceWidth - 6.f) / 3.f, 100.f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc]initWithPhotos:self.photos];
    browser.displayActionButton = NO;
    
    [browser setInitialPageIndex:indexPath.item];
    [self presentViewController:browser animated:YES completion:nil];
}

#pragma mark - networkRequest
- (void)fetchAlbumList {
    @weakify(self);
    [self.albumService fetchClassAlbumListWithClassId:[UserCenter sharedInstance].classId success:^(id data) {
        @strongify(self);
        NSArray *arr = ((KGMClassAlbumListDTO *)data).data;
        if (arr.count) {
            for (KGMClassAlbumListData *detailData in arr) {
                [self.photoArr addObject:detailData.simg];
                [self.thumbArr addObject:detailData.bimg];
                
                IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:detailData.bimg]];
                [self.photos addObject:photo];
            }
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSString *errorStr) {
        @strongify(self);
        [self displayActivityIndicatorView:errorStr mode:MBProgressHUDModeText afterDelay:1];
    }];
}

#pragma mark - private methods
- (void)p_configurationCell:(KGMClassAlbumCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.imageUrl = self.photoArr[indexPath.item];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:CellIdentify bundle:nil] forCellWithReuseIdentifier:CellIdentify];
    }
    return _collectionView;
}

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

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (KGMClassAlbumService *)albumService {
    if (!_albumService) {
        _albumService = [[KGMClassAlbumService alloc]init];
    }
    return _albumService;
}

@end
