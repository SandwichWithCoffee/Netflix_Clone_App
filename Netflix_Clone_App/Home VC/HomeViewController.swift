//
//  ViewController.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/26.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let headerView = HomeTableHeaderView()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        tableView.backgroundColor = .black
        tableView.tableHeaderView = headerView
        tableView.contentInsetAdjustmentBehavior = .never // 이미지를 맨 위에 위치(스토리보드에서 Top 부분 Second Item 부분을 Safe Area -> Superview.top 설정 및 constraint 값을 0으로 설정 필요)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        tableView.register(HomeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "HomeTableViewHeader")
        
        registObserver()
    }
    
    func registObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetailVC), name: NSNotification.Name("presentDetailVC"), object: nil)
    }
    
    @objc func presentDetailVC(notification: Notification) {
        if let hasResult = notification.object as? MovieResult {
            let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
            detailVC.movieResult = hasResult
            self.present(detailVC, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableViewHeader") as! HomeTableViewHeader
        
        headerView.title = MediaType(rawValue: section)?.title
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MediaType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.requestMediaAPI(type: MediaType(rawValue: indexPath.section))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let area: CGFloat = 100
        let alpha = min(1, scrollView.contentOffset.y / area)
        if let homeNavi = self.navigationController as? HomeNaviViewController{
            homeNavi.effectViewAlpha = alpha
        }
        // print(scrollView.contentOffset.y)
    }
}
