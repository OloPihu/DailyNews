//
//  ArticleCell.swift
//  Daily News
//
//  Created by Aleksander  on 06/05/2019.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func displayArticle(_ article:Article) {
        
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        
        // clear the image view
        
        articleImageView.image = nil
        
        articleToDisplay = article
        
        headlineLabel.text = articleToDisplay!.title!
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // article image download
        
        let urlString = articleToDisplay!.urlToImage
        
        guard urlString != nil else {
            return
        }
        
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            
      // if the cached data exists use that instead
            articleImageView.image = UIImage(data: cachedData!)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
            
        }
        
        let url = URL(string: urlString!)
        
        guard url != nil else {
            
            print("Couldn't create url object")
            return
            
        }
        
        // get the session
        
        let session = URLSession.shared
        
        // created the datatask
        
        let dataTask = session.dataTask(with: url!) {
            (data, response, error) in
            
            if error == nil && data != nil {
                
                // save the image to cache
                CacheManager.saveImageData(urlString!, data!)
                
                if self.articleToDisplay!.urlToImage == urlString! {
                    
                    DispatchQueue.main.async {
                        
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                        
                    }
                }
            }
        }
        
        dataTask.resume()
        
    }
}
