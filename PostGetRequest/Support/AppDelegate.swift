//
//  AppDelegate.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 28.01.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var bgSessionCompletionHandler: (()->())?
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionCompletionHandler = completionHandler
        
    }

}

