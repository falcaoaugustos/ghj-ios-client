//
//  JobTableViewCell.swift
//  ghj
//
//  Created by Augusto Falcão on 11/9/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

protocol JobTableViewCellDelegate {
    func didFinishDownloadImage()
}

class JobTableViewCell: UITableViewCell {

    var job: Job?
    var delegate: JobTableViewCellDelegate? = nil

    @IBOutlet weak var companyLogo: UIImageView!

    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadData() {
        // companyLogo = job?.companyLogo
        if let url = job?.companyLogo, job?.companyLogo != "" {
            print(url)
            getImageFrom(url: url)
        } else {
            getImageFrom(url: "https://cdn.browshot.com/static/images/not-found.png")
        }
        company.text = job?.company
        title.text = job?.title
        location.text = job?.location
    }

    func getImageFrom(url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, resp, error) in
            DispatchQueue.main.async {
                self.companyLogo = UIImageView(image: UIImage(data: data ?? Data()))
                self.delegate?.didFinishDownloadImage()
            }
        }.resume()
    }
}
