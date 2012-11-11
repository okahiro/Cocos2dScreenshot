//
//  HelloWorldLayer.h
//  Cocos2dScreenshotTest
//
//  Created by リタ on 2012/11/10.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


#import <iAd/iAd.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <ADBannerViewDelegate>
{
	ADBannerView *adView;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
