//
//  ArticleListViewModel.swift
//  iOS-prac
//
//  Created by kong on 2021/10/02.
//

import Foundation

//ViewModel에서는 tableView가 기본적으로 필요로 하는 numberOfRowsInSection에 리턴해줄 함수와 cellForRowAt에 넣어줄 함수, 그리고 numberOfSection까지 정의할 것이다.

struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String? {
        return self.article.title
    }
    var description: String? {
        return self.article.description
    }
}
