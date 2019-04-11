//
//  AlbumModel.swift
//  prinsta_pick
//
//  Created by apple on 20/12/18.
//  Copyright © 2018 Pankaj Jangid. All rights reserved.
//

import Photos

class AlbumModel {
    let name:String
    let count:Int
    let collection:PHAssetCollection
    init(name:String, count:Int, collection:PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}
