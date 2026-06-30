//
//  VIPER Protocols.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI

protocol Interactor { }

protocol Presenter {
    associatedtype I: Interactor
    var interactor: I { get set }
    var router: AppRouter { get set }
}



