//
//  File.swift
//  chatdirect
//
//  Created by SID SHARDANAND on 14/05/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//

import Foundation
import UIKit

var logininput: String = ""

class loginscreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var login: UITextField!

    @IBAction func submit(_ sender: UIButton) {
        if (login.text != ""){
            logininput = login.text!
        } else {
            logininput = UIDevice.current.name
        }
    }
}
