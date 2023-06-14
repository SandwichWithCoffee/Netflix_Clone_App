//
//  HomeNaviViewController.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/29.
//

import UIKit

class HomeNaviViewController: UINavigationController {
    var effectViewAlpha: CGFloat = 0 {
        didSet{
            visualEffectView.alpha = effectViewAlpha
        }
    }
    
    // N 로고버튼에 반투명 영역
    private let statusBarHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0
    
    lazy private var visualEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = self.navigationBar.bounds.insetBy(dx: 0, dy: -statusBarHeight).offsetBy(dx: 0, dy: -statusBarHeight)
        effectView.alpha = 0
        return effectView
    }()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance
        
        let logo = UIImage(named: "netflix_logo")
        let logoButton = UIButton()
        
        logoButton.setImage(logo, for: .normal)
        
        // 왼쪽 위 N 로고버튼 방법 1
        // logoButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        // logoButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: logoButton)
        
        // 왼쪽 위 N 로고버튼 방법 2
        logoButton.frame = CGRect(x: 0, y: 10, width: 30, height: 30)
        self.navigationBar.addSubview(visualEffectView) // 반투명 영역 추가
        self.navigationBar.addSubview(logoButton)
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
