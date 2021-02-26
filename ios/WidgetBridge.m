//
//  WidgetBridge.m
//  MyApp
//
//  Created by brian.chen[陳弘毅] on 2021/2/26.
//


#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(WidgetBridge, NSObject)

RCT_EXTERN_METHOD(
                  setDict: (NSString *)key withValue:(NSDictionary *)value
                  withResolver: (RCTPromiseResolveBlock)resolve
                  withRejecter: (RCTPromiseRejectBlock)reject
                  )

RCT_EXTERN_METHOD(
                  reloadWidget: (NSString *)kind
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject
                  )
RCT_EXTERN_METHOD(
                  setValue: (NSString *)value
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject
                  )
@end
