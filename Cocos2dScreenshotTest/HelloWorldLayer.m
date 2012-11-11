//
//  HelloWorldLayer.m
//  Cocos2dScreenshotTest
//
//  Created by リタ on 2012/11/10.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#import "CCDirector+ScreenShot.h"
#import "CCNode+Screenshot.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		CGSize winSize = [CCDirector sharedDirector].winSize;
		
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"button.plist" textureFilename:@"button.png"];
		
		// 背景
		CCSprite *bg = [CCSprite spriteWithFile:@"bg.jpg"];
		bg.position = ccp(winSize.width * 0.5f,winSize.height * 0.5f);
		[self addChild:bg z:0];
		
		// Sprite
		CCSprite *sprite = [CCSprite spriteWithFile:@"sprite.png"];
		sprite.position = ccp(winSize.width * 0.5f,winSize.height * 0.6f);
		[self addChild:sprite z:50];
		
		// セリフ枠
		CCSprite *frame = [CCSprite spriteWithFile:@"frame.png"];
		frame.position = ccp(winSize.width * 0.5f,winSize.height * 0.35f);
		[self addChild: frame z:50];
		
		// セリフ枠に表示する文章
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"SSボタンを押すとスクリーンショットを撮影してフォトアルバムに保存します"
											 dimensions:CGSizeMake(winSize.width - 20,100)
											  hAlignment:UITextAlignmentLeft
											   fontName:@"Helvetica" fontSize:18];
		label.position = ccp(winSize.width * 0.5f,winSize.height * 0.33f);
		[self addChild:label z:60];
		
		
		// メニュー
		CCMenuItemImage *menuItemImage1 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button-hd.png"]
																 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_selected-hd.png"]
																		  block:^(id sender) {
																			  UIImage *image = [[CCDirector sharedDirector] takeSS1];
																			  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
																			  
																			  CCLOG(@"Save screenshot to photo album.1");
																		  }];
		menuItemImage1.position = ccp(winSize.width * 0.125f,winSize.height * 0.15f);
		CCMenuItemImage *menuItemImage2 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button-hd.png"]
																 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_selected-hd.png"]
																		  block:^(id sender) {
																			  UIImage *image = [[CCDirector sharedDirector] takeSS2];
																			  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
																			  
																			  CCLOG(@"Save screenshot to photo album.2");
																		  }];
		menuItemImage2.position = ccp(winSize.width * 0.375f,winSize.height * 0.15f);
		CCMenuItemImage *menuItemImage3 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button-hd.png"]
																 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_selected-hd.png"]
																		  block:^(id sender) {
																			  UIImage *image = [[CCDirector sharedDirector] takeSS3];
																			  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
																			  
																			  CCLOG(@"Save screenshot to photo album.3");
																		  }];
		menuItemImage3.position = ccp(winSize.width * 0.625f,winSize.height * 0.15f);
		CCMenuItemImage *menuItemImage4 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"button-hd.png"]
																 selectedSprite:[CCSprite spriteWithSpriteFrameName:@"button_selected-hd.png"]
																		  block:^(id sender) {
																			  [self getScreenshot:^(UIImage *image) {
																				  UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
																				  
																				  CCLOG(@"Save screenshot to photo album.4");
																			  }];
																		  }];
		menuItemImage4.position = ccp(winSize.width * 0.875f,winSize.height * 0.15f);
		CCMenu *menu = [CCMenu menuWithItems:menuItemImage1,menuItemImage2,menuItemImage3,menuItemImage4, nil];
		menu.position = ccp(0,0);
		[self addChild:menu z:50];
		
		// メニューラベル
		CCLabelTTF *menuLabel1 = [CCLabelTTF labelWithString:@"SS1"
												  dimensions:menuItemImage1.contentSize
												   hAlignment:UITextAlignmentCenter
													fontName:@"Helvetica" fontSize:14];
		menuLabel1.position = ccp(winSize.width * 0.125f,winSize.height * 0.15f);
		CCLabelTTF *menuLabel2 = [CCLabelTTF labelWithString:@"SS2"
												  dimensions:menuItemImage2.contentSize
												   hAlignment:UITextAlignmentCenter
													fontName:@"Helvetica" fontSize:14];
		menuLabel2.position = ccp(winSize.width * 0.375f,winSize.height * 0.15f);
		CCLabelTTF *menuLabel3 = [CCLabelTTF labelWithString:@"SS3"
												  dimensions:menuItemImage3.contentSize
												   hAlignment:UITextAlignmentCenter
													fontName:@"Helvetica" fontSize:14];
		menuLabel3.position = ccp(winSize.width * 0.625f,winSize.height * 0.15f);
		CCLabelTTF *menuLabel4 = [CCLabelTTF labelWithString:@"SS4"
												  dimensions:menuItemImage3.contentSize
												   hAlignment:UITextAlignmentCenter
													fontName:@"Helvetica" fontSize:14];
		menuLabel4.position = ccp(winSize.width * 0.875f,winSize.height * 0.15f);
		
		[self addChild: menuLabel1 z:60];
		[self addChild: menuLabel2 z:60];
		[self addChild: menuLabel3 z:60];
		[self addChild: menuLabel4 z:60];
		
		// パーティクル
		/*
		id particle = [CCParticleSystemQuad particleWithFile:@"p_light.plist"];
		[particle setPosition:ccp(winSize.width * 0.5f,winSize.height * 0.5f)];
		[particle setAutoRemoveOnFinish:YES];
		[self addChild:particle z:10];
		*/
		
		
		// iAd
		adView = [[ADBannerView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
		adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
		adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		adView.delegate = self;
		
		AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
		[[[app navController] view] addSubview:adView];
	}
	return self;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
	
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}



@end
