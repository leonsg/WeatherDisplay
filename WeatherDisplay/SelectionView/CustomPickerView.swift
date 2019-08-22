//
//  CustomPickerView.swift
//  WeatherDisplay
//
//  Created by Leon Liang on 22/8/19.
//

import UIKit
import CoreData

protocol CustomPickerViewDelegate: class {
    func didSelectRow(itemName: String, itemValue: String)
}

class CustomPickerView: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    weak var delegate: CustomPickerViewDelegate?
    var dataSource = [NSManagedObject]() {
        didSet {
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupData(for type: String) {
        if let data = CoreDataAssistant().getAllObjectsFor(type) {
            dataSource = data
        }
    }
}

extension CustomPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}

extension CustomPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row].value(forKeyPath: "name") as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let delegate = self.delegate {
            self.dismiss(animated: true, completion: nil)
            delegate.didSelectRow(itemName: (dataSource[row].value(forKeyPath: "name") as? String)!, itemValue: "\(dataSource[row].value(forKeyPath: "id") ?? "")")
        }
    }
}
