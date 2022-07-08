//
//  TrackCell.swift
//  iMusic
//
//  Created by admin on 01.07.2022.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackButton: UIButton!
    
    static let reuseId = "TrackCell"
    
    var cell: SearchViewModel.Cell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        self.cell = viewModel
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.firstIndex(where: {$0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName}) != nil
        if hasFavourite {
            addTrackButton.isHidden = true
        } 
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        guard let cell = cell else { return }
        addTrackButton.isHidden = true
        var listOfTracs = defaults.savedTracks()
        
        listOfTracs.append(cell)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracs, requiringSecureCoding: false) {
            print("Ok")
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
}
