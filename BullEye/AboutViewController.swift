//
//  AboutViewController.swift
//  BullEye
//
//  Created by leeguoyu on 15/10/17.
//  Copyright © 2015年 Mosh. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html")
        
        let htmlData = NSData(contentsOfFile: htmlFile!)
        
        let baseURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
        
        webView.loadData(htmlData!, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)

    }

    @IBAction func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }

}
