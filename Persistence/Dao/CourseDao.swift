//
//  CourseDao.swift
//  Persistence
//
//  Created by Marlon Escobar on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit
import CoreData

class CourseDao {
    let appDelegate: AppDelegate!
    
    init(delegate: AppDelegate) {
        self.appDelegate = delegate
    }
    
    func getManagedContext() -> NSManagedObjectContext? {
        return appDelegate.persistentContainer.viewContext
    }
    
    func getCourseByAttribute(attributeName: String, attributeValue: String) -> Course? {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        do {
            fetchReq.predicate = NSPredicate(format: "\(attributeName) = %@" , attributeValue)
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let course = result[0] as! Course
                    return course
                } else {
                    print("Course with \(attributeName)=\(attributeValue) not found!")
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
    
    func getCourseByCourseName(courseTitle: String) -> Course? {
        return getCourseByAttribute(attributeName: "title", attributeValue: courseTitle)
        
    }
    
    func saveCourse(form: CourseForm) -> Bool {
        if let exists = getCourseByCourseName(courseTitle: form.title) {
            print("Course with courseTitle=\(exists.title!) already exists!")
            return false
        }
        if let context = getManagedContext() {
            let course = Course(context: context)
            course.credit = form.credit
            course.semester = form.semester
            course.csId = form.csId
            course.title = form.title
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
    
    func getAllCourses() -> [Course] {
        let context = getManagedContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        do {
            if let result = try context?.fetch(fetchReq) {
                // result is an array of type [Any]
                if result.count > 0 {
                    let courses = result as! [Course]
                    return courses
                } else {
                    print("No Course registered yet!")
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
    
    
    func removeCourse(withCourseTitle courseTitle: String) -> Bool{
        return false
    }
}
