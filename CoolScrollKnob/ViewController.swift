//
//  ViewController.swift
//  CoolScrollKnob
//
//  Created by Cage Johnson on 9/6/17.
//  Copyright © 2017 desk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var screenSize = UIScreen.main.bounds
        
        var view = CoolScrollKnobView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.width))
        
        self.view.addSubview(view)
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

