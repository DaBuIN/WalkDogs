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

//    @IBOutlet weak var imgTest: UIImageView!
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mapWebView: UIWebView!
    @IBOutlet weak var tbView: UITableView!
//    var mydata:Array<String> = ["111","222","333","444","555","666","777","888","999","000"]
//    var myimg = [UIImage(named: "c.png"),UIImage(named: "ball.png"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg")]
    
    //顯示tbView content
    var mydata:Array<String> = []
    var mydoing:Array<String> = []
    var mydate:Array<String> = []
    var myphoto:Array<String> = []

    //gettable.php 回傳的ＪＳＯＮ的ＩＤ
    var myidtoimg:Array<String> = []
//
//    var myimg:Array<UIImage> = []
    
    
    var url = URL(string: "")
    
    let fmgr = FileManager.default
    let docDir = NSHomeDirectory() + "/Documents"
    
    let lmgr = CLLocationManager()
    
    var nowLat:Double?
    var nowLng:Double?
    var imgTaken:UIImage?
    var sentToDetailId:String?
    var imgFile:String?
    
///////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        app.cleanVar()
        let vc = storyboard?.instantiateViewController(withIdentifier: "home")
        show(vc!, sender: self)
    }
    
    
    
    @IBAction func reload(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
//        show(vc!, sender: self)

        
        reflashTable()
        
    }
    
    
    //tableview幾列
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mydata.count
    
    }
    
    
    
    //tableView content
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "tbcell") as! tableViewCell
        
        cell.dogNameLabel.text = mydata[indexPath.row]
//        cell.doingLabel.text = mydoing[indexPath.row]
//        cell.selfPhoto.image = myimg[indexPath.row]
        cell.dateTimeLabel.text = mydate[indexPath.row]
        
        var photoPath = docDir + myphoto[indexPath.row]
        
        
        let img = UIImage(named: "dog.png")
        print("tableView image 路徑測試：\(photoPath)")
