//
//  Index.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI

struct Index: View {
    @State var button = false
    @State var medicamentProgramme = [2]

    
    var body: some View {
        ZStack {
            VStack {
                if medicamentProgramme.isEmpty {
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
                    IndexRappel()
                }
            }
            VStack{
                HStack{
                    Text("À prendre 💊")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                Spacer()
            }.padding()
        }
    }
}


struct index_Previews: PreviewProvider {
    static var previews: some View {
        Index()
    }
}
