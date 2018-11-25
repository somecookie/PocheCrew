//
//  ViewController.swift
//  Lauzhack18
//
//  Created by Lionel Pellier on 24/11/2018.
//  Copyright © 2018 Lionel Pellier. All rights reserved.
//

import UIKit
import Moya
import Toast_Swift

var IP_SERVER: String = "http://128.179.140.166:8080"

class MyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    let imagePicker = UIImagePickerController()
    var image = UIImage()
    let provider = MoyaProvider<ImageAPI>()
    let stubProvider = MoyaProvider<ImageAPI>(stubClosure: MoyaProvider.immediatelyStub)
    
    @IBOutlet weak var tfIP1: UITextField!
    @IBOutlet weak var tfIP2: UITextField!
    @IBOutlet weak var tfIP3: UITextField!
    @IBOutlet weak var tfIP4: UITextField!
    
    
    private var state: State = .standby {
        didSet {
            switch state {
            case .standby:
                debugPrint("standby")
            case .ready:
                debugPrint("ready")
            case .loading:
                debugPrint("loading")
            case .error:
                debugPrint("error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .standby
        
        imagePicker.delegate = self
        tfIP1.delegate = self
        tfIP2.delegate = self
        tfIP3.delegate = self
        tfIP4.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipes" {
            guard case .ready(let recipes) = state else {return}
            
            let destination = segue.destination as! RecipesTableViewController
            destination.recipes = recipes
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = pickedImage
            self.provider.request(.image(image)){ [weak self] userResult in
                guard let self = self else { return }
                
                switch userResult{
                case .success(let recipesResponse):
                    do{
                        let recipes = try recipesResponse.map([Recipe].self)
                        self.state = .ready(recipes)
                        self.performSegue(withIdentifier: "recipes", sender: self)
                    } catch{
                        self.state = .error
                    }
                case .failure:
                    self.state = .error
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func checkAddressIP() -> Bool{
        let ip1 = Int(tfIP1.text!)
        let ip2 = Int(tfIP1.text!)
        let ip3 = Int(tfIP1.text!)
        let ip4 = Int(tfIP1.text!)
        if (ip1 == nil || ip2 == nil || ip3 == nil || ip4 == nil){
            self.view.makeToast("IP should only contain number between 0 and 255")
            return false
        }
        else{
            if((0 <= ip1! && ip1! < 255) &&
               (0 <= ip2! && ip2! < 255) &&
               (0 <= ip3! && ip3! < 255) &&
               (0 <= ip4! && ip4! < 255)){
                let ip_address = "http://" + String(ip1!) + "." + String(ip2!) + "." + String(ip3!) + "." + String(ip4!) + ":8080"
                IP_SERVER = ip_address
                return true
            }
            else{
                self.view.makeToast("IP should only contain number between 0 and 255")
                return false
            }
        }
    }
    
    @IBAction func takePicture(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        if (tfIP1.text == "" && tfIP2.text == "" && tfIP3.text == "" && tfIP4.text == "") || checkAddressIP(){
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    ///When a user click anywhere outside of the keyboard, the keyboard is dismissed
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension MyViewController {
    enum State {
        case loading
        case ready([Recipe])
        case error
        case standby
    }
}
