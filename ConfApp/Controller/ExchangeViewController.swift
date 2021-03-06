//
//  ExchangeViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 05.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

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
        
        
        assignbackground()
        
self.hideKeyboardWhenTappedAround()
        
        amount.setBottomBorder(borderColor: UIColor.black)
        self.amount.delegate = self
        let am = NSString(string: amount.text! as NSString)
        amountValue = am.doubleValue
        
        self.picker1.delegate = self
        self.picker1.dataSource = self
        
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        
        
        self.currencies = getLatestRates()
        
        print("Currencies")
        print(currencies.count)
        
        self.currenciesNames.append("polski złoty")
        self.currenciesCodes.append("PLN")
        self.currenciesRates.append(1.0)
        
        for i in 0...(currencies.count-1){
            self.currenciesNames.append(currencies[i].currency)
             self.currenciesCodes.append(currencies[i].code)
             self.currenciesRates.append(currencies[i].mid)
        }
        self.pickerData = self.currenciesCodes
        
        
        
        
        
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

    func convertCurrency(rate1: Double, rate2: Double, amo: Double) -> Double {
        
        return amo * (rate1/rate2)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func assignbackground(){
        let background = UIImage(named: "background2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 0.55
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    @IBAction func convert(sender: UIButton){
        
    //    let selectedc1 = pickerData[picker1.selectedRow(inComponent: 1)]
        
        print(self.currencies[row1])
        print(self.amountValue)
   //     print(selectedc1)
        
        let am = NSString(string: amount.text as! NSString)
        amountValue = am.doubleValue
        
        if self.amountValue > 0 {
           
            
          let res = convertCurrency(rate1: self.currenciesRates[row1], rate2: self.currenciesRates[row2], amo: amountValue)
            
            
            result.text = String((res * 100).rounded() / 100)
            
    
            
            
        }
    }
    
}
