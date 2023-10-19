//
//  ProfileSetupVC.swift
//  Dating
//
//  Created by Iram Khan on 03/10/23.
//

import UIKit
import DKImagePickerController
import AVFoundation
import Photos
import PhotosUI

var imageLink = ""
class ProfileSetupVC: UIViewController {

    //MARK: ---Outlets---
    @IBOutlet weak var imgProfile:UIImageView!
    @IBOutlet weak var collImage:UICollectionView!
    
    // MARK:  --- VARIABLES ---
    var productImage : [UIImage] = []
    var profileimage = UIImage()
    var pickerController1: DKImagePickerController!
    var assets: [DKAsset]?
    var exportManually = false
    var selectPhotoType = ""
    var isCome = ""
    var model = MainViewModel()
    var imagebucket = [String]()
    
    //MARK: ---VoewLife Cycle---
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCVCUI()
        addproducts()
        self.model.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: ---Functions---
    func setupCVCUI(){
        self.collImage.register(UINib.init(nibName:"AddProductPhotoCVC2", bundle: nil), forCellWithReuseIdentifier: "AddProductPhotoCVC2")
    }
    
//MARK: ---Button Action---
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.tag == 0{
            print("Back")
            self.navigationController?.popViewController(animated: true)
        }else if sender.tag == 1{
            print("Camera")
            checkPermissionsAndProceed()
            
        }else if sender.tag == 2{
            print("Done")

            self.model.uploadImage(param: [:], images: productImage)
           
        }
    }
}

