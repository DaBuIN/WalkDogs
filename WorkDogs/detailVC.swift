//
//  detailVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/7.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class detailVC: UIViewController {

    
    
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var hostTitle: UILabel!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var doingTitle: UILabel!
    @IBOutlet weak var doingThing: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    
    
    var idfromtbv:String?
    
    
    
    
    
    @IBAction func backTableView(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
        show(vc!, sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate

        idfromtbv =  app.sentToDetailId
        print(idfromtbv!)
        
        let url = URL(string: "https://sevensql-seventsai.c9users.io/getJSONforDetail.php")
        
        let session = URLSession(configuration: .default)
        var req = URLRequest(url: url!)
        req.httpBody =  "idfromtbv=\(idfromtbv!)".data(using: .utf8)
        req.httpMethod = "POST"
        let task = session.dataTask(with: req, completionHandler: {(dataJSON,response,error) in
            
            
            if error == nil {
                do{
                let source = String(data: dataJSON!, encoding: .utf8)

                
                let jsonObj = try JSONSerialization.jsonObject(with: dataJSON!, options: .allowFragments)
                    
                    for a in  jsonObj as! [[String:String]]{
                    
                        print(a["id"]!)
                        
                        print(a["dogpic"]!)
                        print(a["mastername"]!)
                         print(a["createdate"]!)
                        print(a["lng"]!)
                        print(a["lat"]!)

                        DispatchQueue.main.async {
                            self.hostName.text = a["mastername"]!
                            self.dateTime.text = a["createdate"]!
                            self.latLabel.text = "緯度：" + "" + a["lat"]!
                            self.lngLabel.text = "經度：" + "" +  a["lng"]!
                            self.doingThing.text = a["doing"]!
                        }
                        
                        
                        
                    }
                    
                    
                }catch{
                    print(error)
                }
            
                
                
            }else {
                print(error)
            }
        })
        
        task.resume()
        
        
        
        
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
