//
//  SceneDelegate.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
         
        let window = UIWindow(windowScene: windowScene)
        if AuthManager.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        } else {
            let navVc = UINavigationController(rootViewController: WelcomeViewController())
            navVc.navigationBar.prefersLargeTitles = true
            navVc.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVc
        }
        
         window.makeKeyAndVisible()
         self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        // Ensure the URL matches your custom scheme
//            if url.scheme == "gopal-dev.gopal", url.host == "callback" {
//                if let code = URLComponents(string: url.absoluteString)?
//                    .queryItems?.first(where: { $0.name == "code" })?.value {
//                    print("Authorization Code: \(code)")
//                    // Exchange the code for an access token
//                }
//                return true
//            }
//            return false
//    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        

        if url.scheme == "gopal-dev.gopal", url.host == "callback" {
            
            if let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                
                let controllers = navController.viewControllers
                
                print(controllers)
                
                if controllers.count > 1 , let rootVC = controllers[1] as? AuthViewController, let welcomeVC = controllers.first as? WelcomeViewController {
                    rootVC.safariVC?.dismiss(animated: true)
                    if let code = URLComponents(string: url.absoluteString)?
                        .queryItems?.first(where: { $0.name == "code" })?.value {
                        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
                            DispatchQueue.main.async {
                                welcomeVC.handleSignIn(success: success)
                            }
                        }
                    }
                }
            }
        }
    }
}

