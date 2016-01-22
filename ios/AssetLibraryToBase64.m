#import "RCTBridgeModule.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
@interface ReadImageData : NSObject <RCTBridgeModule>
@end

@implementation ReadImageData

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(readImage:(NSString *)input callback:(RCTResponseSenderBlock)callback)
{

  // Create NSURL from uri
  NSURL *url = [[NSURL alloc] initWithString:input];

  // Create an ALAssetsLibrary instance. This provides access to the
  // videos and photos that are under the control of the Photos application.
  ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

  // Using the ALAssetsLibrary instance and our NSURL object open the image.
  [library assetForURL:url resultBlock:^(ALAsset *asset) {

    // Create an ALAssetRepresentation object using our asset
    // and turn it into a bitmap using the CGImageRef opaque type.
    ALAssetRepresentation *representation = [asset defaultRepresentation];
    CGImageRef imageRef = [representation fullResolutionImage];
    UIImage *sourceImage = [UIImage imageWithCGImage:imageRef];

    // Scale image to fit in 2048x2048
    CGSize maxSize = CGSizeMake(2048, 2048);
    CGSize scaledSize = maxSize;
    float scaleFactor = 1.0;
    if( sourceImage.size.width > sourceImage.size.height ) {
        scaleFactor = sourceImage.size.width / sourceImage.size.height;
        scaledSize.width = maxSize.width;
        scaledSize.height = maxSize.height / scaleFactor;
    }
    else {
        scaleFactor = sourceImage.size.height / sourceImage.size.width;
        scaledSize.height = maxSize.height;
        scaledSize.width = maxSize.width / scaleFactor;
    }

    UIGraphicsBeginImageContextWithOptions( scaledSize, NO, 0.0 );
    CGRect scaledImageRect = CGRectMake( 0.0, 0.0, scaledSize.width, scaledSize.height );
    [sourceImage drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Create UIImageJPEGRepresentation from CGImageRef
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, 1.0);

    // Convert to base64 encoded string
    NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];

    callback(@[base64Encoded]);

  } failureBlock:^(NSError *error) {
    NSLog(@"that didn't work %@", error);
  }];
}

@end