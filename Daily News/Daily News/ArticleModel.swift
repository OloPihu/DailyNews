//
//  ArticleModel.swift
//  Daily News
//
//  Created by Aleksander  on 23/04/2019.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // url string
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=d5e8c420b2f04bbebe2b46bb87c28e1c"
        
        // url object
        let url = URL(string: stringUrl)
        // check that is isnt nil
        guard url != nil else {
            
            print("Couldn't create url object")
            
            return
            
        }
        // get the URL session
        let session = URLSession.shared
        // create the datatask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            
            // check if there is no error that there is data
            if error == nil && data != nil {
                
                // decode the JSON fata into our structs
                do {
                    let decoder = JSONDecoder()
                   
                    let result = try
                        decoder.decode(ArticleService.self, from: data!)
                    
                    // pass the articles back to the view controller
                    let articles = result.articles!
                    
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                }
                    
                catch {
                    
                    print("Couldn't ")
                    return
                }
            }
        }
        // resume the task to fire off the request to the api
        
        dataTask.resume()
        
        
        
        
        
        
    }
    
}

