//
//  Coordinator.swift
//  iOS-prac
//
//  Created by kong on 2021/10/10.
//

import UIKit

//걍 뷰컨 시작점 바궈줌

class Coordinator {
    let window:UIWindow
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController(viewModel: RootViewModel(articleService: ArticleService()))
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
}
