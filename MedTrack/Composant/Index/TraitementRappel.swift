//
//  TraitementRappel.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI

struct TraitementRappel: View {


    @State var rappelNombreComprimé: [PillDataInBox]
    @Binding var isLinkActive: Bool
    var db = DataManagerMedicament()
    
    var body: some View {
        VStack{
        List{
            ForEach(rappelNombreComprimé, id: \.id) { rappel in
                Section{
                    VStack {
                        HStack {
                            Image(systemName: "pills")
                                .font(.title)
                                .foregroundColor(.green)
                            
                            Text("Nom du medicament")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                        }.padding(.bottom, 1.0)
                        HStack{
                            Text("2 Fois par jour - 08:00 et 20:00")
                            Spacer()
                            
                        }
                        
                        HStack{
                            // nombre de comprimé dans la boite de medicament
                            Text("Il reste \(rappel.nombreDeComprimesDansBoite) Comprimé(s)")
                                .frame(width: 200.0, height: 34.0)
                                .font(.headline)
                                .background(.gray.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                            Image(systemName: "bell").font(.title).foregroundColor(.green)
                            
                        }
                        
                        
                    }.padding(1.0)
                }
            }.frame(width:310, height: 150.0)
            
            
        }
            Button {
                self.isLinkActive = true
                db.creatTable()
            } label: {
                Text("Ajouter un rappel")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }.navigationDestination(isPresented: $isLinkActive) {
                addMedicament()
            }
    }
        
        }
    }

//struct TraitementRappel_Previews: PreviewProvider {
//    static var previews: some View {
//        TraitementRappel()
//    }
//}

