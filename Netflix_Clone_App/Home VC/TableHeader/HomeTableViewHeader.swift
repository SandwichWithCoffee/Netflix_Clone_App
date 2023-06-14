//
//  HomeTableViewHeader.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/06/02.
//

import UIKit

class HomeTableViewHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    private var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        
        return lbl
    }()
}
