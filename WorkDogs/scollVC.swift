//
//  scollVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/7.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class scollVC: UIViewController {
    
    
    
    @IBOutlet weak var scollView: UIScrollView!
    
    
    var imgViews = [UIImageView]()
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgViews.append(UIImageView(image: UIImage(named: "a.png")))
        imgViews.append(UIImageView(image: UIImage(named: "b.png")))
        imgViews.append(UIImageView(image: UIImage(named: "c.png")))
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let rect = scollView.bounds
        var size = CGSize()
        var down:UIImageView? = nil
        
        for imgView in imgViews {
            imgView.contentMode = .center
            
            
            if down == nil {
                imgView.frame = rect
                
                
            }else {
                
                imgView.frame = (down?.frame.offsetBy(dx: 0, dy: (down?.frame.size.height)!))!
            }
            down = imgView
            size = CGSize(width: rect.size.width, height: size.height + imgView.frame.size.height)
            
            scollView.addSubview(imgView)
            
        }
        
        
        scollView.contentSize = size
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
