//
//  CCDirector+ScreenShot.m
//  ParticleTextureTest
//
//  Created by リタ on 2012/11/10.
//
//

#import "CCDirector+ScreenShot.h"

#import "cocos2d.h"

@implementation CCDirector (ScreenShot)


-(UIImage*) takeSS1
{
	CGSize displaySize	= [self winSizeInPixels];
	CGSize winSize		= [self winSizeInPixels];
	
	//Create buffer for pixels
	GLuint bufferLength = displaySize.width * displaySize.height * 4;
	GLubyte* buffer = (GLubyte*)malloc(bufferLength);
	
	//Read Pixels from OpenGL
	glReadPixels(0, 0, displaySize.width, displaySize.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	//Make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
	
	//Configure image
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * displaySize.width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef iref = CGImageCreate(displaySize.width, displaySize.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
	
	uint32_t* pixels = (uint32_t*)malloc(bufferLength);
	CGContextRef context = CGBitmapContextCreate(pixels, winSize.width, winSize.height, 8, winSize.width * 4, CGImageGetColorSpace(iref), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	CGContextTranslateCTM(context, 0, displaySize.height);
	CGContextScaleCTM(context, 1.0f, -1.0f);
	
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	switch (orientation)
	{
		case UIDeviceOrientationPortrait: break;
		case UIDeviceOrientationPortraitUpsideDown:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(180));
			CGContextTranslateCTM(context, -displaySize.width, -displaySize.height);
			break;
		case UIDeviceOrientationLandscapeLeft:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(-90));
			CGContextTranslateCTM(context, -displaySize.height, 0);
			break;
		case UIDeviceOrientationLandscapeRight:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(90));
			CGContextTranslateCTM(context, displaySize.width * 0.5f, -displaySize.height);
			break;
        case UIDeviceOrientationUnknown:
            break;
        case UIDeviceOrientationFaceUp:
            break;
        case UIDeviceOrientationFaceDown:
            break;
	}
	
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, displaySize.width, displaySize.height), iref);
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	UIImage *outputImage = [UIImage imageWithCGImage:imageRef];
	
	//Dealloc
	CGImageRelease(imageRef);
	CGDataProviderRelease(provider);
	CGImageRelease(iref);
	CGColorSpaceRelease(colorSpaceRef);
	CGContextRelease(context);
	free(buffer);
	free(pixels);
	
	return outputImage;
}

-(UIImage*) takeSS2
{
	self.nextDeltaTimeZero = YES;
	
	CCLayerColor* whitePage = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 0) width:self.winSize.width height:self.winSize.height];
	whitePage.position = ccp(self.winSize.width / 2, self.winSize.height / 2);
	
	CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:self.winSize.width height:self.winSize.height];
	[rtx begin];
	[whitePage visit];
	[[self runningScene] visit];
	[rtx end];
	
	return [rtx getUIImage];
}

-(UIImage*) takeSS3
{
	self.nextDeltaTimeZero = YES;
	
    CCRenderTexture* rtx = [CCRenderTexture renderTextureWithWidth:self.winSize.width height:self.winSize.height];
    [rtx beginWithClear:0 g:0 b:0 a:1.0f];
    [[self runningScene] visit];
    [rtx end];
	
    return [rtx getUIImage];
}

@end
