//
//  datastore.swift
//  MedTrack
//
//  Created by Angelo Macaire on 30/09/2023.
//

import Foundation

import Combine

class PillDataStore: ObservableObject {
    @Published var pillDataArray: [PillData] = []
}
