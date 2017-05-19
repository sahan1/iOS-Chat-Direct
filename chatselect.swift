//
//  chatselect.swift
//  chatdirect
//
//  Created by SID SHARDANAND on 17/05/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//

import Foundation
import UIKit

var roomname: String = ""

class chatselect: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatroom.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var chatroom: UITextField!
    
    @IBAction func roomsubmit(_ sender: Any) {
        roomname = chatroom.text!
    }
}
