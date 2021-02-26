//
//  WidgetBridge.swift
//  MyApp
//
//  Created by brian.chen[陳弘毅] on 2021/2/26.
//

import Foundation
import os.log
import WidgetKit

@objc(WidgetBridge)
class WidgetBridge: NSObject {
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @available(iOS 14.0, *)
  @objc(setDict:withValue:withResolver:withRejecter:)
  func setDict(key: String, value: Dictionary<String, Any>,
           resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock
  ) -> Void {
    let userDefaults = UserDefaults(suiteName: "group.widget.store");
    userDefaults?.setValue(value, forKey: key)
    
    resolve(true)
  }
  
  @available(iOS 14.0, *)
  @objc(setValue:withResolver:withRejecter:)
  func setValue(value: String, resolve:RCTPromiseResolveBlock, reject:RCTPromiseRejectBlock) {
    print(value)
    let userDefaults = UserDefaults(suiteName: "group.widget.store");
    userDefaults?.setValue(value, forKey: "text" )
    resolve(true)
  }

  @available(iOS 14.0, *)
  @objc(reloadWidget:withResolver:withRejecter:)
  func reloadWidget(
    kind: String,
    resolve:RCTPromiseResolveBlock,
    reject:RCTPromiseRejectBlock) -> Void {
    print("reload timeline")
    WidgetCenter.shared.reloadAllTimelines()
    
    resolve(true)
  }
}
