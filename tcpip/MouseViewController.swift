//
//  MouseViewController.swift
//  tcpip
//
//  Created by fransiska on 2017/06/10.
//  Copyright © 2017年 fransiska. All rights reserved.
//

import UIKit
import os.log

class MouseViewController: UIViewController {
    
    var sock:Int32 = -1

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateButtonState() {
        leftButton.isEnabled = (sock>0)
        rightButton.isEnabled = (sock>0)
    }
    
    @IBAction func mouseButtonClicked(_ sender: UIButton) {
        if (sender === leftButton) {
            tcpipSocket_send(sock, "left;")
        } else if (sender === rightButton) {
            tcpipSocket_send(sock, "right;")
        }
    }
}
