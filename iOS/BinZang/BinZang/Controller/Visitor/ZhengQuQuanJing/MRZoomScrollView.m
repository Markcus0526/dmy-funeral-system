//
//  ZhengQuQuanJingVC.m
//  BinZang
//
//  Created by RyuCholJin on 4/14/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MRZoomScrollView.h"
#import "ConstString.h"
#import "KGModal.h"
#import "UIImageView+AFNetworking.h"

#define MRScreenWidth      1000//CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     667//CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView ()


- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@property (nonatomic, assign) CGSize prevBoundsSize;
@property (nonatomic, assign) CGPoint prevContentOffset;
@property (nonatomic, strong, readwrite) UIView *viewForZooming;
@property (nonatomic, strong, readwrite) UITapGestureRecognizer *doubleTapGestureRecognizer;

@end

#define TITLE_TAG_PLUS		10000
#define TITLE_HEIGHT		18
#define TITLE_COLOR			[UIColor whiteColor]

@implementation MRZoomScrollView

{
	UIImage *ptImg1;
	UIImage *ptImg2;
}

@synthesize nSelectIndex;
@synthesize parentVC;

- (id)initWithFrame:(CGRect)frame {
	ptImg1 = [UIImage imageNamed:@"preset_imgmap_poi_tablet.png"];
	ptImg2 = [UIImage imageNamed:@"preset_imgmap_poi_site.png"];

    self = [super initWithFrame:frame];
    if (self) {
        [self performInitialisation];
    }
    
    nIdScene = 0;
    return self;
}


#pragma mark - Zoom methods
- (void)performInitialisation {
    // Set the prevBoundsSize to the initial bounds, so the first time layoutSubviews
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_image.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    self.maximumZoomScale = 2.5;
    // self.delegate = self;
    
    self.contentSize = imageView.frame.size;
    self.alwaysBounceVertical = YES;
    self.alwaysBounceHorizontal = YES;
    self.stickToBounds = YES;
    [self addViewForZooming:imageView];
    [self scaleToFit];
    
    // is called we won't do any contentOffset adjustments
    self.prevBoundsSize = self.bounds.size;
    self.prevContentOffset = self.contentOffset;
    self.fitOnSizeChange = NO;
    self.upscaleToFitOnSizeChange = YES;
    self.stickToBounds = NO;
    self.centerZoomingView = YES;
	self.bounces = NO;
	
    // Add double-tap-gesture-recognizer to zoom in and out when user double taps.
    self.doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_doubleTapped:)];
    self.doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:self.doubleTapGestureRecognizer];
    
    
    //CGFloat scrRate = MAPIMG_HEIGHT / _scrollView.bounds.size.height;
    //[_scrollView setContentSize:CGSizeMake(MAPIMG_WIDTH / scrRate, _scrollView.bounds.size.height)];
    
    
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [self _centerScrollViewContent];
}

- (void)setZoomScale:(CGFloat)zoomScale {
    [super setZoomScale:zoomScale];
    // On iPhone 6+ iOS8, after setting zoomScale content, the contentSize becomes slightly bigger than bounds (e.g. 0.00001)
    self.contentSize = CGSizeMake(floorf(self.contentSize.width), floorf(self.contentSize.height));
}

- (void)scaleToFit {
    if (![self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) return;
    [self _setMinimumZoomScaleToFit];
    self.zoomScale = self.minimumZoomScale;
}

- (void)addViewForZooming:(UIView *)view {
    if (self.viewForZooming) {
        [self.viewForZooming removeFromSuperview];
    }
    self.viewForZooming = view;
    [self addSubview:self.viewForZooming];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //[self updateAreaPointsView:scrollView.zoomScale];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGSizeEqualToSize(self.prevBoundsSize, self.bounds.size)) {
        if (self.fitOnSizeChange) {
            [self scaleToFit];
        } else {
            [self _adjustContentOffset];
        }
        self.prevBoundsSize = self.bounds.size;
    }
    self.prevContentOffset = self.contentOffset;
    
    [self _centerScrollViewContent];
}

