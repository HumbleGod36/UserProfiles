//
//  AddProfileViewController.swift
//  UserProfiles
//
//  Created by Tony Michael on 16/01/24.
//

import UIKit
protocol AddProfileData {
    func gettingdata (profileData : ProfileModel!)
}
let imageURL = ""
class AddProfileViewController: UIViewController , UITextFieldDelegate, UIGestureRecognizerDelegate {
    var isMale : Bool = true
    
    
    
    var DateFormate : DateFormatter {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "dd/MM/yyy"
        return dateFormate
    }
    
    var protocall : AddProfileData?
    
    @IBAction func addImageButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select", message: "Select Image From" , preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in self.selectingImageFrom(sourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { UIAlertAction in
            self.selectingImageFrom(sourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
        
        
        
    }
    func selectingImageFrom (sourceType : UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        if userNameTextField.hasText && passwordTextField.hasText {
            if addImage.image != nil  {
                do{
                    let imageFileName = "\(Int(Date().timeIntervalSince1970)).jpeg"
                    try saveFile(with: imageFileName, image: addImage.image!)
                    protocall?.gettingdata(profileData: ProfileModel.init(profileImageUrl: "", profileImage: imageFileName, yourName: userNameTextField.text ?? "", phone: passwordTextField.text ?? "", birthday: pickedDate , isMale: true, notes: ""))
                    self.dismiss(animated: true)
                }catch {
                    print(error)
                }
                
            }
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Enter your Name and Password ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self.present(alert, animated: true)
        }
        print (pickedDate)
        
        
    }
    func saveFile(with name: String , image : UIImage) throws {
        let fileManager = FileManager.default
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentDirectory.appendingPathComponent(name)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { throw URLError(.cannotDecodeContentData) }
        try imageData.write(to: fileURL)
    }
    
    var profileImage : UIImage?
    var profileImageURL : String = ""
    var name : String = ""
    var phone : String = ""
    var birthDay: String = ""
    var is_male: Bool?
    var notes: String = ""
    var cellIsClicked :Bool = false
    
    
    
    
    var pickedDate: String = ""
    @IBOutlet weak var maleButtonOutlet: UIButton!
    @IBOutlet weak var femaleOutlet: UIButton!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickedDate = DateFormate.string(from: Date())
        birthDatePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.delegate = self
        
        view.addGestureRecognizer(tapGesture)
        
        if cellIsClicked == true {
            userNameTextField.text = name
            passwordTextField.text = phone
            birthDay = DateFormate.date(from: birthDay)
            if let date = dateFormatter.date(from: pickedDate) {
                birthDatePicker.setDate(date, animated: true)
            }
            notes = ""
           
            
            
            
        }
        
        
    }
    
    @objc func tapped(){
        view.endEditing(true)
    }
    
    @objc func dateChanged (_ sender : UIDatePicker){
        pickedDate = DateFormate.string(from: sender.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField == textField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension AddProfileViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addImage.image = image
        }
        dismiss(animated: true)
        
    }
}

