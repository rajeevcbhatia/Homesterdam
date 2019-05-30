//
//  BaseView.swift
//  Homesterdam
//
//  Created by Rajeev Bhatia on 29/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol BaseView: AnyObject {
    func showAlert(title: String, message: String)
    func showRetryAlert(title: String, message: String, callback: @escaping (() -> ()))
    func showLoader()
    func hideLoader()
}
