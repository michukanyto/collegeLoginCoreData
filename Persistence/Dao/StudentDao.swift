//
//  studentDao.swift
//  Persistence
//
//  Created by Marlon Escobar on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit
import CoreData

class StudentDao {
    let appDelegate: AppDelegate!
    
    init(delegate: AppDelegate) {
        self.appDelegate = delegate
    }
    
    func getManagedContext() -> NSManagedObjectContext? {
        return appDelegate.persistentContainer.viewContext
    }
    
    func getStudentByAttribute(attributeName: String, attributeValue: String) -> Student? {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            fetchReq.predicate = NSPredicate(format: "\(attributeName) = %@" , attributeValue)
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let student = result[0] as! Student
                    return student
                } else {
                    print("Student with \(attributeName)=\(attributeValue) not found!")
                    return nil
                }
            } else {
                print("Cannot fetch from CoreData!")
                return nil
            }
        } catch {
            print("Cannot communicate with CoreData!")
            return nil
        }
    }
    
    func getStudentByStudentName(studentName: String) -> Student? {
        return getStudentByAttribute(attributeName: "name", attributeValue: studentName)
        
    }
    
    func saveStudent(form: StudentForm) -> Bool {
        if let exists = getStudentByStudentName(studentName: form.name) {
            print("Student with studentName=\(exists.name!) already exists!")
            return false
        }
        if let context = getManagedContext() {
            let student = Student(context: context)
            student.name = form.name
            student.password = form.password
            student.semester = form.semester
            student.stId = form.stId
            do {
                try context.save()
                return true
            } catch {
                print("Cannot save to CoreData!")
                return false
            }
        } else {
            print("Cannot communicate with CoreData!")
            return false
        }
    }
    
    func getAllStudents() -> [Student] {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        do {
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let students = result as! [Student]
                    return students
                } else {
                    print("No Student registered yet!")
                    return []
                }
            } else {
                print("Cannot fetch from CoreData!")
                return []
            }
        } catch {
            print("Cannot communicate with CoreData!")
            return []
        }
    }
    
    
    func removeStudent(withStudentName studentName: String) -> Bool{
        return false
    }
}

