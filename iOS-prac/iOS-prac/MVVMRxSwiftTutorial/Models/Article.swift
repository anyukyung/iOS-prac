//
//  Article.swift
//  iOS-prac
//
//  Created by kong on 2021/10/10.
//

struct ArticleResponse:Codable {
    let status:String
    let totalResults:Int
    let articles:[Article]
}

struct Article:Codable {
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
}
