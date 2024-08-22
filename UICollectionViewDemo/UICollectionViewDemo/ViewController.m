//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by mal on 8/21/24.
//

#import "ViewController.h"
#import "TestCell.h"
#import "VMANCreateRoleAnimationView.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Collection View setup
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // Calculate the width for 2.5 cells on screen
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellWidth = floor((screenWidth - 16 - (12 * 1.5)) / 2.5);
    CGFloat cellHeight = floor(cellWidth * (5 / 3.0));
    layout.itemSize = CGSizeMake(cellWidth, cellHeight); // Cell height is arbitrary, set to 150 here
    
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    layout.minimumLineSpacing = 12;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, cellHeight) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TestCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.testLB.text = self.dataSource[indexPath.row];
    return cell;
}

- (IBAction)insertData {
    NSString *addObj = [NSString stringWithFormat:@"%ld", self.dataSource.count + 1];
    NSArray *oldDatas = [NSArray arrayWithArray:self.dataSource];
    [self.dataSource insertObject:addObj atIndex:0];
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    [VMANCreateRoleAnimationView showWithOldDatas:oldDatas newDatas:self.dataSource parentView:self.collectionView];
}

@end
