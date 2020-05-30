//
//  ViewController.swift
//  MetehanKARA_HW3
//
//  Created by Metehan kara on 19.05.2020.
//  Copyright © 2020 Metehan kara. All rights reserved.
//
//  Tested In Iphone 11 (13.4.1)
//  I organised files like Angela Yu ( Model - Controllers - Views )


import UIKit
import Foundation
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AddNewRecord, UpdateRecord {
    
    // MARK: Variables
    
    @IBOutlet weak var tableView: UITableView!
    var mStudent = [Student]()
    var id: Int? = nil
    var name: String? = nil
    var surname: String? = nil
    var midterm: String? = nil
    var final: String? = nil
    
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        self.fetchData()
        tableView.reloadData()
        
    }
    
    // MARK: Fetch Students
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        /*
         // Create a sort descriptor object that sorts on the "surname"
         // property of the Core Data object
         let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
         let sortDescriptor2 = NSSortDescriptor(key: "surname", ascending: true)
         
         // Set the list of sort descriptors in the fetch request,
         // so it includes the sort descriptor
         fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
         
         // NSPredicate performs search operation
         // https://nspredicate.xyz
         let search = "ay"
         let mPredicate = NSPredicate(format: "name contains[c] %@", search)
         
         //fetchRequest.predicate = mPredicate
         
         do {
         let results = try context.fetch(fetchRequest)
         mStudent = results as! [Student]
         } catch let error as NSError {
         print("Could not fetch \(error), \(error.userInfo)")
         }
         
         */
        
        do {
            let results = try context.fetch(fetchRequest)
            mStudent = results as! [Student]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: prepare func
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // self.fetchData()
        
        if segue.identifier == "updateRecordSegue" {
            if let VC = segue.destination as? UpdateRecordVC {
                VC.id = id
                VC.name = name
                VC.surname = surname
                VC.midterm = midterm
                VC.final = final
                VC.delegate = self
            }
        }
        else  if segue.identifier == "addRecordSegue" {
            if let VC = segue.destination as? AddRecordVC {
                VC.delegate = self
            }
        }
        
        
    }
    
    // MARK: Add New Student
    
    func saveNewStudent(data: (String, String, String, String)) {
        
        let (name, surname, midterm, final) = data
        self.saveStudents(name, surname: surname, midterm: midterm, final: final)
        
    }
    
    // MARK: I got an hyerarchy error in table view -> this func for that
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
    }
    
    // MARK: Update
    
    func updateData(data: (Int, String, String, String, String)) {
        
        let (id, name, surname, midterm, final) = data
        self.updateItem(id, name: name, surname: surname, midterm: midterm, final: final)
        
        self.fetchData()
        
    }
    
    // MARK: Save Studenst
    
    func saveStudents(_ name : String, surname : String, midterm: String, final: String) {
        print(name,surname,midterm,final)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newStudentItem = Student.createInManagedObjectContext(context,
                                                                  name: name, surname: surname, midterm: NumberFormatter().number(from: midterm)!, final: NumberFormatter().number(from: final)!)
        
        self.fetchData()
        
        if let newStudentIndex = mStudent.firstIndex(of: newStudentItem) {
            
            let newStudentItemIndexPath = IndexPath(row: newStudentIndex, section: 0)
            tableView.insertRows(at: [ newStudentItemIndexPath ], with: .automatic)
            
            saveStudentCoreData()
            
        }
    }
    
    // MARK: Update
    
    func updateItem(_ id: Int, name : String, surname : String, midterm: String, final: String) {
        
        // send students with id to update
        
        mStudent[id].name = name
        mStudent[id].surname = surname
        mStudent[id].midterm = Double (midterm)!
        mStudent[id].final = Double (final)!
        
        // save student
        
        saveStudentCoreData()
        
    }
    
    // MARK: Save to core data
    
    func saveStudentCoreData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    // MARK: Go To UpdateRecordVC and Update Student Data
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            
            mStudent = fetchResults as! [Student]
            
            id = indexPath.row
            name = mStudent[indexPath.row].name!
            surname = mStudent[indexPath.row].surname!
            midterm = "\(mStudent[indexPath.row].midterm as Double)"
            final = "\(mStudent[indexPath.row].final as Double)"
            
            performSegue(withIdentifier: "updateRecordSegue", sender: nil)
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: TableView row count
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mStudent.count
    }
    
    // MARK: Tableview cell and subtitle fill
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        // Student info
        
        let student = mStudent[indexPath.row]
        
        cell?.textLabel?.text = student.name! + " " + student.surname!
        cell?.detailTextLabel?.text = "Midterm = \(student.midterm), Final = \(student.final)"
        
        return cell!
        
    }
    
    // MARK: Table delete
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if(editingStyle == .delete ) {
            // Find the Student object the user is trying to delete
            let studentToDelete = mStudent[indexPath.row]
            
            // Delete it from the managedObjectContext
            context.delete(studentToDelete)
            
            // Delete it from mStudent Array
            mStudent.remove(at: indexPath.row)
            
            // Tell the table view to animate out that row
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            saveStudentCoreData()
        }
    }
}

