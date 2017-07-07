//
//  ViewController.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/6.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginAcc: UITextField!
    
    @IBOutlet weak var loginPwd: UITextField!
    @IBOutlet weak var segmentedC: UISegmentedControl!
  
    
    @IBAction func home(segue: UIStoryboardSegue){
    
    }
    
    @IBOutlet weak var accountText: UITextField!
    
    
    @IBOutlet weak var passwdText: UITextField!
    
    @IBOutlet weak var masternameText: UITextField!
//    let account = accountText.text!
//    let passwd = passwdText.text!
//    let mastername = masternameText.text!
    
    let app = UIApplication.shared.delegate as! AppDelegate

    //登入帳密鈕
    @IBAction func login(_ sender: Any) {
        
        
        do{
        let account = loginAcc.text!
        let passwd = loginPwd.text!
            let urlString:String = "http://127.0.0.1/walkdog/checkLogin.php?account=\(account)&passwd=\(passwd)"
        
        let url = URL(string: urlString)
        let source = try String(contentsOf: url!, encoding: .utf8)

            if source == "pass"{
                
                
                self.app.account = account
               self.app.passwd = passwd
                let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
                show(vc!, sender: self)
                
                
              
                
                
            
            }else if source == "passwdwrong"{
                    print("密碼錯了")
            
            }else if source == "accountwrong"{
                print("帳號錯了")
            }
            
            
            
        }catch {
            print(error)
        }
        
        
        
        
        
        
    }
    
    
    //創建帳號密碼 送出鈕
    @IBAction func submitBtn(_ sender: Any) {
        
        let url = URL(string: "http://127.0.0.1/walkdog/addMember.php")
        var request = URLRequest(url: url!)
        
     
        
        
        if accountText.text  != "" && passwdText.text != "" && masternameText.text != "" {
           let account = accountText.text!
            let passwd = passwdText.text!
             let mastername = masternameText.text!
            
            
            request.httpBody = "account=\(account)&passwd=\(passwd)&mastername=\(mastername)".data(using: .utf8)
            request.httpMethod = "POST"
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                print(data)
                
               
               
                
            })
            task.resume()
            alertOK()
            let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
            show(vc!, sender: self)
//            showDetailViewController(vc!, sender: self)
            
        
        }else { print("no words")
            alertWrong()
        }
        
        
        
        
        
    }
    
    //新增帳號 alertOK
    func alertOK(){
    
        let alertController = UIAlertController(title: "會員申請", message: "申請成功", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil )
        
    }
    //新增帳號 alertwrong

    func alertWrong(){
        
        let alertController = UIAlertController(title: "帳號申請", message: "請勿空白", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil )
        
        
    }
    
    
    
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "tableviewvc"){
//            
//            let vc = segue.destination as! tableVC
//            
//            
//            
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

