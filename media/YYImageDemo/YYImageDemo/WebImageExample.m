//
//  WebImageExample.m
//  YYImageDemo
//
//  Created by 杨晴贺 on 15/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//


#import "WebImageExample.h"
#import "UIView+YYAdd.h"
#import <YYWebImage/YYWebImage.h>
#define kCellHeight ceil(([UIScreen mainScreen].bounds.size.width) * 3.0 / 4.0)

@interface WebImageExampleCell : UITableViewCell

@property (nonatomic,strong) YYAnimatedImageView *webImageView ;
@property (nonatomic,strong) UIActivityIndicatorView *indicator ;
@property (nonatomic,strong) CAShapeLayer *progressLayer ;
@end

@implementation WebImageExampleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor] ;
        self.contentView.backgroundColor = [UIColor clearColor] ;
        self.size = CGSizeMake([UIScreen mainScreen].bounds.size.width,kCellHeight) ;
        _webImageView = [[YYAnimatedImageView alloc]init] ;
        _webImageView.size = self.size ;
        _webImageView.clipsToBounds = YES ;
        _webImageView.contentMode = UIViewContentModeScaleAspectFill ;
        _webImageView.backgroundColor = [UIColor whiteColor] ;
        [self.contentView addSubview:_webImageView] ;
        
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
        _indicator.center = CGPointMake(self.width / 2 , self.height / 2) ;
        _indicator.hidden = YES ;
        [self.contentView addSubview:_indicator] ;
        
        
        CGFloat lineHeight = 4;
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame =  CGRectMake(0, 0, _webImageView.width, lineHeight) ;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, _progressLayer.frame.size.height / 2)];
        [path addLineToPoint:CGPointMake(_webImageView.width, _progressLayer.frame.size.height / 2)];
        _progressLayer.lineWidth = lineHeight;
        _progressLayer.path = path.CGPath;
        _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
        _progressLayer.lineCap = kCALineCapButt;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
        [_webImageView.layer addSublayer:_progressLayer];
    }
    
    return self ;
}

- (void)setImageURL:(NSURL *)url{
    _indicator.hidden = NO ;
    [_indicator startAnimating] ;
    __weak typeof (self) __self = self ;
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    [_webImageView yy_setImageWithURL:url
                          placeholder:nil
                              options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (expectedSize > 0 && receivedSize > 0) {
            CGFloat progress = (CGFloat)receivedSize / expectedSize;
            progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
            if (__self.progressLayer.hidden) __self.progressLayer.hidden = NO;
            __self.progressLayer.strokeEnd = progress;
        }
    } transform:nil
      completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (stage == YYWebImageStageFinished) {
            __self.progressLayer.hidden = YES;
            [__self.indicator stopAnimating];
            __self.indicator.hidden = YES;
        }
    }] ;
}

@end

@interface WebImageExample ()

@property (nonatomic,strong) NSArray *imageLinks ;


@end

@implementation WebImageExample

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.tableView.bounds] ;
    imageView.image = [UIImage imageNamed:@"1"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    self.tableView.backgroundView = imageView ;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    self.navigationItem.rightBarButtonItem = button;
    self.view.backgroundColor = [UIColor colorWithWhite:0.217 alpha:1.000];
    
    [self scrollViewDidScroll:self.tableView];
}



- (NSArray *)imageLinks{
    if (!_imageLinks) {
        _imageLinks = @[
                           /*
                            You can add your image url here.
                            */
                           
                           // progressive jpeg
                           @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                           
                           // animated gif: http://cinemagraphs.com/
                           @"http://i.imgur.com/uoBwCLj.gif",
                           @"http://i.imgur.com/8KHKhxI.gif",
                           @"http://i.imgur.com/WXJaqof.gif",
                           
                           // animated gif: https://dribbble.com/markpear
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                           
                           // animaged gif: https://dribbble.com/jonadinges
                           @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                           @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                           
                           // jpg: https://dribbble.com/snootyfox
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                           @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                           
                           // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                           @"http://littlesvr.ca/apng/images/BladeRunner.png",
                           @"http://littlesvr.ca/apng/images/Contact.webp",
                           ];
    }
    return _imageLinks ;

}

- (void)reload{
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{}];
    [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.1] ;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageLinks.count * 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WebImageExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) cell = [[WebImageExampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [cell setImageURL:[NSURL URLWithString:_imageLinks[indexPath.row % _imageLinks.count]]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    for (WebImageExampleCell *cell in [self.tableView visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 8) {
            [UIView animateWithDuration:0.15
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:NULL];
        } else {
            cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}


@end
