//
//  CacheManager.swift
//  Daily News
//
//  Created by Aleksander  on 06/05/2019.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data) {
        
        // Saving the image data to our image dictionary
        imageDictionary[url] = data
        
    }
    
    static func retrieveImageData(_ url:String) -> Data? {
        
        // Try to retrieve the value for the key that's passed into this method
        return imageDictionary[url]
    }
    
}

