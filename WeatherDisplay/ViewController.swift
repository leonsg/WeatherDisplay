//
//  ViewController.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 21/8/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var weatherDataSource = [WeatherObject]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Default City
        getWeather(cityId: "1880251")
        self.navigationItem.title = "Republic of Singapore"
        
        tableView.estimatedRowHeight = 64.0
        tableView.register(WeatherDetailsCell.self)
    }
    
    private func getWeather(cityId: String) {
        WeatherService().getWeather(for: cityId) { [weak self] (result: Result) in
            switch result {
            case .success(let object):
                self?.weatherDataSource = object.list
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCountry" {
            let countryPicker = segue.destination as! CustomPickerView
            countryPicker.setupData(for: "City")
            countryPicker.delegate = self
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as WeatherDetailsCell
        cell.setupWithWeatherObject(object: weatherDataSource[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: CustomPickerViewDelegate {
    func didSelectRow(itemName: String, itemValue: String) {
        getWeather(cityId: itemValue)
        self.navigationItem.title = itemName
    }
}
