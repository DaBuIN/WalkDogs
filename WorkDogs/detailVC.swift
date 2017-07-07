//
//  detailVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/7.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class detailVC: UIViewController {

    
    
    
    
    
    @IBAction func backTableView(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
        show(vc!, sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
