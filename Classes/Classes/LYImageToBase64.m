//
//  LYImageToBase64.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "LYImageToBase64.h"
#import <math.h>

@implementation LYImageToBase64

+ (NSString *)imageToBase64:(NSString *)url {
    UIImage *image = [UIImage imageWithContentsOfFile:url];
    
    UIImage *scaledImage = [LYImageToBase64 compressImage:image];
    
    NSData *data = UIImageJPEGRepresentation(scaledImage, 1.0);
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (UIImage *)compressImage:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    CGFloat newWidth = width;
    CGFloat newHeight = height;
    
    if (width <= 1280 && height <= 1280) {
        newWidth = width;
        newHeight = height;
    } else if ((width > 1280 || height > 1280) && width/height <= 2.0) {
        if (width > height) {
            newWidth = 1280;
            newHeight = 1280 * height / width;
        } else {
            newWidth = 1280 * width / height;
            newHeight = 1280;
        }
    } else if ((width > 1280 || height > 1280) && width/height > 2.0 && (width < 1280 || height < 1280)) {
        newWidth = width;
        newHeight = height;
    } else if (width > 1280 && height > 1280 && width/height > 2.0) {
        if (width > height) {
            newWidth = 1280 * width / height;
            newHeight = 1280;
        } else {
            newWidth = 1280;
            newHeight = 1280 * height / width;
        }
    }
    
    CGSize size = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *newData = UIImageJPEGRepresentation(scaledImage, 0.5);
    
    return [UIImage imageWithData:newData];
}

@end