//        cell.selfPhoto.image = img
        
        cell.selfPhoto.image = UIImage(contentsOfFile: photoPath)
        
        cell.accessoryType = .disclosureIndicator
        

        
        return cell
        
        
        
    }
   

    //tableView select go where
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         print(indexPath.row)
        print(mydata[indexPath.row])
        print(myidtoimg[indexPath.row])
        self.app.sentToDetailId = myidtoimg[indexPath.row]
        print(self.app.sentToDetailId)
        gowhere(whichVC: indexPath.row)
        
    }
    
    
    
    func gowhere(whichVC:Int){
//        switch  whichVC {
//        case 0:
        
        
            let vc = storyboard?.instantiateViewController(withIdentifier: "detailvc")
            show(vc!, sender: self)
//        default:
//            break
//        }
    
    
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
       
        let data = UIImageJPEGRepresentation(imgTaken!, 0.9)
  
        imgView.image = imgTaken
        
        
        //時間
        let interval = Date.timeIntervalSinceReferenceDate
        //                let docDir = NSHomeDirectory() + "/Documents"
        
        let imgRelativePath = "/saveimg/\(app.account!)_\(interval).jpg"
        
        //圖片的命名(其路徑含名稱)
        let imgFile = "\(docDir)\(imgRelativePath)"
        print("imgFile:\(imgFile)")
        //pathString to url
        let urlFilePath = URL(fileURLWithPath: imgFile)
        do {
            //將data 存下來
            
            
            try data?.write(to: urlFilePath)
            
            print("save ok")
        }catch {
            print(error)
        }

        

        
        dismiss(animated: true, completion: {() in })
    }
    
    
    //按取消時要消失
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
//            print("\(lat):\(lng):\(h)")
            nowLat = lat
            nowLng = lng
        }
    }
    
    
    
    @IBAction func pushUp(_ sender: Any) {
        
        let doing:String = inputText.text!
        if  doing != "" {
            
            //先暫時塞給他一個UIImage
//                imgTaken = UIImage(named: "dog3.png")
            
        
            
            if let imgTaken = imgTaken {
            
                print("imgTaken")
                
                //假裝拍照完
                let data = UIImageJPEGRepresentation(imgTaken, 0.9)
                
                imgView.image = imgTaken
                
                
                //時間
                let interval = Date.timeIntervalSinceReferenceDate
//                let docDir = NSHomeDirectory() + "/Documents"

                let imgRelativePath = "/saveimg/\(app.account!)_\(interval).jpg"
                
                //圖片的命名(其路徑含名稱)
                let imgFile = "\(docDir)\(imgRelativePath)"
                print("imgFile:\(imgFile)")
                //pathString to url
                let urlFilePath = URL(fileURLWithPath: imgFile)
                do {
                    //將data 存下來
   
                    
                    try data?.write(to: urlFilePath)
                  
                    print("save ok")
                }catch {
                    print(error)
                }

                

//                let json = ["doing":"\(doing)","lat":"\(nowLat!)","lng":"\(nowLng!)","dogpic":"imgpath"]
                let doing:String = inputText.text!
                
//                print(doing)
//                
//                print(json["lat"]!)
//                print(json["lng"]!)
//                print(json["pic"]!)

                //local db no use
//                let url = URL(string: "http://127.0.0.1/walkdog/postCard.php")
                //c9 db
                let url = URL(string: "https://sevensql-seventsai.c9users.io/postCard.php")

                
                
                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url!)
                

            
                
                request.httpBody = "account=\(app.account!)&doing=\(doing)&lat=\(nowLat!)&lng=\(nowLng!)&dogpic=\(imgRelativePath)".data(using: .utf8)
                request.httpMethod = "POST"
                
     
                let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                    
                 
                    
                    
                    if  error != nil {
                        print("gg")
                    }else{
                        print("success")
                        
                    }
                    
                    
                })
                
                
                task.resume()
                //睡一秒是為了等ＤＢ茲料上船好
                
                sleep(1)
                self.reflashTable()


               
            }else{
                //如果沒有上傳照片
                print("imgUnTaken")
                //預設照片
                let imgTaken = UIImage(named: "dog3")
                
                
                
                
                let data = UIImageJPEGRepresentation(imgTaken!, 0.9)
                
                imgView.image = imgTaken
                
                
                //時間
                let interval = Date.timeIntervalSinceReferenceDate
                //                let docDir = NSHomeDirectory() + "/Documents"
                
                let imgRelativePath = "/saveimg/\(app.account!)_\(interval).jpg"
                
                //圖片的命名(其路徑含名稱)
                let imgFile = "\(docDir)\(imgRelativePath)"
                print("imgFile:\(imgFile)")
                //pathString to url
                let urlFilePath = URL(fileURLWithPath: imgFile)
                do {
                    //將data 存下來
                    
                    
                    try data?.write(to: urlFilePath)
                    
                    print("save ok")
                }catch {
                    print(error)
                }

                
                
                
                
                
                
//                let json = ["lat":"\(nowLat!)","lng":"\(nowLng!)","pic":"\(imgTaken)"]
                
                let doing:String = inputText.text!
                
//                print(doing)
//                
//                print(json["lat"]!)
//                print(json["lng"]!)
//                print(json["pic"]!)
                
                //local db
//                let url = URL(string: "http://127.0.0.1/walkdog/postCard.php")
                //c9 db
                let url = URL(string: "https://sevensql-seventsai.c9users.io/postCard.php")
                
                
                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url!)
                
//                request.httpBody = "account=\(app.account!)&doing=\(doing)&lat=\(nowLat!)&lng=\(nowLng!)&dogpic=/\"\"".data(using: .utf8)
                
                request.httpBody = "account=\(app.account!)&doing=\(doing)&lat=\(nowLat!)&lng=\(nowLng!)&dogpic=\(imgRelativePath)".data(using: .utf8)
                
                request.httpMethod = "POST"
                
//                let task = session.dataTask(with: request)
                
               let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                
                
                
                
                
                
                    if  error != nil {
                        print("gg")
                    }else{
                        print("success")
//                        sleep(1)
//                        self.loadDB()
//                        print("reload")
                }
                
                    
                    
                })
