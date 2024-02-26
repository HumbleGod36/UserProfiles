//
//  UserListViewController.swift
//  UserProfiles
//
//  Created by Tony Michael on 15/01/24.
//

import UIKit
import SDWebImage


class UserListViewController: UIViewController  , AddProfileData{
    func gettingdata(profileData: ProfileModel!) {
        profile.append(profileData)
        filteredProfiel = profile
        entireTable.reloadData()
    }
    var isAdded:Bool?
    var filteredProfiel = [ProfileModel]()
    var profile = [ProfileModel]()
    var sendProfile : [String] = []
    var searchElement : UISearchBar!
    var profileIsClicked:Bool = false
    
    
    @IBOutlet weak var entireTable: UITableView!
    @IBOutlet weak var SearchBarField: UISearchBar!
    
    @IBAction func addUserClicked(_ sender: Any) {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "AddProfileViewController") as! AddProfileViewController
        vc1.modalPresentationStyle = .fullScreen
        self.present(vc1, animated: true)
        
        vc1.protocall = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchBarField.delegate = self
        entireTable.delegate = self
        entireTable.dataSource = self
        entireTable.register(UINib(nibName: "TableTableViewCell", bundle: nil), forCellReuseIdentifier: "TableTableViewCell")
        entireTable.register(UINib(nibName: "HeaderViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderViewCell")
        fetchData()
        filteredProfiel  = profile
    }
    
    func fetchData() {
        if let path = Bundle.main.path(forResource: "DummuData", ofType: "json")
        {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do{
                    let object = try JSONDecoder().decode([ProfileModel].self, from: data)
                    print(object)
                    self.profile = object
                    
                    entireTable.reloadData()
                }catch {
                    print(error)
                }
            }catch {
                print(error)
            }
        }
    }
    
    
    
}
extension UserListViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProfiel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableTableViewCell", for: indexPath) as! TableTableViewCell
        cell.profileName.text = filteredProfiel[indexPath.row].yourName
        cell.userPhoneNumber.text = filteredProfiel[indexPath.row].phone
        if filteredProfiel[indexPath.row].profileImageUrl == "" {
            cell.profileImage.image = try? fetchFile(with: filteredProfiel[indexPath.row].profileImage)
        }else {
            cell.profileImage.sd_setImage(with: URL(string: filteredProfiel[indexPath.row].profileImageUrl))
        }
        cell.profileName.tag = indexPath.row
        return cell
    }
    
    func fetchFile(with name: String ) throws -> UIImage? {
        let fileManager = FileManager.default
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documentDirectory.appendingPathComponent(name)
        let image    = UIImage(contentsOfFile: fileURL.path)
        // Do whatever you want with the image
        return image
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderViewCell") as! HeaderViewCell
        cell.headerLabel.text  = "Name List"
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print("Cell Clicked" )
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddProfileViewController") as! AddProfileViewController
        
        vc.cellIsClicked  = true
        do {
            vc.profileImage = try fetchFile(with: filteredProfiel[indexPath.row].profileImage)
        }catch {
            print (error)
        }
        //        vc.profileImageURL.sd_setImage(with: URL(string: filteredProfiel[indexPath.row].profileImageUrl))
        vc.phone = filteredProfiel[indexPath.row].phone
       // vc.is_male = filteredProfiel[indexPath.row].isMale
        vc.cellIsClicked = true
        vc.name =  filteredProfiel[indexPath.row].yourName
        print (vc.name)
        
        vc.modalPresentationStyle = .fullScreen
       present(vc, animated: true)
        
    }
}
extension UserListViewController : UISearchBarDelegate  {
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            filteredProfiel = profile.filter({ profile in
                profile.yourName.uppercased().contains(searchText.uppercased())
            })
        }else {
            filteredProfiel = profile
        }
        entireTable.reloadData()
    }
    
}