// MARK: --- EXTENSIONS ---
extension ProfileSetupVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func addproducts(){
        let pickerController = DKImagePickerController()
        pickerController.assetType = .allPhotos
        pickerController.sourceType = .photo
        self.pickerController1 = pickerController
    }
    func checkPermissionsAndProceed(){
        let actionSheet = UIAlertController(title: "Choose any option", message: "choose as you like here!", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch cameraAuthorizationStatus {
            case .notDetermined: self.requestCameraPermission()
            case .authorized: self.presentCamera()
            case .restricted, .denied: self.alertCameraAccessNeeded()
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {
            action in
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (status) in
                })
            case .restricted: fallthrough
                print("Fallthrough")
            case .denied:
                print("denied")
                Alert.showAlertWithOkCancel(message: "Grant permission to access photos", actionOk: "OK", actionCancel: "Cancel") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } completionCancel:{
                    
                }
                break
            case .authorized:
            //   self.snippetImage.removeAll()
                self.assets?.removeAll()
                self.pickerController1.deselectAll()
                self.showImagePicker()
                break
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
        }))
        actionSheet.popoverPresentationController?.sourceView = self.view
        //                actionSheet.popoverPresentationController?.sourceRect = sender.frame
        self.present(actionSheet, animated: true, completion: nil)
    }
    func requestCameraPermission(){
           AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
               guard accessGranted == true else { return }
               self.presentCamera()
           })
       }
        func presentCamera(){
                DispatchQueue.main.async {
                    let photoPicker = UIImagePickerController()
                    photoPicker.sourceType = .camera
                  
                    photoPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                    self.present(photoPicker, animated: true, completion: nil)
                }
            }
    func alertCameraAccessNeeded() {
            let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
            let alert = UIAlertController(
                title: "Need Camera Access",
                message: "Camera access is required to make full use of this app.",
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
                UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    
    //Simgle Image
    func addimage() {
        let actionSheet = UIAlertController(title: "Choose any option", message: "choose as you like here!", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch cameraAuthorizationStatus {
            case .notDetermined: self.requestCameraPermission()
            case .authorized: self.presentCamera()
            case .restricted, .denied: self.alertCameraAccessNeeded()
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {
            action in
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization({ (status) in
                })
            case .restricted: fallthrough
                print("Fallthrough")
            case .denied:
                print("denied")
                Alert.showAlertWithOkCancel(message: "Grant permission to access photos", actionOk: "OK", actionCancel: "Cancel") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } completionCancel:{
                }
                break
            case .authorized:
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                print("Authorized")
                break
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
        }))
        actionSheet.popoverPresentationController?.sourceView = self.view
        self.present(actionSheet, animated: true, completion: nil)
    }

        //camera
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                
                self.dismiss(animated: true)

                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    print(image)
               
                        self.profileimage = image
                    
                      // imageLink =  self.uploadFile(withImage: image)
                      //  imagebucket.append(imageLink)
                   // self.model.upoadImage(param: <#T##[String : Any]#>, images: <#T##UIImage#>)
                        self.productImage.append(profileimage)
                        self.collImage.reloadData()
                    
                }
            }
    
    func showImagePicker() {
          //        pickerController1.assetType = .allPhotos
          // self.pickerController1.selectedAssets.removeAll()
          print("Assests Count ---->",assets?.count ?? 0,self.pickerController1.selectedAssets.count)
          if self.exportManually {
              DKImageAssetExporter.sharedInstance.add(observer: self)
          }
          
          if let assets = self.assets {
              pickerController1.select(assets: assets)
          }
          
          pickerController1.exportStatusChanged = { status in
              switch status {
              case .exporting:
                  let pickerController = DKImagePickerController()
                  pickerController.assetType = .allPhotos
                  
                  self.pickerController1 = pickerController
                  print("exporting")
              case .none:
                  print("none")
              }
          }
          
          pickerController1.didSelectAssets = { [self] (assets: [DKAsset]) in
              self.updateAssets(assets: assets)
          }
          // if UI_USER_INTERFACE_IDIOM() == .pad {
          //        pickerController1.modalPresentationStyle = .fullScreen
          // }
          
          if pickerController1.UIDelegate == nil {
              pickerController1.UIDelegate = AssetClickHandler()
          }
          
          if pickerController1.inline {
              //self.showInlinePicker()
          } else {
              
              self.present(pickerController1, animated: false) {}
          }
      }
    func updateAssets(assets: [DKAsset]) {
        print("didSelectAssets")
        
        self.assets = assets
        //        self.previewView?.reloadData()
        
        if pickerController1.exportsWhenCompleted {
            for asset in assets {
                if let error = asset.error {
                    print("exporterDidEndExporting with error:\(error.localizedDescription)")
                } else {
                    print("exporterDidEndExporting:\(asset.localTemporaryPath!)")
                }
            }
        }
        
        if self.exportManually {
            DKImageAssetExporter.sharedInstance.exportAssetsAsynchronously(assets: assets, completion: nil)
        }
        if assets.count == 0{
            //            self.navigationController?.popViewController(animated: true)
        }else {
            print("Assets Count ---> ",assets.count,assets)
            for (priority, asset) in assets.enumerated(){
                let oAsset = asset.originalAsset!
                self.productImage.append(getAssetThumbnail(asset: oAsset))
                self.collImage.reloadData()
            }
        }

    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let requestImageOption = PHImageRequestOptions()
        //requestImageOption.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        var retimage = UIImage()
        print(retimage)
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager.default().requestImage(for: asset as PHAsset, targetSize: view.frame.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: { (image, _) in
            retimage = image ?? UIImage()
        })
        print(retimage)
        return retimage
    }
    
}
//MARK: --Collectionview extension--
extension ProfileSetupVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddProductPhotoCVC2", for: indexPath) as! AddProductPhotoCVC2
            let index = indexPath.row
            cell.imgAddProduct.image = self.productImage[index]
            cell.btnRemoveImg.tag = index
            cell.btnRemoveImg.addTarget(self, action: #selector(btnActCancelImage(_:)), for: .touchUpInside)
            return cell
        
    }
    
    @objc func btnActCancelImage(_ sender:UIButton){
        self.productImage.remove(at: sender.tag)
        self.collImage.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: ((self.collImage.frame.size.width)/3.3)  , height: (self.collImage.frame.size.height) )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
    }
}


class AssetClickHandler: DKImagePickerControllerBaseUIDelegate {
    override func imagePickerController(_ imagePickerController: DKImagePickerController, didSelectAssets: [DKAsset]) {
        //tap to select asset
        //use this place for asset selection customisation
        print("didClickAsset for selection")
    }
    
    override func imagePickerController(_ imagePickerController: DKImagePickerController, didDeselectAssets: [DKAsset]) {
        //tap to deselect asset
        //use this place for asset deselection customisation
        print("didClickAsset for deselection")
    }
}
