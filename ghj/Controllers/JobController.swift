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

    var job: Job?

    override func viewDidLoad() {
        setupProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupProperties() {
        guard let job = job else { return }

        propertiesTextView.text = """
        Title: \(job.title)
        Location: \(job.location)
        Type: \(job.type)
        Link: \(job.url)
        Company: \(job.company)
        Company URL: \(job.companyUrl)
        """
    }

    @IBAction func dismissController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