- (void)_centerScrollViewContent {
    if (self.centerZoomingView && [self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        UIView *zoomView = [self.delegate viewForZoomingInScrollView:self];
        
        CGRect frame = zoomView.frame;
        if (self.contentSize.width < self.bounds.size.width) {
            frame.origin.x = roundf((self.bounds.size.width - self.contentSize.width) / 2);
        } else {
            frame.origin.x = 0;
        }
        if (self.contentSize.height < self.bounds.size.height) {
            frame.origin.y = roundf((self.bounds.size.height - self.contentSize.height) / 2);
        } else {
            frame.origin.y = 0;
        }
        zoomView.frame = frame;
    }
    [self updateAreaPointsView:self.zoomScale];
}

- (void)_adjustContentOffset {
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        UIView *zoomView = [self.delegate viewForZoomingInScrollView:self];
        
        // Using contentOffset and bounds values before the bounds were changed (e.g.: interface orientation change),
        // find the visible center point in the unscaled coordinate space of the zooming view.
        CGPoint prevCenterPoint = (CGPoint){
            .x = (self.prevContentOffset.x + roundf(self.prevBoundsSize.width / 2) - zoomView.frame.origin.x) / self.zoomScale,
            .y = (self.prevContentOffset.y + roundf(self.prevBoundsSize.height / 2) - zoomView.frame.origin.y) / self.zoomScale,
        };
        
        if (self.stickToBounds) {
            if (self.contentSize.width > self.prevBoundsSize.width) {
                if (self.prevContentOffset.x == 0) {
                    prevCenterPoint.x = 0;
                } else if (self.prevContentOffset.x + self.prevBoundsSize.width == roundf(self.contentSize.width)) {
                    prevCenterPoint.x = zoomView.bounds.size.width;
                }
            }
            if (self.contentSize.height > self.prevBoundsSize.height) {
                if (self.prevContentOffset.y == 0) {
                    prevCenterPoint.y = 0;
                } else if (self.prevContentOffset.y + self.prevBoundsSize.height == roundf(self.contentSize.height)) {
                    prevCenterPoint.y = zoomView.bounds.size.height;
                }
            }
        }
        
        // If the size of the scrollView was changed such that the minimumZoomScale is increased
        if (self.upscaleToFitOnSizeChange) {
            [self _increaseScaleIfNeeded];
        }
        
        // Calculate new contentOffset using the previously calculated center point and the new contentOffset and bounds values.
        CGPoint contentOffset = CGPointMake(0.0, 0.0);
        CGRect frame = zoomView.frame;
        if (self.contentSize.width > self.bounds.size.width) {
            frame.origin.x = 0;
            contentOffset.x = prevCenterPoint.x * self.zoomScale - roundf(self.bounds.size.width / 2);
            if (contentOffset.x < 0) {
                contentOffset.x = 0;
            } else if (contentOffset.x > self.contentSize.width - self.bounds.size.width) {
                contentOffset.x = self.contentSize.width - self.bounds.size.width;
            }
        }
        if (self.contentSize.height > self.bounds.size.height) {
            frame.origin.y = 0;
            contentOffset.y = prevCenterPoint.y * self.zoomScale - roundf(self.bounds.size.height / 2);
            if (contentOffset.y < 0) {
                contentOffset.y = 0;
            } else if (contentOffset.y > self.contentSize.height - self.bounds.size.height) {
                contentOffset.y = self.contentSize.height - self.bounds.size.height;
            }
        }
        zoomView.frame = frame;
        self.contentOffset = contentOffset;
    }
}

- (void)_increaseScaleIfNeeded {
    [self _setMinimumZoomScaleToFit];
    if (self.zoomScale < self.minimumZoomScale) {
        self.zoomScale = self.minimumZoomScale;
    }
}

- (void)_setMinimumZoomScaleToFit {
    UIView *zoomView = [self.delegate viewForZoomingInScrollView:self];
    CGSize scrollViewSize = self.bounds.size;
    CGSize zoomViewSize = zoomView.bounds.size;
    
    CGFloat scaleToFit = fmaxf(scrollViewSize.width / zoomViewSize.width, scrollViewSize.height / zoomViewSize.height);
    if (scaleToFit > 1.0) {
        scaleToFit = 1.0;
    }
    self.minimumZoomScale = scaleToFit;
}

