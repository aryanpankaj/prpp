//
//  Album.swift
//  PICMOB
//
//  Created by Mohit Singh on 8/9/18.
//  Copyright © 2018 Mohit Singh. All rights reserved.
//

import UIKit
import Photos
class Album: NSObject {
    
    
   var folderTitle = [String]()
    var imageCount = [Int]()
    func listAlbums(){
        
        let album:[AlbumModel] = [AlbumModel]()
        
        let smartOption = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: smartOption)
        
        let option = PHFetchOptions()
        let userAlbum = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: option)
        
        let allAlbums  = [userAlbums,userAlbum]
        
        for i in 0 ..< allAlbums.count {
            let result = allAlbums[i]
        result.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
            if object is PHAssetCollection {
                let obj:PHAssetCollection = object as! PHAssetCollection
                
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
                
                let result1 = PHAsset.fetchAssets(in: obj, options: fetchOptions)
            //    let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection:obj)
             //
                self.folderTitle.append(obj.localizedTitle!)
                self.imageCount.append(result1.count)
                
              
                
            //    album.append(newAlbum)
            }
        }
    }
        
        
          print("folderTitle\(self.imageCount)")
        
        for item in album {
            print(item)
        }

    }

}
