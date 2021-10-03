//
//  AppDelegate.swift
//  CustomTransition
//
//  Created by Dmitry Vashlaev on 19.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties

    var window: UIWindow?

    // MARK: - UIApplicationDelegate Protocol

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = DailyAppsViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

