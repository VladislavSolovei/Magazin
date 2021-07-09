//
//  AppDelegate.swift
//  Magazin
//
//  Created by Sergey Shinkarenko on 30.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        let str = "g5[j2[v]k]7[y]"

        func decrypt(encrypted string: String) -> String {
            var currentMultiplier = 0
            var resultString = ""
            var currentString = ""
            var inside = false
            var skipNextBracet = false

            for character in string {
                if character == "[" {
                    if inside {
                        skipNextBracet = true
                    } else {
                        inside = true
                        continue
                    }
                }
                if character == "]" {
                    if skipNextBracet {
                        skipNextBracet = false
                    } else {
                        inside = false
                        let midResult = String(repeating: decrypt(encrypted: currentString), count: currentMultiplier)
                        resultString.append(midResult)
                        currentString = ""
                        currentMultiplier = 0
                        continue
                    }
                }
                if inside {
                    currentString.append(character)
                    continue
                }
                if let multiplier = Int("\(character)") {
                    currentMultiplier = multiplier
                    continue
                }
                if currentMultiplier == 0 {
                    resultString.append(character)
                } else {
                    currentString.append(character)
                }
            }
            return resultString
        }

        print(decrypt(encrypted: str))
        
        
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

