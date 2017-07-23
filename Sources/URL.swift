//
//  URL.swift
//  url_shortener
//
//  Created by Alfian Losari on 22/07/17.
//
//

import PerfectLib
import SwiftRandom

struct URLify {
    var id: String = ""
    var url: String = ""
    var sanity: String = ""
    
    init() {}
    
    init(_ input: String) {
        let uuid = UUID()
        id = uuid.string
        self.url = input
        sanity = randomStringWithLength()
        
        
        
    }
    
    private func randomStringWithLength(len: Int = 8) -> String {
        let letters : String = "abcdefghijklmnopqrstuvwxyzZ0123456789"
        var randomString = ""
        for _ in 0..<len {
            let length = Int(letters.length) - 1
            let rand = Int.random(lower: 0, length)
            randomString += letters.substring(rand, length: 1)
            
        }
        
        return randomString
        
    }
    
    
    
}
