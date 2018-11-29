//
//  ViewController.swift
//  NircaTracker
//
//  Created by Ethan Febinger on 11/8/18.
//  Copyright © 2018 Ethan Febinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ResultsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ResultTableViewCell.")
        }
        
        print("PLEASE")
        
        // Fetches the appropriate meal for the data source layout.
        let result = results[indexPath.row]
        
        var arr = result.meetName.components(separatedBy: "_")
        var meet = ""
        arr.remove(at: arr.count-1)
        for m in arr{
            meet = meet + m + " "
        }
        
        let arr2 = meet.components(separatedBy: ".")
        meet = arr2[0]
        
        cell.resultLabel.text = meet
        cell.timeLabel.text = result.time
        
        return cell
    }
    

    /*@IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var collegeText: UITextField!*/
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var collegeText: UILabel!
    
    @IBOutlet weak var resultsTable: UITableView!
    
    var athlete : Athlete?
    var results: Array<Result> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up views if editing an existing Meal.
        
        print("wack.")
        if let athlete = athlete {
            nameText.text = "\t"+athlete.firstName+" "+athlete.lastName
            collegeText.text = "\t"+athlete.college
            results = athlete.results
            resultsTable.dataSource = self
            print("GHAAAAAa")
            resultsTable.reloadData()
            
            
        }

    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

