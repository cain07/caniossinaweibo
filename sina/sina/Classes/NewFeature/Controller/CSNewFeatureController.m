//
//  CSNewFeatureController.m
//  sina
//
//  Created by mac on 16/9/10.
//  Copyright © 2016年 cain. All rights reserved.
//

#import "CSNewFeatureController.h"
#import "CSNewFeatureViewCell.h"

@interface CSNewFeatureController ()
@property (nonatomic, weak) UIPageControl *control;

@end

@implementation CSNewFeatureController

static NSString *ID = @"cell";

-(instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.collectionView.backgroundColor =[UIColor blueColor];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerClass:[CSNewFeatureViewCell class] forCellWithReuseIdentifier:ID];
    
    [self setUpPageControl];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CSNewFeatureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    //cell.backgroundColor = [UIColor yellowColor];
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}


// 添加pageController
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _control = control;
    [self.view addSubview:control];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}


@end
