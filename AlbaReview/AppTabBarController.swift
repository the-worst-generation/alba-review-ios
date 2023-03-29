//
//  AppTabBarController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/25.
//

import UIKit

import SnapKit
import Then

class AppTabBarController: UITabBarController {

    let homeTab = UITabBarItem().then {
        $0.image = UIImage(named: "home")
        $0.title = "홈"
    }
    
    let writeReviewTab = UITabBarItem().then {
        $0.image = UIImage(named: "writeReview")
        $0.title = "리뷰 쓰기"
    }
    
    let myPageTab = UITabBarItem().then {
        $0.image = UIImage(named: "myPage")
        $0.title = "내 정보"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    func configureTabBar() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let writeReviewVC = UINavigationController(rootViewController: WriteReviewViewController())
        let myPageVC = UINavigationController(rootViewController: MyPageViewController())
        
        viewControllers = [homeVC, writeReviewVC, myPageVC]
        
        selectedIndex = 0
        
        tabBar.backgroundColor = .white
        tabBar.selectedImageTintColor = .black
        tabBar.layer.masksToBounds = true
        
        homeVC.tabBarItem = homeTab
        writeReviewVC.tabBarItem = writeReviewTab
        myPageVC.tabBarItem = myPageTab
            
    }

}

