//
//  ViewController.swift
//  Daily News
//
//  Created by Aleksander  on 22/04/2019.
//
// created with codewithcris course
import UIKit

class ViewController: UIViewController {
    
    var model = ArticleModel()
    var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        model.delegate = self
        model.getArticles()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            
            print("user didn't select an article")
            return
            
        }
       
        let article = articles[indexPath!.row]
        
        let detailVC = segue.destination as! DetailViewController
        
        detailVC.articleUrl = article.url
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get the cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
// customize cell
        
        let article = articles[indexPath.row]
        
        cell.displayArticle(article)
        
        return cell
    }
}
    extension ViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            performSegue(withIdentifier: "SegueToDetail", sender: self)
            
        }
        
    }


extension ViewController: ArticleModelProtocol {
    
    
    func articlesRetrieved(_ articles: [Article]) {
        
        self.articles = articles
        tableView.reloadData()
    }
    
}
