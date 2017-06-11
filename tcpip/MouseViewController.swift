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
    @IBOutlet weak var swipeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
            gesture.direction = direction
            self.swipeView.addGestureRecognizer(gesture)
        }

        updateButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateButtonState() {
        leftButton.isEnabled = (sock>0)
        rightButton.isEnabled = (sock>0)
        swipeView.isUserInteractionEnabled = (sock>0)
    }
    
    @IBAction func mouseButtonClicked(_ sender: UIButton) {
        if (sender === leftButton) {
            tcpipSocket_send(sock, "leftclick;")
        } else if (sender === rightButton) {
            tcpipSocket_send(sock, "rightclick;")
        }
    }
    
    func onSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            tcpipSocket_send(sock, "right;")
        case UISwipeGestureRecognizerDirection.left:
            tcpipSocket_send(sock, "left;")
        case UISwipeGestureRecognizerDirection.up:
            tcpipSocket_send(sock, "up;")
        case UISwipeGestureRecognizerDirection.down:
            tcpipSocket_send(sock, "down;")
        default:
            break
        }
    }
}
