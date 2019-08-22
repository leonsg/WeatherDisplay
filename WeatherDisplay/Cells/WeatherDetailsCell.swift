//
//  WeatherDetailsCell.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 21/8/19.
//

import UIKit

class WeatherDetailsCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWithWeatherObject(object: WeatherObject) {
        textView.text = "\(object)"
    }
}
