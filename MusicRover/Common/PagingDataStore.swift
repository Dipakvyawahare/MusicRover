//
//  PagingDataStore.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 28/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

class PagingDataStore<T> {
    var index: Int {
        objects.count
    }
    let total: Int
    private(set) var objects: [T] = []
    var shouldLoadMore: Bool {
        objects.count < total
    }
    
    init(total: Int) {
        self.total = total
    }
    
    func appendObjects(objects: [T]) {
        self.objects += objects
    }
}
