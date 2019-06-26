//
//  TeacherViewController.swift
//  Persistence
//
//  Created by Marlon Escobar on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class TeacherViewController: UIViewController {

    @IBOutlet weak var teacherNameRegistrationTextView: UITextField!
    @IBOutlet weak var teacherPasswordRegistrationTextView: UITextField!
    
    
    
    @IBOutlet weak var teacherIdLogInTextView: UITextField!
    @IBOutlet weak var teacherPasswordLogInTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func teacherRegistrationButtonTapped(_ sender: UIButton) {
        let teacherForm = TeacherForm(name: teacherNameRegistrationTextView.text, password: teacherPasswordRegistrationTextView.text, tId: createTeacherId())
        _ = teacherDao?.saveTeacher(form: teacherForm)
        print(teacherForm)
        performSegue(withIdentifier: "teacherSignon", sender: self)
        
    }
    

    @IBAction func teacherLogInButtonTapped(_ sender: UIButton) {
        if let teacher = teacherDao?.getTeacherByAttribute(attributeName: "tId", attributeValue: teacherIdLogInTextView.text!){
            if teacher.password == teacherPasswordLogInTextView.text!{
                print("LogIn successful")
                performSegue(withIdentifier: "teacherSignon", sender: self)
            }
        }
    }
    
    
    func createTeacherId()->String{
        let random = Int.random(in: 100..<10000)
        let random1 = String.randomElement("ABCDEFGHIJKLMNOPQRSTUVXYZ")
        let random2 = String.randomElement("abcdefghijklmnopqrstuvxyz")
        let stId = "TE" + String(random1()!) + "-" + String(random) + String(random2()!)
        return stId
    }
}
