//
//  WeatherModel.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 21/8/19.
//

import Foundation

struct WeatherModel: Codable {
    var cod: String
    var message: Double
    var cnt: Int
    var list: [WeatherObject]
}

struct WeatherObject: Codable {
    var dt: Int
    var main: WeatherMain
    var weather: [Weather]
    var clouds: Dictionary<String, Int>
    var wind: Dictionary<String, Double>
    var snow: Dictionary<String, Double>?
    var sys: Dictionary<String, String>
    var dt_txt: String
}

struct WeatherMain: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var sea_level: Double
    var grnd_level: Double
    var humidity: Double
    var temp_kf: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}


