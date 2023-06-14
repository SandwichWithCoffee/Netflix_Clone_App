//
//  DetailViewController.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/06/12.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    @IBOutlet private weak var movieContainerView: UIView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    private var loadedViewAndDataSet: (() -> Void)?
    var movieResult: MovieResult? {
        didSet {
            loadedViewAndDataSet = { [weak self] in
                guard let self = self else { return }
                self.movieDescription.text = self.movieResult?.longDescription
                self.movieTitle.text = self.movieResult?.trackName
                
                if let previewUrl =  self.movieResult?.previewUrl, let url = URL(string: previewUrl) {
                    self.playMovie(url: url)
                }
            }
        }
    }
    
    @IBAction private func play(_ sender: Any) {
        if player.timeControlStatus != .playing {
            player.play()
        }
    }
    
    @IBAction private func stop(_ sender: Any) {
        player.pause()
    }
    
    private func playMovie(url: URL) {
        player = AVPlayer(url: url)
        playerLayer.player = player
        player.volume = 0.1
        
        player.play()
    }

    private var player = AVPlayer()
    private let playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadedViewAndDataSet?()
        movieContainerView.layer.addSublayer(playerLayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250)
    }
    
    deinit {
        print("detailVC deinit")
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
