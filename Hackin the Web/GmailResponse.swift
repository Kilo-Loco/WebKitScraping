//
//  GmailResponse.swift
//  Hackin the Web
//
//  Created by Kyle Lee on 6/18/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

struct GmailResponse {
    
    let emails: [Email]
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
        let doc = try SwiftSoup.parse(htmlString)
        let authors = try doc.getElementsByClass("Mg Jl").array()
        let titles = try doc.getElementsByClass(" Mg Kl").array()
        
        var emails = [Email]()
        for i in 0..<titles.count {
            let author = try authors[i].text()
            let title = try titles[i].text()
            let email = Email(author: author, title: title)
            emails.append(email)
        }
        self.emails = emails
    }
    
}
