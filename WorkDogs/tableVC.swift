//
//  tableVC.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/6.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class tableVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let app = UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet weak var tbView: UITableView!
//    var mydata:Array<String> = ["111","222","333","444","555","666","777","888","999","000"]
    var myimg = [UIImage(named: "c.png"),UIImage(named: "ball.png"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg"),UIImage(named: "c.png"),UIImage(named: "apple.jpg")]
    
    
    var mydata:Array<String> = []
//
//    var myimg:Array<UIImage> = []
    
    
    var url = URL(string: "")
    
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mydata.count
        
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "tbcell") as! tableViewCell
        
        cell.dogNameLabel.text = mydata[indexPath.row]
//        cell.selfPhoto.image = myimg[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        
        
        return cell
        
        
        
    }
    

    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("123")
        
        let url = URL(string: "http://127.0.0.1/walkdog/getTable.php?account=1234")
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
                print(a["mastername"]!)
                mydata.append(a["mastername"]!)                }
                
                
                
                
                }catch {}
//            mydata = arr
//        })
//        task.resume()
    
        
    
//        mydata.append("大摳")
//        myimg.append(UIImage(named: "c.png")!)

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
    
}
