//
//  JobController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/13/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class JobController: UIViewController {

    @IBOutlet var propertiesTextView: UITextView!
    @IBOutlet weak var companyLogoImageView: UIImageView!
    
    var job: Job?

    override func viewDidLoad() {
        setupCompanyLogo()
        setupProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupCompanyLogo() {
        guard let job = job else { return }

        if let url = job.company_logo, url != "" {
            getImageFrom(url: url)
        } else {
            companyLogoImageView.image = UIImage(named: "imageNotFound")
        }
    }

    private func getImageFrom(url: String) {
        DispatchQueue.global(qos: .background).async {
            do {
                let imageData = try Data(contentsOf: URL(string: url)!)

                DispatchQueue.main.async {
                    self.companyLogoImageView.image = UIImage(data: imageData)
                }
            } catch let error {
                print(error)
            }
        }
    }

    private func setupProperties() {
        guard let job = job else { return }

        propertiesTextView.text = """
        \(job.title)
        \(job.location)
        \(job.type)

        Link: \(job.url ?? "")

        \(job.company)
        \(job.company_url ?? "")
        """
    }

    @IBAction func dismissController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
