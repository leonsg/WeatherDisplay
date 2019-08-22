//
//  CityModel.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 21/8/19.
//

import Foundation

struct CityModel: Codable {
    var cityId: Int
    var cityName: String
    var country: String
    var coordinates: Dictionary<String, Double>
    
    private enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case cityName = "name"
        case country = "country"
        case coordinates = "coord"
    }
}
