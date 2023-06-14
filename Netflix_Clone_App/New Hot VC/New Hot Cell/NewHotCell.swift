//
//  NewHotCell.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/06/05.
//

import UIKit
import AVFoundation

protocol PlayOrStopType {
    func moviePlay()
    func movieStop()
}

class NewHotCell: UITableViewCell, PlayOrStopType {
    
    var baseContainerView: UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .black
        return baseView
    }()
    
    var movieContainerView: UIView = {
        let movieView = UIView()
        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.backgroundColor = .black
        return movieView
    }()
    
    var thumbnail: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(systemName: "photo")
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var coverImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(systemName: "photo")
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var dateLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textColor = .white
        return date
    }()
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let desc = UILabel()
        desc.numberOfLines = 0
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.textColor = .white
        return desc
    }()
    
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    
    var movieResult: MovieResult?{
        didSet{
            settingDate()
            settingTitle()
            settingDescription()
            settingPlayerURL()
            requestThumbnailImage()
            requestCoverImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .black
        
        // 뷰를 올리고 나서 constraint 설정 해야 함
        self.contentView.addSubview(baseContainerView)
        baseContainerView.addSubview(movieContainerView)
        baseContainerView.addSubview(thumbnail)
        baseContainerView.addSubview(dateLabel)
        baseContainerView.addSubview(titleLabel)
        baseContainerView.addSubview(descriptionLabel)
        
        
        // 기본 셀 컨텐츠뷰 베이스
        addBaseView()
        // 무비 컨테이너 뷰
        addMovieView()
        // 무비 레이어
        addMovieLayer()
        // 썸네일
        addThumbnail()
        // 커버 이미지
        addCoverImageWithSetAnchor()
        // 날짜
        addDateLabel()
        // 타이틀
        addTitleLabel()
        // 설명
        addDescriptionLabel()
    }
    
    private func addBaseView() {
        baseContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 50).isActive = true
        baseContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        baseContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        baseContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
    
    private func addMovieView() {
        movieContainerView.topAnchor.constraint(equalTo: baseContainerView.topAnchor).isActive = true
        movieContainerView.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        movieContainerView.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor).isActive = true
        movieContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        movieContainerView.bottomAnchor.constraint(equalTo: thumbnail.topAnchor, constant: -10).isActive = true
    }
    
    private func addMovieLayer() {
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 200)
    }
    
    private func addThumbnail() {
        thumbnail.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func addCoverImageWithSetAnchor() {
        movieContainerView.addSubview(coverImgView)
        coverImgView.leftAnchor.constraint(equalTo: movieContainerView.leftAnchor).isActive = true
        coverImgView.rightAnchor.constraint(equalTo: movieContainerView.rightAnchor).isActive = true
        coverImgView.topAnchor.constraint(equalTo: movieContainerView.topAnchor).isActive = true
        coverImgView.bottomAnchor.constraint(equalTo: movieContainerView.bottomAnchor).isActive = true
    }
    
    private func addDateLabel() {
        dateLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true
    }
    
    private func addTitleLabel() {
        titleLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10).isActive = true
    }
    
    private func addDescriptionLabel() {
        descriptionLabel.leftAnchor.constraint(equalTo: baseContainerView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: baseContainerView.rightAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: baseContainerView.bottomAnchor, constant: -30).isActive = true
    }
    
    private func settingPlayerURL() {
        if let previewURL = movieResult?.previewUrl, let hasURL = URL(string: previewURL) {
            player = AVPlayer(url: hasURL)
            playerLayer.player = player
            player.volume = 0
            // player.play()
        }
    }
    
    private func settingDate() {
        if let hasDate = movieResult?.releaseDate {
//            let formatter = ISO8601DateFormatter()
//
//            if let isoDate = formatter.date(from: hasDate) {
//                let myFormatter = DateFormatter()
//                myFormatter.dateFormat = "yyyy-MM-dd"
//                let dateStirng = myFormatter.string(from: isoDate)
//
//                dateLabel.text = dateStirng
//            }
            self.dateLabel.text = CommonUtil.iso8601(date: hasDate, format: "yyyy-MM-dd")
        }
    }
    
    
    private func settingTitle() {
        titleLabel.text = movieResult?.trackName
    }
    
    private func settingDescription() {
        descriptionLabel.text = movieResult?.shortDescription
    }
    
    private func requestThumbnailImage() {
        if let hasURLString = movieResult?.artworkUrl {
            NetworkLayer.request(urlString: hasURLString) { image in
                DispatchQueue.main.async {
                    self.thumbnail.image = image
                }
            }
        }
    }
    
    private func requestCoverImage() {
        if let hasURLString = movieResult?.artworkUrl {
            NetworkLayer.request(urlString: hasURLString) { image in
                DispatchQueue.main.async {
                    self.coverImgView.image = image
                }
            }
        }
    }
    
    func moviePlay() {
        if self.player.timeControlStatus != .playing {
            self.player.play()
            coverImgView.isHidden = true
        }
    }
    
    func movieStop() {
        self.player.pause()
        
        if self.player.currentTime().seconds > 2{
            coverImgView.isHidden = true
        }
        else{
            coverImgView.isHidden = false
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
