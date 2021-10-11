//
//  AriticleViewModel.swift
//  iOS-prac
//
//  Created by kong on 2021/10/11.
//

import Foundation

struct ArticleViewModel {
    private let article:Article
    
    var imageUrl:String? {
        return article.urlToImage
    }
    
    var title:String? {
        return article.title
    }
    
    var description:String? {
        return article.description
    }
    
    init(article:Article) {
        self.article = article
    
    }
}
