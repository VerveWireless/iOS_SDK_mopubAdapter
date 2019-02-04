//
//  VRVMoPubRewardedViewController.h
//  mopubAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <verveSDK/VRVRewardedAd.h>
#import "VRVRewardedVideoCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVMoPubRewardedViewController : UIViewController <VRVRewardedAdDelegate>

- (instancetype)initWithCustomEvent:(VRVRewardedVideoCustomEvent *)customEvent;

@end

NS_ASSUME_NONNULL_END
