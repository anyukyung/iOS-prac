//
//  Repository.swift
//  iOS-prac
//
//  Created by kong on 2021/09/26.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (Date) ->) {
        let url = "http://worldclockapi.com/api/json/utc/now"
        
        URLSession.shared.dataTask(with: URL(string: url))! {
            guard let data = data else { return }
            guard let model = try? JSONDecoder.decode(UtcTimeModel.self, from: data) else { return }
        
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd-'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: model.currentDateTime) else { return }
            
            DispatchQueue.main.async {
                onCompleted(now)
            }
        }
    }
}
