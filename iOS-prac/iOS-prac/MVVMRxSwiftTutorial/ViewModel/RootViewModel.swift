//
//  RootViewModel.swift
//  iOS-prac
//
//  Created by kong on 2021/10/11.
//

import Foundation
import RxSwift

// 인스턴스로 선언하지말고 프로토콜로 해야 확장성이 좋다.  (더미데이터 뿌릴 때 등) 프로토콜로 선언하는것이 좋다

final class RootViewModel {
    let title = "yukyung News"
    
    private let articleService:ArticleServiceProtocol
    
    init(articleService:ArticleServiceProtocol) {
        self.articleService = articleService
    }
    //의존성 주입
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
