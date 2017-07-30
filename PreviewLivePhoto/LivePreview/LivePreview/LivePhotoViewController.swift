//
//  LivePhotoViewController.swift
//  LivePreview
//
//  Created by Pavel Selivanov on 04.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class LivePhotoViewController: UIViewController {
    
    var photoView: PHLivePhotoView!
    var livePhotoAsset: PHAsset?

    override func viewDidLoad() {
        super.viewDidLoad()

        photoView = PHLivePhotoView(frame: self.view.bounds)
        photoView.contentMode = .scaleAspectFit
        self.view.addSubview(photoView)
        
        
        if self.traitCollection.forceTouchCapability == .unavailable {
            let playbarButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(LivePhotoViewController.playAnimation))
            self.navigationItem.rightBarButtonItem = playbarButton
        }
    }
    
    func playAnimation() {
        photoView.startPlayback(with: .full)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurateView()
    }
    
    func configurateView() {
        if let photoAsset = livePhotoAsset {
            //PHImageManager.default().requestImage(for: <#T##PHAsset#>, targetSize: <#T##CGSize#>, contentMode: <#T##PHImageContentMode#>, options: , resultHandler: <#T##(UIImage?, [AnyHashable : Any]?) -> Void#>)
            
            PHImageManager.default().requestLivePhoto(for: photoAsset, targetSize: photoView.frame.size, contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (photo: PHLivePhoto?, info: [AnyHashable : Any]?) in
                
                if let livePhoto = photo {
                    self.photoView.livePhoto = livePhoto
                    //next setting only for live photo
                    self.photoView.startPlayback(with: PHLivePhotoViewPlaybackStyle.hint)
                    
                    //Usage metadata
                    let geoCoder = CLGeocoder()
                    geoCoder.reverseGeocodeLocation(photoAsset.location!, completionHandler: { (placemarks: [CLPlacemark]?,error: Error?) in
                        self.navigationItem.title = placemarks?.first?.locality
                    })
                }
            })
        }
    }

}
