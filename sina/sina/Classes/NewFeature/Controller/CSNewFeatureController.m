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
    
    return cell;
}







@end