//                alertSubmit()
                task.resume()
                sleep(1)
                self.reflashTable()

                }
                
            
        
        
        }
        
       
        
        
      
        
      
        
        
    }
    
    
    
    //打卡確認鈕
    func alertSubmit(){
        
        let alertController = UIAlertController(title: "打卡上傳", message: "動態與照片即將送出", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: {() in
                
                sleep(1)
                self.tbView.reloadData()

                self.reflashTable()
                self.tbView.reloadData()
            
            })
            
        })
        let cancelaction = UIAlertAction(title: "取消", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: {() in
                
            })

        })
        alertController.addAction(okaction)
        alertController.addAction(cancelaction)

        self.present(alertController, animated: true, completion: nil )
        
        
    }
    
    
    
    //重新導到這頁。為了reflash tbcell content用
    func reflashTable(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
        show(vc!, sender: self)
        
    }
    
    
    //確認 拍照相片的儲存路徑是否存在。 在viewdidload先執行
    func checkImgPath(dirImg:String){
    
        
        //先檢查資料夾在不在。不在的話先新增
        if !fmgr.fileExists(atPath: dirImg) {
            
            do{
                try fmgr.createDirectory(atPath: dirImg, withIntermediateDirectories: true, attributes: nil)
                print("create Dir")
            }catch{
                print(error)
            }
            
        }else {print("mydata exist")}
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("123")
//        let interval2 = Date.timeIntervalSinceReferenceDate
//        print(interval2)
        //確認相片將存之路徑是否存在
        let dirImg = docDir +  "/saveimg"
        print(dirImg)
        checkImgPath(dirImg: dirImg)
        
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
       
//        if app.account != nil {
//        print(app.account!)
//        }else{
//            print("didloag:no account")
//        }
//        
//        if app.mastername != nil{
//        print(app.mastername!)
//        }else{
//            print("didload:no name")
//        }
        
   
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
    
    
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
            //get 本地資料庫 不用了
//            let url = URL(string: "http://127.0.0.1/walkdog/getTable.php?account=\(account)")
            
            
            //c9資料庫 post
            let url = URL(string: "https://sevensql-seventsai.c9users.io/getTable.php")
            let session = URLSession(configuration: .default)
            
            
           var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "account=\(account)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
//                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            //                        print(a["account"]!)
                            
                            
//                           print (a["mastername"]! + "正在" + a["doing"]! + "於" + a["createdate"]!)
                            
                            var mastername = a["mastername"]!
                            var doing = a["doing"]!
                            var createdate = a["createdate"]!
                            var idforimg = a["id"]!
                            var dogpic = a["dogpic"]!
                            
                            var pushContent = "\(mastername)" + "正在" + "\(doing)"
                            
                            //應該是辨識圖片的id
                            self.myidtoimg.append("\(idforimg)")
                            //名字與動作
                            self.mydata.append("\(pushContent)")
                            //時間顯示
                            self.mydate.append("\(createdate)")
                            
                            self.myphoto.append("\(dogpic)")


                            
                            //                            self.mydata.append(a["mastername"]!)
//                            self.mydoing.append(a["doing"]!)
                            
                            
//                              print("gettable mastername=" + a["mastername"]!)
                            
                            
                            
                        }
                        
                        
                        self.tbView.reloadData()
                        
                    }catch {
                        print("thisis \(error)")
                    }}
                

                
                
                
            })
        
            task.resume()
            
            //        do{
            //        let source = try String(contentsOf: url!)
            //
            //
            //            print(source)
            //        }catch{}
            
            
            //        let session = URLSession(configuration: .default)
            //        let task = session.dataTask(with: url!, completionHandler: {(data, respose,error) in

            
            //讀本機 mysql可以
//            do{
//                
//                let  data = try Data(contentsOf: url!)
//                let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                
//                for a in  jsonobj as! [[String:String]] {
//                    print(a["account"]!)
//                    mydata.append(a["account"]!)
//                    mydoing.append(a["doing"]!)
//                }
//                
//                
//                
//                
//            }catch {}
        
        }else {
            
            //沒輸入帳號直接跑到的話 給他一個假帳號
            print("no account")
            
            //192.168.1.136
//            169.254.227.115
//            let url = URL(string: "http://127.0.0.1/walkdog/getTable.php?account=1234")
//            let url = URL(string: "http://10.2.12.133/walkdog/getTable.php?account=1234")
//            do{
//                let  data = try Data(contentsOf: url!)
//                let jsonobj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                
//                for a in  jsonobj as! [[String:String]] {
//                    print(a["account"]!)
//                    mydata.append(a["account"]!)                }
//
//            }catch {
//                print(error)
//            }
//            
        }

    }

    
    
    
    
    
    
    
    
    
    
    
}
