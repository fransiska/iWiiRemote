//
//  ViewController.swift
//  tcpip
//
//  Created by fransiska on 2017/06/09.
//  Copyright © 2017年 fransiska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var ipTextField: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var sock:Int32 = 0
    
    //MARK: Default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Actions
    @IBAction func connectSocket(_ sender: UIButton) {
        sock = tcpipSocket_connect("127.0.0.1",12345)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        tcpipSocket_send(sock,"Hi, I'm C")
    }
    
    @IBAction func closeSocket(_ sender: UIButton) {
        tcpipSocket_close(sock)
    }
}

