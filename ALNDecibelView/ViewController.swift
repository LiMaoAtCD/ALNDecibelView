//
//  ViewController.swift
//  ALNDecibelView
//
//  Created by AlienLi on 15/3/12.
//  Copyright (c) 2015年 ALN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alienView: ALNdecibelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        alienView.setCurrentDecibel(0)
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "xxx", userInfo: nil, repeats: true)
    }
    func xxx() {
        var db = rand() % 90
        alienView.setCurrentDecibel(CGFloat(db))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

