//
//  WeatherService.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 21/8/19.
//

import Foundation

//All possible http errors
enum HTTPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

//Result enum to show success or failure
enum Result<T> {
    case success(T)
    case failure(HTTPError)
}

struct WeatherService {
    
    func getWeather(for cityId: String, completion: @escaping (Result<WeatherModel>) -> Void) {
        
        let urlSession = URLSession.shared
        let urlRequest = URLRequest(url: URL(string: Configuration.apiEndpoint + "?id=\(cityId)&appid=\(Configuration.apiKey)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completion(Result.failure(HTTPError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(HTTPError.dataNotFound))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(HTTPError.jsonParsingError(error as! DecodingError)))
            }
        })
        task.resume()
    }
}
