//
//  MainViewController.swift
//  new_redy4s
//
//  Created by Bartek Lanczyk on 11.12.2016.
//  Copyright © 2016 miltenkot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    
    //User messages
    @IBOutlet weak var errorLabel: UIImageView!
    @IBOutlet weak var correctImage: UIImageView!
    
    @IBOutlet weak var labelTextField: UITextField!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var shortenURLButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            revealViewController().rearViewRevealOverdraw = 0
            labelTextField.delegate = self
            if (labelTextField.text?.isEmpty)!{
                shortenURLButton.isUserInteractionEnabled = false
            }
         
            
    }
  
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   fileprivate struct Api{
        static let key = "AIzaSyAU_qsy0wR-_onF5haH94lVoSMQoezC6dc"
    }
    //MARK: TextField properties
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        
        if !(labelTextField.text?.contains(" "))! &&
            !(labelTextField.text?.isEmpty)! {
            
            shortenURLButton.isUserInteractionEnabled = true
            
        }else {
            shortenURLButton.isUserInteractionEnabled = false
        }
        return true
        
    }
  
  
    // MARK: - Actions

    @IBAction func addToCoreData(_ sender: UIButton) {
        if !(labelTextField.text?.isEmpty)!{
        let temp_orginal = labelTextField.text!
            
        let temp_short   = urlShorted(labelTextField.text!,with: Api.key)
        
        //Save the data to coredata
        if temp_short != "" {
            let appDelegat = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegat.persistentContainer.viewContext
            let data_model = URL_Entity(context: context)
            data_model.orginal_url = temp_orginal
            data_model.short_url = temp_short
            appDelegat.saveContext()
            self.correctImage.fadeIn(completion:{
                (finished: Bool)-> Void in
                self.correctImage.fadeOut()
            })
            
        } else {
            
            
           //Show error massage
            self.errorLabel.fadeIn(completion: {
                (finished: Bool) -> Void in
                self.errorLabel.fadeOut()
            })
            
            
            sender.isUserInteractionEnabled = false
        }
        }
        labelTextField.text = ""
    }
    
    func urlShorted(_ url:String,with api:String)->String{
    let request = URLShortenerRequest(APIKey: api, URL: URL(string:url)!)
       
        let result = request.getShortURL()
        switch result {
        case .success(let URL):
            return String(describing: URL)
        default:
            return ""
            
        }
    
    }

}
//MARK: UIView extension
extension UIView{
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    
}
