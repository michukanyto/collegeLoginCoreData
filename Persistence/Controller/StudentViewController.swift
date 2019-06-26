//
//  RegisterStudentViewController.swift
//  Persistence
//
//  Created by Marlon Escobar on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var studentNameRegistrationTextView: UITextField!
    @IBOutlet weak var semesterStudentRegistrationTextView: UITextField!
    @IBOutlet weak var passwordStudentRegistrationTextView: UITextField!
    
    
    
    @IBOutlet weak var studentIdLogInTextView: UITextField!
    @IBOutlet weak var passwordStudenLogInTextView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func studentRegisterButtonTapped(_ sender: UIButton) {
        let studentForm = StudentForm(name: studentNameRegistrationTextView.text, password: passwordStudentRegistrationTextView.text, semester: semesterStudentRegistrationTextView.text, stId: createStudentId())
        _ = studentDao?.saveStudent(form: studentForm)
        print("------- \(studentForm)")
        performSegue(withIdentifier: "studentSignon", sender: self)
    }
    
    
    @IBAction func studentLogInButtonTapped(_ sender: UIButton) {
        let students = (studentDao?.getAllStudents())!
        print (students)
        
        let stId = studentIdLogInTextView.text
        let stPassword = passwordStudenLogInTextView.text
        
        if let student = studentDao?.getStudentByAttribute(attributeName: "stId", attributeValue: stId!) {
            if student.password! == stPassword {
                performSegue(withIdentifier: "studentSignon", sender: self)
            }
        }

    }
    
    func createStudentId()->String{
        let random = Int.random(in: 100..<10000)
        let random1 = String.randomElement("ABCDEFGHIJKLMNOPQRSTUVXYZ")
        let random2 = String.randomElement("abcdefghijklmnopqrstuvxyz")
        let stId = "ST" + String(random1()!) + "-" + String(random) + String(random2()!)
        return stId
    }
    
}
