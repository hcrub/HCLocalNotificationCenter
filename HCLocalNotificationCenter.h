//
//  HCLocalNotificationCenter
//
//  Created by Neil Burchfield on 1/27/14.
//  Copyright (c) 2014 Neil Burchfield. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HCLocalNotificationHandlingKeyName;
extern NSString *const HCApplicationDidReceiveLocalNotification;

typedef void (^HCLocalNotificationHandler)(NSString *key, NSDictionary *userInfo);

@interface HCLocalNotificationCenter : NSObject
@property (assign, nonatomic) HCLocalNotificationHandler localNotificationHandler;

+ (HCLocalNotificationCenter *)sharedCenter;
- (NSArray *)                  localNotifications;

- (void)didReceiveLocalNotificationUserInfo:(NSDictionary *)userInfo;
- (void)cancelAllLocalNotifications;
- (void)cancelLocalNotification:(UILocalNotification *)localNotification;
- (void)cancelLocalNotificationForKey:(NSString *)key;

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody;

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                   userInfo:(NSDictionary *)userInfo;

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                   userInfo:(NSDictionary *)userInfo
                 badgeCount:(NSInteger)badgeCount;

- (void)postNotificationNow:(NSString *)key
                  alertBody:(NSString *)alertBody
                alertAction:(NSString *)alertAction
                  soundName:(NSString *)soundName
                launchImage:(NSString *)launchImage
                   userInfo:(NSDictionary *)userInfo
                 badgeCount:(NSUInteger)badgeCount
             repeatInterval:(NSCalendarUnit)repeatInterval;

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody;

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
                userInfo:(NSDictionary *)userInfo;

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSInteger)badgeCount;

- (void)postNotification:(NSDate *)fireDate
                  forKey:(NSString *)key
               alertBody:(NSString *)alertBody
             alertAction:(NSString *)alertAction
               soundName:(NSString *)soundName
             launchImage:(NSString *)launchImage
                userInfo:(NSDictionary *)userInfo
              badgeCount:(NSUInteger)badgeCount
          repeatInterval:(NSCalendarUnit)repeatInterval;

@end
