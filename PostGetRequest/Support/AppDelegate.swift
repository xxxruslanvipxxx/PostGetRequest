//
//  AppDelegate.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 28.01.24.
//

import UIKit
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var bgSessionCompletionHandler: (()->())?
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionCompletionHandler = completionHandler
        
    }
    
    //MARK: Facebook SDK init methods
    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

            return true
    }

}

