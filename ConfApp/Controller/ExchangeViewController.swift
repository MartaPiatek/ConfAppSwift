//
//  ExchangeViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 05.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    
    
    
    var pickerData: [String] = [String]()
    
    
    private let nbpApiUrl = "http://api.nbp.pl/api/exchangerates/tables/a/?format=json"
    private var currencies = [Currency]()
     private var currenciesNames = [String]()
    private var currenciesCodes = [String]()
    private var currenciesRates = [Double]()
    
    
    var row1 = 0
    var row2 = 0
    
    var amountValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let am = NSString(string: amount.text as! NSString)
        amountValue = am.doubleValue
        
        self.picker1.delegate = self
        self.picker1.dataSource = self
        
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        self.currencies = getLatestRates()
        
        print("Currencies")
        print(currencies.count)
        
        for i in 0...(currencies.count-1){
            self.currenciesNames.append(currencies[i].currency)
             self.currenciesCodes.append(currencies[i].code)
             self.currenciesRates.append(currencies[i].mid)
        }
        self.pickerData = self.currenciesNames
        
        
        
        
        
     //    pickerData = ["Irem1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        //pickerData = currenciesNames
        
        print("Currencies")
        print(currencies.count)
        
        print("CurrenciesCodes")
        print(currenciesCodes.count)
   
        print("CurrenciesRates")
       print(currenciesRates.count)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1 {
          return pickerData.count
        }
        else  {
          return pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       print("Picker")
        var picker1ValueSelected = ""
        var picker2ValueSelected = ""
        
        
        if pickerView == picker1 {
              picker1ValueSelected = pickerData[row] as String
            row1 = row
            print(picker1ValueSelected)
            
            
        }
        if pickerView == picker2 {
            picker2ValueSelected = pickerData[row] as String
            row2 = row
            print(picker2ValueSelected)
        }
        
       
      
        
    }
    
    //MARK: Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1 {
             return pickerData[row]
        }
        else  {
             return pickerData[row]
        }
       
    }

    func convertCurrency(c1: Currency, c2: Currency, amo: Double) -> Double {
        var result: Double
        
        let rate1 = c1.mid
        let rate2 = c2.mid
        
    result = amo * (rate1/rate2)
        
        return result
    }
    
    
    func getLatestRates()-> Array<Currency>{
        
        var c = Array<Currency>()
        
        guard let currencyUrl = URL(string: nbpApiUrl) else {
            return c
        }
        let semaphore = DispatchSemaphore(value: 0)
        
        let request = URLRequest(url: currencyUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
               
               c = self.parseJsonData(data: data)
          print(c.count)
                
               
               semaphore.signal()
            /*
                OperationQueue.main.addOperation( {
                    self.picker1.reloadAllComponents()
                     //self.picker2.reloadAllComponents()
                })*/
            }
            
        })
        
        task.resume()
          semaphore.wait()
        
       
        return c
    }
    
    func parseJsonData(data: Data) -> [Currency] {
       
        
        var currencies = [Currency]()
       
        
        let decoder = JSONDecoder()
        
        do{
        let currencyDataStore = try decoder.decode([CurrencyDataStore].self, from: data)
            let dataStore = currencyDataStore[0]
           currencies = dataStore.rates
        }
        catch {
            print(error)
        }
        return currencies
    }
    
    @IBAction func convert(sender: UIButton){
        
    //    let selectedc1 = pickerData[picker1.selectedRow(inComponent: 1)]
        print("yo yo")
        print(self.currencies[row1])
        print(self.amountValue)
   //     print(selectedc1)
        
        let am = NSString(string: amount.text as! NSString)
        amountValue = am.doubleValue
        
        if self.amountValue > 0 {
            result.text = String(convertCurrency(c1: self.currencies[row1], c2: self.currencies[row2], amo: amountValue))
        }
    }
    
}
