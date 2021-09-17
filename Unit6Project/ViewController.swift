//
//  ViewController.swift
//  Unit6Project
//
//  Created by Xun Zhong on 6/21/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.heightText.text = "inches"
        //self.weightText.text = "lbs"
    }
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    struct bmiResults: Decodable {
        
        let bmi: Double
        let more: [String]
        let risk: String
    }
    
    @IBAction func webBttn(_ sender: Any) {
        if let url = URL(string:"https://en.wikipedia.org/wiki/Body_mass_index") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func calBttn(_ sender: UIButton) {
        let height = heightText.text!
        let weight = weightText.text!
        
        let urlAsString = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI?height=\(height)&weight=\(weight)"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: {data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            //let jsonData = data.data(encoding: .utf8)!
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(bmiResults.self, from: data!)
            
            
            let bmiData = jsonResult.bmi
            let msg = jsonResult.risk
            
            let bmiStr = "BMI: \(bmiData)"
            
            let good = "\u{1F60A}"
            let okay = "\u{1F610}"
            let bad = "\u{1F641}"
            
            DispatchQueue.main.async {
                self.BMILabel.text = bmiStr
                self.msgLabel.text = msg
                if bmiData < 18 {
                    self.colorLabel.backgroundColor = UIColor.blue
                    self.colorLabel.text = bad
                } else if bmiData >= 18 && bmiData < 25 {
                    self.colorLabel.backgroundColor = UIColor.green
                    self.colorLabel.text = good
                } else if bmiData >= 25 && bmiData < 30 {
                    self.colorLabel.backgroundColor = UIColor.purple
                    self.colorLabel.text = okay
                } else if bmiData >= 30 {
                    self.colorLabel.backgroundColor = UIColor.red
                    self.colorLabel.text = bad
                }
                
            }
    
        })
        jsonQuery.resume()

        
    }
}

