//
//  ViewController.swift
//  ByteCoin
//
//  Created by Alan Hsu on 2020/12/29.
//
import UIKit

class ViewController: UIViewController {
    // Adding UIPickerViewDataSource means that the ViewController class is able to provide data to any UIPickerViews
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        // Set the CoinManager's delegate here so we can receive notifications
        currencyPicker.dataSource = self
        // Set the ViewController class as the data sourse to the currencyPicker object
        currencyPicker.delegate = self
        // Set the ViewController as the delegate of the currencyPicker
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    // Determine how many colums we want in our picker
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
        // Using the currencyArray from the CoinManager to get the number of rows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
        // When PickerView is loading up, it will ask its delegate for a title for each row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        // Will be called everytime when the user scroll the picker
    }
}
