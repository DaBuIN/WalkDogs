//
//  mapVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/16.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit
///////重要哦！
import CoreLocation
import MapKit


//如要改變大頭針的顏色 圖片等 須加
class mapVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    let lmgr = CLLocationManager()
    
    var mytitle:Array<String> = []
    var myLat:Array<String> =  []
    var myLng:Array<String> = []
    var lat = 24.127426
    var lng = 121.275753
    
    
    
    var annoArray:[MKPointAnnotation] = []
    
    //要改變圖片、大頭針顏色、顯示detail   需實作的方法。
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //如果是使用者的所在位置 不可以做任何處理
        
        var titleString = "測試"
        var imgDetail  = UIImage(named: "dog2.png")
        
        var titleString2 = "第二點"
        var imgDetail2  = UIImage(named: "dog3.png")
        
        //管理預設記憶體空間Pin。
        if annotation is MKUserLocation {
        
            return nil
        }
        
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            
        }
        
        
        
        //大頭針的照片 似乎只能一張
//        annView?.image = UIImage(named: "dog.png")
        
        annView?.image = UIImage(named: "dog3.png")

      
        
        //detail頁面
        
            //detail 圖
        if (annotation.title)! == titleString {
        
        let imageView = UIImageView(image: imgDetail)
            annView?.leftCalloutAccessoryView = imageView
        
        
        }
        if (annotation.title)! == titleString2 {
            
            let imageView = UIImageView(image: imgDetail2)
            annView?.leftCalloutAccessoryView = imageView
            
            
        }
            //detail label
        
        let label = UILabel()
        
        label.numberOfLines = 2
        
        label.text = "緯度"
        
            //detail btn  ==>可進入更detail頁面
        
        let button = UIButton(type: .detailDisclosure)
        button.tag = 100
        button.addTarget(self, action: #selector(btnDetail), for: .touchUpInside)
        
        annView?.rightCalloutAccessoryView = button
        
        
        //是否可拖曳
        annView?.isDraggable = true
        
        //是否可以callout
        annView?.canShowCallout = true
        
        
        
        
        return annView
    }
    
    
    
    //若欲拖曳 需實作一個didselect方法。  不用？
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.removeAnnotation(view.annotation!)
//    }
    
    
    //拖曳後再次出現 需實作此方法
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == .ending {
        
            view.dragState = .none
        }
    }
    
    
    
    
    
    //建一大頭針API  我自己設的ＡＰＩ
    func setAnnotation(lat:Double,lng:Double,title:String,subtitle:String) -> MKPointAnnotation {
    
        //建構大頭針物件
    let annotation = MKPointAnnotation()
    
        annotation.coordinate = CLLocationCoordinate2DMake(lat , lng)

        annotation.title = title
    
        annotation.subtitle = subtitle
    
        return annotation
    
    }
   
    
    
    //自制 detail btn
    func btnDetail(_ sender: UIButton){
    
        if sender.tag == 100 {

//            let alertController = UIAlertController(title: "detail", message: "不錯哦", preferredStyle: .alert)
//            
//            let okAction = UIAlertAction(title: "賀", style: .default, handler: {(action) in
//            
//                self.dismiss(animated: true, completion: nil)
//            })
//            
//            alertController.addAction(okAction)
//            
//            show(alertController, sender: self)
//            

            
            let vc = storyboard?.instantiateViewController(withIdentifier: "mapdetailvc")
            
            show(vc!, sender: self)
            
            
        }
    
    
    }
    
    
    
    //讀ＤＢ
    func loadDB() {
    
        //c9資料庫 post
        let url = URL(string: "https://together-seventsai.c9users.io/getSjc.php")
        let session = URLSession(configuration: .default)
    
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        //        req.httpBody = "account=\(account)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
        
            let source = String(data: data!, encoding: .utf8)
            
            //                print(source!)
        
            DispatchQueue.main.async {
                
                do{

                    
                    let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    var lastIndex:Int = 0
                    for a in  jsonobj as! [[String:String]] {
                        
                        
                        
                        var id = a["id"]!
                        var subject = a["subject"]!
                        var lat = a["lat"]!
                        var lng = a["lng"]!
                        var detail = a["detail"]!
                        var title = a["title"]!

                        self.mytitle += [title]
                        
                        self.myLat += [lat]
                        self.myLng += [lng]
                        
                        
                        print(self.myLat[0])
                        print(self.myLng[0])

                        print(self.mytitle[0])
                        
                        
                        let ann3 = self.setAnnotation(lat: Double(self.myLat[lastIndex])!, lng: Double(self.myLng[lastIndex])!, title: self.mytitle[lastIndex], subtitle: self.mytitle[lastIndex])
                        
//                        let ann3 = self.setAnnotation(lat: 24.123, lng: 121.3, title: self.mytitle[0], subtitle: self.mytitle[0])
//                        
                                        self.annoArray += [ann3]
                                    self.mapView.addAnnotations(self.annoArray)
                        
//                        mapView.reloadInputViews()

                        lastIndex += 1
                         print(type(of: self.annoArray))
                    }
                    
                    
                }catch {
                    print("thisis \(error)")
                }
                
            }

        })
            
            
        task.resume()

//        sleep(1)
        
//                mapView.addAnnotations(annoArray)


//                let ann3 = setAnnotation(lat: Double(myLat[0])!, lng: Double(myLng[0])!, title: mytitle[0], subtitle: mytitle[1])
//        
//        
//                self.annoArray += [ann3]
    }
    
    
        
        
        
            
            
            
            
        
        
       
        
 

  
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        
       

        
//        let ann1 =  setAnnotation(lat: lat, lng: lng, title: "測試", subtitle: "再測試")

        
        
//       let ann2 =  setAnnotation(lat: 24.2, lng: 121.275753, title: "第二點", subtitle: "就是第二點")
        
        
//        let ann3 = setAnnotation(lat: Double(myLat[0])!, lng: Double(myLng[0])!, title: mytitle[0], subtitle: mytitle[0])
        
        
//        annoArray += [ann1]
        
//        annoArray += [ann2]

//        annoArray += [ann3]
        

        
        
//        mapView.addAnnotations(annoArray)
        
        
        
        
        
    }

    
    
override    func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            self.myLat = []
            self.myLng = []
            self.loadDB()
            
//            print(self.myLat[0])
//            print(self.myLng[0])
//            self.mapView.addAnnotations(self.annoArray)

        }
    
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
