//
//  AlbumDetailsTableViewDataSource.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 29/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var duarationLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
}

class AlbumDetailsTableViewDataSource: NSObject, UITableViewDataSource {
    var tracks: [AlbumDetails.ViewModel.RowDataSource] = []
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCellId",
                                                 for: indexPath)
        if let cell = cell as? TrackTableViewCell {
            let art = tracks[indexPath.row]
            cell.nameLabel.text = art.name
            cell.artistLabel.text = art.artist
            cell.duarationLabel.text = art.time
            cell.positionLabel.text = art.index
        }
        return cell
    }
    
}
