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
    
    let fmgr = FileManager.default
    
    
    
    @IBAction func backTableView(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
        show(vc!, sender: self)
        
    }
    
    
    //show detail img when viewdidload
        //傳 imgPath(絕對路徑) docDir(家路徑+document)
    func showImg(imgPath:String,docDir:String){
        //如果空白或資料庫存成""
        if imgPath.isEmpty || imgPath == "/\"\"" {
            print("no image")
            let imgDefault = UIImage(named: "dog4")
            self.detailImgView.image = imgDefault
        }else {
            //真實路徑為家路徑+document+相對路徑
              let realPath = "\(docDir)\(imgPath)"
            if fmgr.fileExists(atPath: realPath){
            
         
              
                print("realpath:\(realPath)")
                
                let img = UIImage(contentsOfFile: "\(realPath)")
                self.detailImgView.image = img
                
                
             
            }

        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared.delegate as! AppDelegate
        
        //宣告家路徑
        let docDir = NSHomeDirectory() + "/Documents"
        print("detailHOME:\(docDir)")
//        let img = UIImage(named: "ball.png")
//        detailImgView.image = img

        
        //從tbview取得之該項目的(id)
        idfromtbv =  app.sentToDetailId
        print(idfromtbv!)
        
        //開始要資料
        let url = URL(string: "https://sevensql-seventsai.c9users.io/getJSONforDetail.php")
        
        let session = URLSession(configuration: .default)
        var req = URLRequest(url: url!)
        req.httpBody =  "idfromtbv=\(idfromtbv!)".data(using: .utf8)
        req.httpMethod = "POST"
        let task = session.dataTask(with: req, completionHandler: {(dataJSON,response,error) in
            
            
            if error == nil {
                do{
            
                //解析ＪＳＯＮ
                let jsonObj = try JSONSerialization.jsonObject(with: dataJSON!, options: .allowFragments)
                    
                    for a in  jsonObj as! [[String:String]]{
                    
                        print(a["id"]!)
                        print(a["dogpic"]!)
                        print(a["mastername"]!)
                         print(a["createdate"]!)
                        print(a["lng"]!)
                        print(a["lat"]!)
                        //變更文字及圖檔於背景執行
                        DispatchQueue.main.async {
                            let imgPath = a["dogpic"]
                            self.showImg(imgPath: imgPath!, docDir: docDir)
                            
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
                print("detail error:\(error)")
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
