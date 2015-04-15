//
//  CHBarNoticeView.swift
//  CHStatusBarNoticeDemo
//
//  Created by Jiao Liu on 3/1/15.
//  Copyright (c) 2015 Jiao Liu. All rights reserved.
//

import UIKit

@objc(CHBarNoticeViewDelegate)

protocol CHBarNoticeViewDelegate
{
    func openViewWithTag(tag : Int)
}

class CHBarNoticeView: UIView {
    var topWindow       : UIWindow?
    var stringLabel     : UILabel?
    var delegate        : CHBarNoticeViewDelegate?
    var fadeTimer       : NSTimer?
    
    // MARK: - Singleton
    class var sharedView: CHBarNoticeView {
        struct Inner
        {
            static var instance : CHBarNoticeView? = nil
            static var token    : dispatch_once_t = 0
        }
        dispatch_once(&Inner.token, { () -> Void in
            Inner.instance = CHBarNoticeView()
        })
        return Inner.instance!
    }
    
    // MARK: - Method
    func showNotice(string : String)
    {
        if topWindow == nil
        {
            topWindow = UIWindow(frame: CGRectMake(0, 0, getStatusBarWidth(), getStatusBarHeight()))
            topWindow?.windowLevel = UIWindowLevelAlert
            topWindow?.backgroundColor = UIColor.clearColor()
            topWindow?.userInteractionEnabled = true
        }
        topWindow?.addSubview(self)
        topWindow?.hidden = false
        
        if stringLabel == nil
        {
            stringLabel = UILabel(frame: CGRectMake(getStatusBarWidth() - 100, 0, 100, getStatusBarHeight()))
            stringLabel?.backgroundColor = UIColor.whiteColor()
            stringLabel?.font = UIFont.systemFontOfSize(12.0)
            self.addSubview(stringLabel!)
        }
        stringLabel?.text = string
        stringLabel?.transform = CGAffineTransformMakeTranslation(100, 0)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let label = self.stringLabel
            label?.transform = CGAffineTransformIdentity
        })
        
        if fadeTimer != nil
        {
            fadeTimer?.invalidate()
            fadeTimer = nil
        }
        fadeTimer = NSTimer(timeInterval: 5, target: self, selector: "dimissNotice", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(fadeTimer!, forMode: NSRunLoopCommonModes)
    }
    
    func dimissNotice()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let label = self.stringLabel
            label?.transform = CGAffineTransformMakeTranslation(100, 0)
            }) { (finish) -> Void in
                self.removeFromSuperview()
                self.stringLabel?.removeFromSuperview()
                self.stringLabel = nil
                self.topWindow?.removeFromSuperview()
                self.topWindow = nil
                self.fadeTimer?.invalidate()
                self.fadeTimer = nil
        }
    }
    
    func openView()
    {
        self.dimissNotice()
        if delegate != nil
        {
            delegate?.openViewWithTag(self.tag)
        }
    }
}

func getStatusBarWidth() -> CGFloat
{
    return UIApplication.sharedApplication().statusBarFrame.size.width
}

func getStatusBarHeight() -> CGFloat
{
    return UIApplication.sharedApplication().statusBarFrame.size.height
}