//
//  tableVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/6.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit
import CoreLocation

class tableVC: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let app = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mapWebView: UIWebView!
    @IBOutlet weak var tbView: UITableView!
//    var mydata:Array<String> = ["111","222","333","444","555","666","777","888","999","000"]
//    var myimg = [UIImage(named: "c.png"),UIImage(named: "ball.png"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg")]
    
    
    var mydata:Array<String> = []
    var mydoing:Array<String> = []
//
//    var myimg:Array<UIImage> = []
    
    
    var url = URL(string: "")
    
    
    
    let lmgr = CLLocationManager()
    
    var nowLat:Double?
    var nowLng:Double?
    var imgTaken:UIImage?
    
///////////////////////////////////////////////////////////////////////////////////
    
    
    //tableview幾列
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mydata.count
        
    }
    
    
    
    //tableView content
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "tbcell") as! tableViewCell
        
        cell.dogNameLabel.text = mydata[indexPath.row]
        cell.doingLabel.text = mydoing[indexPath.row]
//        cell.selfPhoto.image = myimg[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        
        
        return cell
        
        
        
    }
    

    //tableView select go where
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gowhere(whereVC: indexPath.row)
    }
    
    
    
    func gowhere(whereVC:Int){
        switch  whereVC {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "detailvc")
            show(vc!, sender: self)
        default:
            break
        }
    
    
    }
    
    
    
    
    
    //拍照
    @IBAction func takePic(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imgPicker = UIImagePickerController()
            
            imgPicker.sourceType = .camera
            imgPicker.delegate = self
            
            show(imgPicker, sender: self)
        
        }else {
            print("camera false")
        }
        
    }
    
    
    
    //拍照後處理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         imgTaken = info[UIImagePickerControllerOriginalImage] as! UIImage
       
        imgView.image = imgTaken

        
        dismiss(animated: true, completion: {() in })
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {() in } )
    }
    
    
    
    
    //取得ＧＰＳ位置
    @IBAction func getGPS(_ sender: Any) {
        

       print("緯經度：\(nowLat!),\(nowLng!)")
        
        

        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            let lat = loc.coordinate.latitude
            let lng = loc.coordinate.longitude
            let h = loc.altitude
            print("\(lat):\(lng):\(h)")
            nowLat = lat
            nowLng = lng
        }
    }
    
    
    
    @IBAction func pushUp(_ sender: Any) {
        
        let doing:String = inputText.text!
        if  doing != "" {
            
            if let imgTaken = imgTaken {
                let json = ["doing":"\(doing)","lat":"\(nowLat!)","lng":"\(nowLng!)","pic":"\(imgTaken)"]
                let doing:String = inputText.text!
                
                print(doing)
                
                print(json["lat"]!)
                print(json["lng"]!)
                print(json["pic"]!)
                
                
                
                
                let url = URL(string: "http://127.0.0.1/walkdog/postCard.php")

                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url!)
                
                request.httpBody = "account=\(app.account)&doing=\(doing)&lat=\(nowLat)&lng=\(nowLng)".data(using: .utf8)
                request.httpMethod = "POST"
                
                let task = session.dataTask(with: request)
                
                task.resume()
                
                
                
                
                
            }else{
            
                let json = ["lat":"\(nowLat!)","lng":"\(nowLng!)","pic":""]
                let doing:String = inputText.text!
                
                print(doing)
                
                print(json["lat"]!)
                print(json["lng"]!)
                print(json["pic"]!)
                
                let url = URL(string: "http://127.0.0.1/walkdog/postCard.php")
                
                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url!)
                
                request.httpBody = "account=\(app.account!)&doing=\(doing)&lat=\(nowLat!)&lng=\(nowLng!)".data(using: .utf8)
                request.httpMethod = "POST"
                
                let task = session.dataTask(with: request)
                
                task.resume()
                
                
            }
        
        
        }
        
       
        
        
       
      
        
      
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("123")
        //讀取ＴＡＢＬＥＶＩＥＷ
        loadDB()

        
        
        //取得ＧＰＳ
        lmgr.requestAlwaysAuthorization()
        
        lmgr.delegate = self
        
        lmgr.startUpdatingLocation()
        
        //ＷＥＢＶＩＥＷ顯示
        
        let url = Bundle.main.url(forResource: "map", withExtension: "html")
        let request = URLRequest(url: url!)
        
    
            mapWebView.loadRequest(request)
       
        
        
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func loadDB(){
        if let account = app.account {
            
            
            let url = URL(string: "http://127.0.0.1/walkdog/getTable.php?account=\(account)")
            //        do{
            //        let source = try String(contentsOf: url!)
            //
            //
            //            print(source)
            //        }catch{}
            
            
            //        let session = URLSession(configuration: .default)
            //        let task = session.dataTask(with: url!, completionHandler: {(data, respose,error) in
            do{
                let  data = try Data(contentsOf: url!)
                let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                for a in  jsonobj as! [[String:String]] {
                    print(a["account"]!)
                    mydata.append(a["account"]!)
                    mydoing.append(a["doing"]!)
                }
                
                
                
                
            }catch {}
        
        }else {
            
            //沒輸入帳號直接跑到的話 給他一個假帳號
            print("no account")
            let url = URL(string: "http://127.0.0.1/walkdog/getTable.php?account=1234")
            do{
                let  data = try Data(contentsOf: url!)
                let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                for a in  jsonobj as! [[String:String]] {
                    print(a["mastername"]!)
                    mydata.append(a["mastername"]!)                }

            }catch {
                print(error)
            }
            
        }

    }

    
    
    
    
    
    
    
    
    
    
    
}