- (void)_doubleTapped:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        UIView *zoomView = [self.delegate viewForZoomingInScrollView:self];
        
        if (self.zoomScale == self.minimumZoomScale) {
            // When user double-taps on the scrollView while it is zoomed out, zoom-in
            CGFloat newScale = self.maximumZoomScale;
            CGPoint centerPoint = [gestureRecognizer locationInView:zoomView];
            CGRect zoomRect = [self _zoomRectInView:self forScale:newScale withCenter:centerPoint];
            [self zoomToRect:zoomRect animated:YES];
        } else {
            // When user double-taps on the scrollView while it is zoomed, zoom-out
            [self setZoomScale:self.minimumZoomScale animated:YES];
        }
    }
}

- (CGRect)_zoomRectInView:(UIView *)view forScale:(CGFloat)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the scrollView's bounds.
    // As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = view.bounds.size.height / scale;
    zoomRect.size.width = view.bounds.size.width / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale animated:NO];
}


///////////////////////////////////////////////////////////////////////////
#pragma mark - pinch and tap event method

#pragma mark - user defined method
- (void) loadAreaPointsView:(NSMutableArray *)datalist
{
    areaPoints = datalist;
    
    NSArray *array = [NSArray arrayWithArray:areaPoints];
    
	int nCurWidth = _viewForZooming.frame.size.width;
	int nCurHeight = _viewForZooming.frame.size.height;
	
    for (int i = 0; i < array.count; i++)
    {
        STAreaPoint *point = (STAreaPoint*)array[i];
        UIImage *btnImage = nil;
        
        if ( nIdScene == 1 && point.type == 2 )
        {
            btnImage = ptImg1;
        }
        else if ( nIdScene == 0 && point.type == 0 )
        {
            btnImage = ptImg2;
        }
        else if ( nIdScene == 0 && point.type == 1 )
        {
            btnImage = ptImg1;
        }
        else
            continue;
        
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:point.uid];
        //[btn setTag:i];
        [btn addTarget:self action:@selector(pointClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setBorderWidth:0];
        [btn setBackgroundImage:btnImage forState:UIControlStateNormal];
		
		CGFloat posX = point.x_rate * nCurWidth - btnImage.size.width/2;
		CGFloat posY = point.y_rate * nCurHeight - btnImage.size.height;
		
        [btn setFrame:CGRectMake(posX, posY, btnImage.size.width, btnImage.size.height)];
        [btn setExclusiveTouch:YES];
        
        [self addSubview:btn];
	}
	
	for (int i = 0; i < areaPoints.count; i++)
	{
		STAreaPoint *point = [areaPoints objectAtIndex:i];
		UIImage *btnImage = nil;
		
		if ( nIdScene == 1 && point.type == 2 )
		{
			btnImage = ptImg1;
		}
		else if ( nIdScene == 0 && point.type == 0 )
		{
			btnImage = ptImg2;
		}
		else if ( nIdScene == 0 && point.type == 1 )
		{
			btnImage = ptImg1;
		}
		else
			continue;
		
		UILabel *label = [[UILabel alloc] init];
		label.text = point.name;
		label.font = [UIFont systemFontOfSize:TITLE_HEIGHT weight:2];
		label.textColor = TITLE_COLOR;
		label.shadowColor = [UIColor blackColor];
		label.shadowOffset = CGSizeMake(1, 1);
		[label setTag:point.uid + TITLE_TAG_PLUS];
		[label sizeToFit];
		
		CGFloat posX = point.x_rate * nCurWidth - label.frame.size.width/2;
		CGFloat posY = point.y_rate * nCurHeight - btnImage.size.height - label.frame.size.height - 2;
		[label setFrame:CGRectMake(posX, posY, label.frame.size.width, label.frame.size.height)];
		[self addSubview:label];
	}
}

- (void) removeAllButtons
{
    NSArray *array = [NSArray arrayWithArray:areaPoints];
	
    for (int i = 0; i < array.count; i++)
	{
        STAreaPoint *point = (STAreaPoint*)array[i];
		UIButton *button = (UIButton *)[self viewWithTag:point.uid];
		if (button)
			[button removeFromSuperview];

		UILabel *label = (UILabel*)[self viewWithTag:point.uid + TITLE_TAG_PLUS];
		if (label)
			[label removeFromSuperview];
    }
}

