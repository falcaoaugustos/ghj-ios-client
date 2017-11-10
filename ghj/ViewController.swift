//
//  ViewController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/8/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var jobs = [Job]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "JobTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JobCell")
        jobs.append(Job(
            id: "123",
            createAt: "Today",
            title: "Web Developer",
            location: "Fortaleza",
            type: "Fulltime",
            company: "NYC",
            companyUrl: "www.nyc.com",
            companyLogo: "www.nyc.com/logo",
            url: "www.nyc.com"
        ))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as! JobTableViewCell
        cell.job = jobs[indexPath.row]
        cell.loadData()

        return cell
    }

    // MARK: Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("BOM")
    }

}

