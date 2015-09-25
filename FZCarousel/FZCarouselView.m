//
//  FZCarouselView.m
//  FZCarousel
//
//  Created by Sheng Dong on 9/25/15.
//  Copyright © 2015 Fuzz Productions, LLC. All rights reserved.
//

#import "FZCarouselView.h"
#import "FZCarouselCollectionViewDelegate.h"


@interface FZDefaultCarouselCollectionViewDelegate : FZCarouselCollectionViewDelegate
@end


@interface FZDefaultCarouselCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end


@interface FZCarouselView()

@property (strong, nonatomic) FZDefaultCarouselCollectionViewDelegate *carouselCollectionViewDelegate;
@property (nonatomic, strong) UICollectionView *collectionView;

@end


@implementation FZCarouselView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		[self setupCollectionView];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupCollectionView];
		self.gestureRecognitionShouldEndCarousel = false;
		self.crankInterval = 3.0;
	}
	return self;
}

- (void)setupCollectionView
{
	self.imageArray = [NSArray array];
	
	UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
	[self.collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.collectionView setShowsHorizontalScrollIndicator:NO];
	[self addSubview:self.collectionView];
	NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
	NSArray *topAndBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:@{} views:views];
	NSArray *leftAndRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:@{} views:views];
	[self addConstraints:topAndBottom];
	[self addConstraints:leftAndRight];
}

- (void)setImageArray:(NSArray<UIImage *> *)imageArray
{
	_imageArray = imageArray;
}

- (void)prepareCollectionViewDelegate
{
	self.carouselCollectionViewDelegate = [FZDefaultCarouselCollectionViewDelegate carouselCollectionViewDelegateForCollectionView:self.collectionView dataArray:self.imageArray crankInterval:self.crankInterval];
	self.carouselCollectionViewDelegate.gestureRecognitionShouldEndCarousel = self.gestureRecognitionShouldEndCarousel;
}

//- (void)setCrankInterval:(NSTimeInterval)crankInterval {
//	_crankInterval = crankInterval;
//	self.carouselCollectionViewDelegate.defaultCrankInterval = self.crankInterval;
//}

- (void)beginCarousel
{
	[self prepareCollectionViewDelegate];
	[self.carouselCollectionViewDelegate beginCarousel];
}

//- (void)setGestureRecognitionShouldEndCarousel:(BOOL)gestureRecognitionShouldEndCarousel {
//	_gestureRecognitionShouldEndCarousel = gestureRecognitionShouldEndCarousel;
//	self.carouselCollectionViewDelegate.gestureRecognitionShouldEndCarousel = self.gestureRecognitionShouldEndCarousel;
//}


@end



static NSString *const FZDefaultCarouselCollectionViewCellIdentifier = @"FZDefaultCarouselCollectionViewCell";

@implementation FZDefaultCarouselCollectionViewDelegate

+ (instancetype)carouselCollectionViewDelegateForCollectionView:(UICollectionView *)inCollectionView dataArray:(NSArray *)inDataArray crankInterval:(NSTimeInterval)inCrankInterval
{
	[inCollectionView registerClass:[FZDefaultCarouselCollectionViewCell class] forCellWithReuseIdentifier:FZDefaultCarouselCollectionViewCellIdentifier];
	return [super carouselCollectionViewDelegateForCollectionView:inCollectionView dataArray:inDataArray crankInterval:inCrankInterval];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	FZDefaultCarouselCollectionViewCell *rtnCell = (FZDefaultCarouselCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:FZDefaultCarouselCollectionViewCellIdentifier forIndexPath:indexPath];
	
	if (indexPath.row < _dataArray.count)
	{
		UIImage *tmpImage = _dataArray[indexPath.row];
		rtnCell.imageView.image = tmpImage;
	}
	return rtnCell;
}

@end




@implementation FZDefaultCarouselCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		[self setupImageView];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setupImageView];
	}
	return self;
}

- (void)setupImageView
{
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
	[self.imageView setTranslatesAutoresizingMaskIntoConstraints: NO];
	[self addSubview:self.imageView];
	NSDictionary *views = NSDictionaryOfVariableBindings(_imageView);
	NSArray *topAndBottom = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:@{} views:views];
	NSArray *leftAndRight = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:@{} views:views];
	[self addConstraints:topAndBottom];
	[self addConstraints:leftAndRight];
}

@end