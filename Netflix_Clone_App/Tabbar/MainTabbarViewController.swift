//
//  MainTabarViewController.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/26.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // home, newHot -> viewControllers
        // let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let homeNaviVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeNaviViewController") as! HomeNaviViewController
        let newHotVC = UIStoryboard(name: "NewHot", bundle: nil).instantiateViewController(withIdentifier: "NewHotViewController") as! NewHotViewController
        homeNaviVC.tabBarItem.title = "홈"
        homeNaviVC.tabBarItem.image = UIImage(systemName: "house")
        newHotVC.tabBarItem.title = "New & Hot"
        newHotVC.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        
        // 아이콘 설정
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .black
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .darkGray
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.darkGray]
        tabBarItemAppearance.selected.iconColor = .white
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor : UIColor.white]

        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        
        self.viewControllers = [homeNaviVC, newHotVC]
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
