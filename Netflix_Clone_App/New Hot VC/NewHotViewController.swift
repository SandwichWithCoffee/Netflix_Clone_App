//
//  NewHotViewController.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/26.
//

import UIKit

class NewHotViewController: UIViewController {
    @IBOutlet weak var newHotTableView: UITableView!
    var movieModel: MovieModel? {
        didSet{
            DispatchQueue.main.async {
                self.newHotTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        newHotTableView.delegate = self
        newHotTableView.dataSource = self
        newHotTableView.rowHeight = UITableView.automaticDimension
        newHotTableView.register(NewHotCell.self, forCellReuseIdentifier: "NewHotCell")
        newHotTableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "DateHeaderView")
        newHotTableView.backgroundColor = .black
        
        NetworkLayer.request(type: .movie) { model in
            self.movieModel = model
        }
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


extension NewHotViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieModel?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewHotCell", for: indexPath) as! NewHotCell
        
        let movieResult = movieModel?.results[indexPath.section]
        cell.movieResult = movieResult
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeaderView") as! DateHeaderView
        
        if let dateString = movieModel?.results[section].releaseDate {
//            let formatter = ISO8601DateFormatter()
//
//            if let date = formatter.date(from: dateString) {
//                let myFormatter = DateFormatter()
//                myFormatter.dateFormat = "M월\ndd"
//                let dateString = myFormatter.string(from: date)
            let convertedDateString = CommonUtil.iso8601(date: dateString, format: "M월\ndd")
            let attributedString = NSMutableAttributedString(string: convertedDateString)
            
            let monthRange = NSRange(location: 0, length: convertedDateString.count - 2)
            let dayRange = NSRange(location: convertedDateString.count - 2, length: 2)
            
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: monthRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: monthRange)
            
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: dayRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: dayRange)
            
            headerView.dateAttributeString = attributedString
//            }
        }
       
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieResult = movieModel?.results[indexPath.section]
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detailVC.movieResult = movieResult
        self.present(detailVC, animated: true)
    }
}


extension NewHotViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visibleCells = newHotTableView.visibleCells as? [NewHotCell] else {
            return
        }
        
        playOrStop(positionY: 40, visibleCells: visibleCells)
    }
    
    func playOrStop<T>(positionY: CGFloat, visibleCells: [T]) where T: UIView & PlayOrStopType {
        guard let firstCell = visibleCells.first else {
            return
        }
        
        if visibleCells.count == 1 {
            firstCell.moviePlay()
            return
        }
        
        let secondCell = visibleCells[1]
        let firstCellPositionY = newHotTableView.convert(firstCell.frame.origin, to: self.view).y
        
        if firstCellPositionY > positionY {
            // first play
            firstCell.moviePlay()
            
            // 나머지는 정지
            var otherCells = visibleCells
            
            otherCells.removeFirst()
            otherCells.forEach { cell in
                cell.movieStop()
            }
        }
        else{
            // second play
            secondCell.moviePlay()
            
            // 나머지는 정지
            var otherCells = visibleCells
            
            otherCells.remove(at: 1)
            otherCells.forEach { cell in
                cell.movieStop()
            }
        }
    }
}

class CommonUtil {
    static func iso8601(date: String, format: String) -> String {
        let formatter = ISO8601DateFormatter()
        
        if let isoDate = formatter.date(from: date) {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = format
            let dateStirng = myFormatter.string(from: isoDate)
            
            return dateStirng
        }
        
        return ""
    }
}
