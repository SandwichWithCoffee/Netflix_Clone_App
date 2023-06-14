//
//  HomeCell.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/31.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieModel: MovieModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .black
        
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    func requestMediaAPI(type: MediaType?) {
        guard let hasType = type else {
            return
        }
        
        NetworkLayer.request(type: hasType) { model in
            self.movieModel = model
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 150)
    }
}

extension HomeCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel?.resultCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        if let hasUrl = self.movieModel?.results[indexPath.item].artworkUrl {
//            NetworkLayer.request(urlString: hasUrl) { image in
//                DispatchQueue.main.async {
//                    cell.coverImageView.image = image
//                }
//            }
            Task{
                let result = await NetworkLayer.requestAsyncAwait(urlString: hasUrl)
                
                switch result {
                case .success(let image):
                    cell.coverImageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieResult = movieModel?.results[indexPath.section]
        
        NotificationCenter.default.post(name: NSNotification.Name("presentDetailVC"), object: movieResult)
    }
}
