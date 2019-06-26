//
//  TeacherDao.swift
//  Persistence
//
//  Created by Marlon Escobar on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit
import CoreData

class TeacherDao {
    let appDelegate: AppDelegate!
    
    init(delegate: AppDelegate) {
        self.appDelegate = delegate
    }
    
    func getManagedContext() -> NSManagedObjectContext? {
        return appDelegate.persistentContainer.viewContext
    }
    
    func getTeacherByAttribute(attributeName: String, attributeValue: String) -> Teacher? {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
        do {
            fetchReq.predicate = NSPredicate(format: "\(attributeName) = %@" , attributeValue)
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let teacher = result[0] as! Teacher
                    return teacher
                } else {
                    print("Teacher with \(attributeName)=\(attributeValue) not found!")
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
    
    func getTeacherByTeacherName(teacherName: String) -> Teacher? {
        return getTeacherByAttribute(attributeName: "name", attributeValue: teacherName)
        
    }
    
    func saveTeacher(form: TeacherForm) -> Bool {
        if let exists = getTeacherByTeacherName(teacherName: form.name) {
            print("Teacher with teacherName=\(exists.name!) already exists!")
            return false
        }
        if let context = getManagedContext() {
            let teacher = Teacher(context: context)
            teacher.name = form.name
            teacher.password = form.password
            teacher.tId = form.tId
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
    
    func getAllTeachers() -> [Teacher] {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Teacher")
        do {
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let teachers = result as! [Teacher]
                    return teachers
                } else {
                    print("No Teacher registered yet!")
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
    
    
    func removeTeacher(withTeacherName teacherName: String) -> Bool{
        return false
    }
}
