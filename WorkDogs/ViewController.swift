//
//  ViewController.swift
//  WorkDogs
//
//  Created by Seven Tsai on 2017/7/6.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBOutlet weak var addmemberAccLabel: UILabel!
//   
//    
//    @IBOutlet weak var addmemberPwdLabel: UILabel!
//    
//    @IBOutlet weak var addmemberMNameLabel: UILabel!
    
    
    @IBOutlet weak var addMemberBtnOutlet: UIButton!
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
//    @IBOutlet weak var loginAccLebel: UILabel!
//    
//    @IBOutlet weak var loginPwdLebel: UILabel!
    
    
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
    var account:String?
    var passwd:String?
    var mastername:String?
    
    var isLogin = true
    
    
    //segmented 切換鈕。切換登入或註冊
    @IBAction func segAction(_ sender: Any) {
        switch segmentedC.selectedSegmentIndex {
        case 0:
            isLogin = false
            addMemberOrLoginState()
        case 1:
            isLogin = true
            addMemberOrLoginState()
        default:
            isLogin = false
            addMemberOrLoginState()
            
        }
    }
    
    func addMemberOrLoginState(){
        //註冊時
        if isLogin == false {
            loginAcc.isHidden = true
            loginPwd.isHidden = true
//            loginAccLebel.isHidden = true
//            loginPwdLebel.isHidden = true
            loginBtnOutlet.isHidden = true
         
//            addmemberAccLabel.isHidden = false
//            addmemberPwdLabel.isHidden = false
//            addmemberMNameLabel.isHidden = false
            addMemberBtnOutlet.isHidden = false
            accountText.isHidden = false
            passwdText.isHidden = false
            masternameText.isHidden = false
            //登入時
        }else {
        
            loginAcc.isHidden = false
            loginPwd.isHidden = false
//            loginAccLebel.isHidden = false
//            loginPwdLebel.isHidden = false
            loginBtnOutlet.isHidden = false
            
//            addmemberAccLabel.isHidden = true
//            addmemberPwdLabel.isHidden = true
//            addmemberMNameLabel.isHidden = true
            addMemberBtnOutlet.isHidden = true
            accountText.isHidden = true
            passwdText.isHidden = true
            masternameText.isHidden = true
        }
    
    }
    
//    func changeToLogin(){
//       
//    }
    
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
        //本地ＤＢ 不用
//        let url = URL(string: "http://127.0.0.1/walkdog/addMember.php")
        
        //c9
        let url = URL(string: "https://sevensql-seventsai.c9users.io/addMember.php")

        
        
        
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
                //本地ＤＢ 不用了
//                let urlGet = URL(string: "http://127.0.0.1/walkdog/addMember.php?account=\(account)&passwd=\(passwd)&mastername=\(mastername)")
                
                
                // 用c9 ＰＨＰ與ＤＢ
                let urlGet = URL(string: "https://sevensql-seventsai.c9users.io/addMember.php?account=\(account)&passwd=\(passwd)&mastername=\(mastername)")
                
            let source = try String(contentsOf: urlGet!, encoding: .utf8)
//                print(source)
                //如果帳號不存在
                if source == "accountok" {
                    print("add OK")
                    self.app.account = account
                    self.app.mastername = mastername
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
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil )
    }

    
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin = true
        addMemberOrLoginState()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

