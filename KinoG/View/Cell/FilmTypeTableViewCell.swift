// FilmTypeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class FilmTypeTableViewCell: UITableViewCell {
    
    enum FilmType {
        case popular
        case upcoming
        case topRated
    }
    
    // MARK: - Visual Components
    
    private let filmsSegmetedControll: UISegmentedControl = {
        let items = ["Popular", "Top Rated", "Upcoming"]
        let segmentControll = UISegmentedControl(items: items)
        segmentControll.selectedSegmentIndex = 0
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentControll
    }()
    
    // MARK: - Public Properties
    
    public var didSelect: ((FilmType) -> ())?
    
    // MARK: - Private Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        filmsSegmetedControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    override func layoutSubviews() {
        contentView.addSubview(filmsSegmetedControll)
        
        filmsSegmetedControllConstraintSetup()
    }
    
    @objc private func segmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            didSelect?(.popular)
        case 1:
            didSelect?(.topRated)
        case 2:
            didSelect?(.upcoming)
        default:
            print("error")
        }
    }
    
    private func filmsSegmetedControllConstraintSetup() {
        NSLayoutConstraint.activate([
            filmsSegmetedControll.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            filmsSegmetedControll.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmsSegmetedControll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
