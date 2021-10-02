//
//  WebService.swift
//  iOS-prac
//
//  Created by kong on 2021/10/02.
//

import Foundation

//MVVM에 필수적인건 아니지만 service도 하나 만들어서 API를 받아와보자.
//로직은 VM(View Model)에 합쳐도 된다.


//@escaping 부분은 중요하지 않다.
//중요한 건 data를 받아오는지 독립적으로 확인할 수 있다는 것이다.

class WebService {
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil) // if any error occurs, article can be nil
            }
            else if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                print(articleList)
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
                 
            }
            
        }.resume()
        
    }
}

