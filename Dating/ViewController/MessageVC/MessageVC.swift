//
//  MessageVC.swift
//  Dating
//
//  Created by Iram Khan on 04/10/23.
//

import UIKit

class MessageVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var collMatches: UICollectionView!
    @IBOutlet weak var tblFriends: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCVCUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Functions---
    func setupCVCUI(){
        self.collMatches.register(UINib.init(nibName:"NewMatchesCVC", bundle: nil), forCellWithReuseIdentifier: "NewMatchesCVC")
        self.tblFriends.register(UINib.init(nibName: "FriendsTVC", bundle: nil), forCellReuseIdentifier: "FriendsTVC")
    }
  
}
//MARK: ---CollectionView Extension---
extension MessageVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewMatchesCVC", for: indexPath) as! NewMatchesCVC
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 70, height:(self.collMatches.bounds.height))
        }
}
//MARK: ---TableView Extension---
extension MessageVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFriends.dequeueReusableCell(withIdentifier: "FriendsTVC", for: indexPath) as! FriendsTVC
   
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
}
