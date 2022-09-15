//
//  Constant.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase

let textFieldHeight: CGFloat = 16.0

// MARK: - Firebase REF

let dbREF = Database.database().reference()
let refUSERS = dbREF.child("users")
