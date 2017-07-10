//
//  ViewController2.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/10.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

   
        
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
        var source:String?
        
        
        
        
        
        //登入帳密鈕
        @IBAction func login(_ sender: Any) {
            
            
            do{
                let account = loginAcc.text!
                let passwd = loginPwd.text!
                
                //本地
                //            let urlString:String = "http://127.0.0.1/walkdog/checkLogin.php?account=\(account)&passwd=\(passwd)"
                //c9
                let urlString:String = "https://sevensql-seventsai.c9users.io/checkLogin.php?account=\(account)&passwd=\(passwd)"
                
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
            //本地
            let url = URL(string: "http://127.0.0.1/walkdog/addMember.php")
            
            //c9
            
            
            
            var request = URLRequest(url: url!)
            
            
            
            
            if accountText.text  != "" && passwdText.text != "" && masternameText.text != "" {
                let account = accountText.text!
                let passwd = passwdText.text!
                let mastername = masternameText.text!
                
                
                //根本不需要用到ＵＲＬＲＥＱＵＥＳＲ
                //            request.httpBody = "account=\(account)&passwd=\(passwd)&mastername=\(mastername)".data(using: .utf8)
                //            request.httpMethod = "POST"
                //
                //            let session = URLSession(configuration: .default)
                //
                //            let task = session.dataTask(with: request, completionHandler: {(data, response , error) in
                //                //                print(data)
                //
                //            })
                //            task.resume()
                
                
                
                //取得後端傳回字串 確認是否可以新增帳號
                do{
                    let urlGet = URL(string: "http://127.0.0.1/walkdog/addMember.php?account=\(account)&passwd=\(passwd)&mastername=\(mastername)")
                    let source = try String(contentsOf: urlGet!, encoding: .utf8)
                    //                print(source)
                    //如果帳號存在
                    if source == "accountok" {
                        print("add OK")
                        let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
                        show(vc!, sender: self)
                        print("show")
                        
                        
                    }else if source == "accountexist" {
                        //                     self.alertOK()
                        //                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
                        //                    self.show(vc!, sender: self)
                        //            showDetailViewController(vc!, sender: self)
                        print("exist")
                        alertAccExist()
                        
                        
                    }else {
                        print("else")
                    }
                    
                    
                }catch{
                    print(error)
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            }else { print("no words")
                alertEmpty()
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
        
        func alertEmpty(){
            
            let alertController = UIAlertController(title: "帳號申請", message: "請勿空白", preferredStyle: .alert)
            let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
                self.dismiss(animated: true, completion: nil)
                
            })
            alertController.addAction(okaction)
            self.present(alertController, animated: true, completion: nil )
            
            
        }
        
        
        func alertAccExist(){
            let alertController = UIAlertController(title: "帳號已存在", message: "請發揮你的創意", preferredStyle: .alert)
            let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
                self.dismiss(animated: true, completion: nil)
            })
            
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

