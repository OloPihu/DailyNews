//
//  Article.swift
//  Daily News
//
//  Created by Aleksander  on 22/04/2019.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var decription:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}

