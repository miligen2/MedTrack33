//
//  IndexRappel.swift
//  MedTrack
//
//  Created by Angelo Macaire on 29/09/2023.
//

import SwiftUI

struct IndexRappel: View {
    
    @Binding var pillDataArray: [PillData]
    
    var body: some View {
        
        List{
            ForEach(pillDataArray, id: \.id) { pillData in
                Section{
                    VStack {
                        HStack{
                            Text(pillData.heureDePrise1)
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "pills")
                                .font(.title)
                                .foregroundColor(Color.accentColor)
                            
                            Text("nom du medicament")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                        }
                        .padding()
                        
                        
                        
                        HStack{
                            Text("\(pillData.nombreDeComprimes)")
                            .font(.headline)
                            Spacer()
                        }.padding(.leading)
                        
                        
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height: 2)
                            .padding(.vertical)
                        
                        HStack{
                            Spacer()
                                           Button(action: {}){
                                               HStack{
                                                   Image(systemName: "xmark")
                                                   Text("Skip")
                                               }
                                           }
                                           
                                           Spacer()
                                           
                                           Button(action: {}){
                                               HStack{
                                                   Image(systemName: "checkmark")
                                                   Text("Done")
                                               }
                                           }
                                           Spacer()
                        }.padding(.bottom, 10)


                    }
                    
                }
    
                    
                }            }


        }
}

struct IndexRappel_Previews: PreviewProvider {
    static var previews: some View {
        let testData: [PillData] = [
                   PillData(id: 1, nombreDeFoisParJour: 2, heureDePrise1: "1", heureDePrise2: "1", heureDePrise3: "1", nombreDeComprimes: 4)
                   // Ajoutez d'autres données fictives ici si nécessaire
               ]
        IndexRappel( pillDataArray: .constant(testData))
    }
}
