//
//  AppDelegate.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(lengthOfLongestSubstring("aab"))
        return true
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count <= 1 {
            return s.count
        }
        
        var strArray = [String]()
        for c in s {
            strArray.append("\(c)")
        }
        
        var result = 1
        var index = 0
        var array = [String]()
        for str in strArray {
            if array.contains(str) == false {
                array.append(str)
                if array.count > result {
                    result = array.count
                }
            } else {
                if let firstIndex = array.firstIndex(of: str) {
                    if array.count > result {
                        result = array.count
                    }
                    array.append(str)
                    array = mRangeArray(array: array, fromIndx: firstIndex + 1, toIndex: array.count - 1) ?? [String]()
                }
            }
            index = index + 1
        }
        return result
    }
    
     func mRangeArray<T>(array: [T], fromIndx: Int, toIndex: Int) -> [T]? {
        if fromIndx == toIndex, toIndex < array.count {
            return [array[fromIndx]]
        }
        
        var newArray = [T]()
        if fromIndx < toIndex && toIndex < array.count {
            
            for i in fromIndx...toIndex {
                
                newArray.append(array[i])
            }
            return newArray
        }
        return nil
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        //abadda
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

