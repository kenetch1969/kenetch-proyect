//
//  ViewController.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtAlpha2Code: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtViewJson: UITextView!
    
    private var country:Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtAlpha2Code.text = country?.alpha2Code
        txtName.text = country?.name
        
        let jsonData = try! JSONEncoder().encode(country)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        txtViewJson.text = jsonString
    }

    func setCountry(country: Country){
        self.country = country
    }
    
    

}