- (void) updateAreaPointsView:(CGFloat)scale
{
	int nCurWidth = _viewForZooming.frame.size.width;
	int nCurHeight = _viewForZooming.frame.size.height;
	
    NSArray *array = [NSArray arrayWithArray:areaPoints];
    for (int i = 0; i < array.count; i++)    {
        STAreaPoint *point = (STAreaPoint*)array[i];
        UIImage *btnImage = nil;
        if ( nIdScene == 1 && point.type == 2 )
        {
            btnImage = ptImg1;
        }
        else if ( nIdScene == 0 && point.type == 0 )
        {
            btnImage = ptImg2;
        }
        else if ( nIdScene == 0 && point.type == 1 )
        {
            btnImage = ptImg1;
        }
        else
            continue;
            
		MyLog(@"scale : %f", scale);
		
        //UIButton *btn = (UIButton *)[self viewWithTag:i];
        UIButton *btn = (UIButton *)[self viewWithTag:point.uid];
        if ( btn == nil )
            continue;
        
        CGRect frame = btn.frame;
        
        frame.origin.x = point.x_rate * nCurWidth - btnImage.size.width/2 + _viewForZooming.frame.origin.x;
        frame.origin.y = point.y_rate * nCurHeight - btnImage.size.height + _viewForZooming.frame.origin.y;
        btn.autoresizingMask = UIViewAutoresizingNone;
        btn.frame = frame;
		
		UILabel *label = (UILabel*)[self viewWithTag:point.uid + TITLE_TAG_PLUS];
		frame = label.frame;
		frame.origin.x = point.x_rate * nCurWidth - label.frame.size.width/2 + _viewForZooming.frame.origin.x;
		frame.origin.y = point.y_rate * nCurHeight - btnImage.size.height + _viewForZooming.frame.origin.y - label.frame.size.height - 2;
		label.frame = frame;
    }
}

-(void) pointClicked:(UIButton*)sender
{
    //NSLog(@"you clicked on button %@", sender.tag);
    nSelectIndex = (int)sender.tag;
    NSArray *array = [NSArray arrayWithArray:areaPoints];
    
    STAreaPoint *point = nil;
    for ( int i = 0; i < array.count; i++ )
    {
        STAreaPoint *curPoint = (STAreaPoint *)array[i];
        if ( nSelectIndex == curPoint.uid )
        {
            point = curPoint;
            break;
        }
    }
    if ( point == nil )
        return;
    
    //point = (STAreaPoint*)array[nSelectIndex];
	
	CGRect frame = self.frame;
	
	CGFloat viewWidth = frame.size.width - 80;
	CGRect viewRect = CGRectMake(0, 0, viewWidth, viewWidth * 1.5);
    UIView *contentView = [[UIView alloc] initWithFrame:viewRect];
    
    CGRect titleLabelRect = contentView.bounds;
    titleLabelRect.origin.y = 20;
    titleLabelRect.size.height = 20;
    UIFont *titleLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelRect];
    titleLabel.text = point.name;//@"Welcome to KGModal!";
    titleLabel.font = titleLabelFont;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:titleLabel];
	
	CGFloat imgWidth = viewRect.size.width - 20;
	CGFloat imgHeight = imgWidth / 2;
	
	CGRect imgRect = CGRectMake((viewRect.size.width - imgWidth) / 2, CGRectGetMaxY(titleLabelRect)+ 20, imgWidth, imgHeight);
	
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgRect];
	imgView.contentMode = UIViewContentModeScaleAspectFit;
	[imgView setImageWithURL:[NSURL URLWithUnicodeString:point.image_url] placeholderImage:DEF_IMAGE];
	[contentView addSubview:imgView];
	
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(imgRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = point.contents;
    infoLabel.numberOfLines = 8;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES nSelIndex:(int)point.uid];
}

- (void) changeScene
{
    if ( nIdScene == 0 )
        nIdScene = 1;
    else
        nIdScene = 0;
    
    [self removeAllButtons];
    
    UIImage *image = nil;
    if ( nIdScene == 0 )
    {
        image = [UIImage imageNamed:@"map_image.jpg"];
    }
    else
    {
         image = [UIImage imageNamed:@"map_enterance.png"];
    }
    
    imageView.image = image;
    
    [self loadAreaPointsView:areaPoints];
}

@end
