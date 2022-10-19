//
//  FilesViewController.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var circleView: UIView!
    @IBOutlet private weak var filenameLabel: UILabel!
    @IBOutlet private weak var filePathLabel: UILabel!

    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }
    
    func setup(file: String) {
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.colorBlack,
            .font: UIFont.boldSystemFont(ofSize: 18)]
        let extensionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.colorGray,
            .font: UIFont.systemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: file.filename, attributes: nameAttributes))
        attributedString.append(NSAttributedString(string: ".", attributes: nameAttributes))
        attributedString.append(NSAttributedString(string: file.fileExtension, attributes: extensionAttributes))

        filenameLabel.attributedText = attributedString
        filePathLabel.text = file
    }
}
