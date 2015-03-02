//
//  ViewController.swift
//  CHStatusBarNoticeDemo
//
//  Created by Jiao Liu on 3/1/15.
//  Copyright (c) 2015 Jiao Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController , CHBarNoticeViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var btn = UIButton(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width / 2.0 - 100, UIScreen.mainScreen().bounds.size.height / 2.0 - 20, 200, 40))
        btn.addTarget(self, action: "showNotice", forControlEvents: UIControlEvents.TouchUpInside)
        btn.setTitle("Show Notice", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showNotice()
    {
        CHBarNoticeView.sharedView.showNotice("hello world")
        CHBarNoticeView.sharedView.delegate = self
        CHBarNoticeView.sharedView.tag = 100
    }
    
    func openViewWithTag(tag: Int) {
        println(tag)
    }
}

