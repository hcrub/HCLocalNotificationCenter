//
//  HCLocalNotificationCenter
//
//  Created by Neil Burchfield on 1/27/14.
//  Copyright (c) 2014 Neil Burchfield. All rights reserved.
//

#import "HCLocalNotificationCenter.h"

NSString *const HCLocalNotificationHandlingKeyName       = @"HC_KEY";
NSString *const HCApplicationDidReceiveLocalNotification = @"HCApplicationDidReceiveLocalNotification";

@interface HCLocalNotificationCenter ()
@property NSMutableDictionary *localPushDictionary;
@property BOOL                checkRemoteNotificationAvailability;
@end

static HCLocalNotificationCenter *hc_defaultCenter;

@implementation HCLocalNotificationCenter

+ (HCLocalNotificationCenter *)sharedCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hc_defaultCenter = [[HCLocalNotificationCenter alloc] init];
        hc_defaultCenter.localPushDictionary = [[NSMutableDictionary alloc] init];
        [hc_defaultCenter loadScheduledLocalPushNotificationsFromApplication];
        hc_defaultCenter.checkRemoteNotificationAvailability = NO;
        hc_defaultCenter.localNotificationHandler = nil;
    });
    return hc_defaultCenter;
}

- (void)loadScheduledLocalPushNotificationsFromApplication {
    NSArray *scheduleLocalPushNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *localNotification in scheduleLocalPushNotifications) {
        if (localNotification.userInfo[HCLocalNotificationHandlingKeyName]) {
            [self.localPushDictionary setObject:localNotification forKey:localNotification.userInfo[HCLocalNotificationHandlingKeyName]];
        }
    }
}

- (NSArray *)localNotifications {
    return [[NSArray alloc] initWithArray:[self.localPushDictionary allValues]];
}

- (void)didReceiveLocalNotificationUserInfo:(NSDictionary *)userInfo {
    if (!userInfo[HCLocalNotificationHandlingKeyName]) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HCApplicationDidReceiveLocalNotification
                                                        object:nil
                                                      userInfo:userInfo];
    
    if (self.localNotificationHandler) {
        self.localNotificationHandler(userInfo[HCLocalNotificationHandlingKeyName], userInfo);
    }
}

- (void)cancelAllLocalNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self.localPushDictionary removeAllObjects];
}

- (void)cancelLocalNotification:(UILocalNotification *)localNotification {
    if (!localNotification) {
        return;
    }
    
    [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    if (localNotification.userInfo[HCLocalNotificationHandlingKeyName]) {
        [self.localPushDictionary removeObjectForKey:localNotification.userInfo[HCLocalNotificationHandlingKeyName]];
    }
}

- (void)cancelLocalNotificationForKey:(NSString *)key {
    if (!self.localPushDictionary[key]) {
        return;
    }
    
    UILocalNotification *localNotification = self.localPushDictionary[key];
    [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    [self.localPushDictionary removeObjectForKey:key];
}

#pragma mark -
#pragma mark - Post Now - Immediate

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody {
    [self postNotificationNow:YES
                     fireDate:nil
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:nil
                   badgeCount:0
               repeatInterval:0];
}

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                   userInfo:(NSDictionary *)userInfo {
    [self postNotificationNow:YES
                     fireDate:nil
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:userInfo
                   badgeCount:0
               repeatInterval:0];
}

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                   userInfo:(NSDictionary *)userInfo
                 badgeCount:(NSInteger)badgeCount {
    [self postNotificationNow:YES
                     fireDate:nil
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:userInfo
                   badgeCount:badgeCount
               repeatInterval:0];
}

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                alertAction:(NSString *)alertAction
                  soundName:(NSString *)soundName
                launchImage:(NSString *)launchImage
                   userInfo:(NSDictionary *)userInfo
                 badgeCount:(NSUInteger)badgeCount
             repeatInterval:(NSCalendarUnit)repeatInterval {
    [self postNotificationNow:YES
                     fireDate:nil
                       forKey:key
                    alertBody:alertBody
                  alertAction:alertAction
                    soundName:soundName
                  launchImage:launchImage
                     userInfo:userInfo
                   badgeCount:badgeCount
               repeatInterval:repeatInterval];
}

#pragma mark -
#pragma mark - Post on a specific date

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody {
    [self postNotificationNow:NO
                     fireDate:fireDate
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:nil
                   badgeCount:0
               repeatInterval:0];
}

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
                userInfo:(NSDictionary *)userInfo {
    [self postNotificationNow:NO
                     fireDate:fireDate
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:userInfo
                   badgeCount:0
               repeatInterval:0];
}

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSInteger)badgeCount {
    [self postNotificationNow:NO
                     fireDate:fireDate
                       forKey:key
                    alertBody:alertBody
                  alertAction:nil
                    soundName:nil
                  launchImage:nil
                     userInfo:userInfo
                   badgeCount:badgeCount
               repeatInterval:0];
}

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval {
    [self postNotificationNow:NO
                     fireDate:fireDate
                       forKey:key
                    alertBody:alertBody
                  alertAction:alertAction
                    soundName:soundName
                  launchImage:launchImage
                     userInfo:userInfo
                   badgeCount:badgeCount
               repeatInterval:repeatInterval];
}

- (void)postNotificationNow:(BOOL)presentNow
                   fireDate:(NSDate *)fireDate
                     forKey:(NSString *)key
                  alertBody:(NSString *)alertBody
                alertAction:(NSString *)alertAction
                  soundName:(NSString *)soundName
                launchImage:(NSString *)launchImage
                   userInfo:(NSDictionary *)userInfo
                 badgeCount:(NSUInteger)badgeCount
             repeatInterval:(NSCalendarUnit)repeatInterval;
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (!localNotification) {
        return;
    }
    
    UIRemoteNotificationType notificationType = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (self.checkRemoteNotificationAvailability && notificationType == UIRemoteNotificationTypeNone) {
        return;
    }
    
    BOOL needsNotify = NO;
    
    if (self.checkRemoteNotificationAvailability && (notificationType & UIRemoteNotificationTypeAlert) != UIRemoteNotificationTypeAlert) {
        needsNotify = NO;
    } else {
        needsNotify = YES;
    }
    
    NSMutableDictionary *userInfoAddingHandlingKey = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    [userInfoAddingHandlingKey setObject:key forKey:HCLocalNotificationHandlingKeyName];
    localNotification.userInfo         = userInfoAddingHandlingKey;
    localNotification.alertBody        = alertBody;
    localNotification.alertAction      = alertAction;
    localNotification.alertLaunchImage = launchImage;
    localNotification.repeatInterval   = repeatInterval;
    
    if (self.checkRemoteNotificationAvailability && (notificationType & UIRemoteNotificationTypeSound) != UIRemoteNotificationTypeSound) {
        needsNotify = NO;
    } else {
        needsNotify = YES;
    }
    if (soundName) {
        localNotification.soundName = soundName;
    } else {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }
    
    if (self.checkRemoteNotificationAvailability && (notificationType & UIRemoteNotificationTypeBadge) != UIRemoteNotificationTypeBadge) {
    } else {
        localNotification.applicationIconBadgeNumber = badgeCount;
    }
    
    
    if (needsNotify) {
        if (presentNow && !fireDate) {
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
        } else {
            localNotification.fireDate = fireDate;
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
        [self.localPushDictionary setObject:localNotification forKey:key];
    }
}
@end
