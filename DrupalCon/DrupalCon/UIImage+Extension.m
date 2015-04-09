//
//  UIImage+Extension.h
//  DrupalCon
//
//  Created by Volodymyr Hyrka on 3/12/15.
//  Copyright (c) 2015 Lemberg Solution. All rights reserved.
//

#import "UIImage+Extension.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (initWithColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *)splashImageNameForOrientation:(UIInterfaceOrientation)orientation
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = @"Portrait";
    
    if (UIDeviceOrientationIsLandscape(orientation))
    {
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
        viewOrientation = @"Landscape";
    }
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            return dict[@"UILaunchImageName"];
    }
    return nil;
}

+ (UIImage*)splashImageForOrientation:(UIInterfaceOrientation)orientation
{
    NSString *imageName = [self splashImageNameForOrientation:orientation];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end