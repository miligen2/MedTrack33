//
//  Index.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI

struct Index: View {
    
    var db = DataManagerMedicament()
    
    @State var button = false
    @State public var pillDataArray: [PillData] = []
    
    var body: some View {
        ZStack {
            VStack {
                if pillDataArray.isEmpty {
                    VStack {
                        Text("Visualisez vos traitement")
                            .font(.title2)
                            .foregroundColor(.green)
                            .padding(.bottom, 2.0)
                        Text("Visualisez facilement les traitements que vous devez prendre planifiés dans Traitement")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48.0)
                            .foregroundColor(.gray)
                        
                    }
                    .padding(.top, 50)
                } else {
                    IndexRappel(pillDataArray: $pillDataArray)
                }
            }
        }.onAppear(){
            do {
                pillDataArray = try db.displayDataFromTable()
            } catch{
                print("ok")
            }
        }
    }
}


struct index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
