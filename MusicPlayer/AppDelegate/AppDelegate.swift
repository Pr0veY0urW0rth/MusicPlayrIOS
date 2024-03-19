//
//  AppDelegate.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 10.10.2022.
//  Copyright © 2022 ProveY0urWorth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        let vcex : UIViewController
        if(UserManager.isLoggedIn && SpotifyAuthManager.shared.isSignedIn){
            vcex = NavTapBar()
        }
        else{
            if(!UserManager.isLoggedIn){
                vcex = AuthViewController()
            }
            else{
                vcex = SpotifyAuthViewController()
            }
        }
        let navController = UINavigationController()
        navController.setViewControllers([vcex], animated: true)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
    
    func switchControllers(viewControllerToBeDismissed:UIViewController,controllerToBePresented:UIViewController) {
            if (viewControllerToBeDismissed.isViewLoaded && (viewControllerToBeDismissed.view.window != nil)) {
                // viewControllerToBeDismissed is visible
                //First dismiss and then load your new presented controller
                viewControllerToBeDismissed.dismiss(animated: false, completion: {
                    self.window?.rootViewController?.present(controllerToBePresented, animated: true, completion: nil)
                })
            } else {
            }
        }}
