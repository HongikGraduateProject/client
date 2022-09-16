//
//  Constant.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/15.
//

import Firebase

let textFieldHeight: CGFloat = 16.0
let snsButtonHeight: CGFloat = 44.0
let authDefaultInset: CGFloat = 24.0

// MARK: - Firebase REF

let dbREF = Database.database().reference()
let refUSERS = dbREF.child("users")
