//
//  PhotoCollectionViewController.swift
//  LivePreview
//
//  Created by Pavel Selivanov on 04.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

//Add to Info.plist NSPhotoLibraryUsageDescription
class PhotoCollectionViewController: UICollectionViewController {

    var assetsFetchResults: PHFetchResult<PHAsset>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            switch status {
            case .authorized:
                self.fetchPhotos()
            default:
                self.showNoPhotosAccesAlert()
            }
        }
    }
    
    func fetchPhotos() {
        let sortDescriptor      = NSSortDescriptor(key: "creationDate", ascending: true)
        let predicate           = NSPredicate(format: "(mediaSubtype & %d) != 0", PHAssetMediaSubtype.photoLive.rawValue)
        
        let options             = PHFetchOptions()
        options.sortDescriptors = [sortDescriptor]
        options.predicate       = predicate
        
        //Do this at background thread
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.assetsFetchResults = PHAsset.fetchAssets(with: options)
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    func showNoPhotosAccesAlert() {
        let alert = UIAlertController(title: "No Photo library permission", message: "\nPlease, grant this App photo access in Settings -> Privacy", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (action: UIAlertAction) in
            let url = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(url!, options: ["" : ""], completionHandler: nil)
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfItems = assetsFetchResults?.count {
            return numberOfItems
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        if let asset = assetsFetchResults?[indexPath.row] {
            let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true
            
            let targetSize = CGSize(width: 300, height: 300)
            
            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: options, resultHandler: { (image, info: [AnyHashable : Any]?) in
                cell.photoImageView.image = image
            })
        }
    
        // Configure the cell
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
            let photoVC = segue.destination as! LivePhotoViewController
            photoVC.livePhotoAsset = assetsFetchResults![indexPath.item]
        }
    }
}


















