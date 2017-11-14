//
//  ViewController.swift
//  ghj
//
//  Created by Augusto Falcão on 11/8/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import UIKit

class JobSearchController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPressedSearchJobsButton() {
        performSegue(withIdentifier: "JobsTableViewSegue", sender: nil)
    }

    // MARK: Job Table View Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let jobsTableViewController = (segue.destination as! UINavigationController).topViewController as! JobsTableController
        jobsTableViewController.requestParameters = (descriptionTextField.text ?? "", locationTextField.text ?? "")
    }

    // MARK: Text Field Delegate

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

}
