//
//  Calendar.swift
//  MedTrack2
//
//  Created by Angelo Macaire on 19/09/2023.
//

import SwiftUI

struct Calendar: View {
    let daysOfWeek = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
    @State private var medicationTaken = Array(repeating: false, count: 7)
    @State private var showReminder = false
    @State private var medicationRecap = [String]()

    var body: some View {
        VStack {
            Text("Calendrier")
                .font(.title2)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(0..<daysOfWeek.count, id: \.self) { index in
                        MedicationDayView(dayOfWeek: daysOfWeek[index], isTaken: $medicationTaken[index])
                    }
                }
                .padding()
            }

            List(medicationRecap, id: \.self, rowContent: { item in
                Text(item)
            })
            
            Button(action: {
     
                self.showReminder = medicationTaken.contains(true)

                generateMedicationRecap()
            }) {
                Text("Enregistrer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding()


        }
    }

    func generateMedicationRecap() {
        medicationRecap = []

        for (index, day) in daysOfWeek.enumerated() {
            if medicationTaken[index] {
                medicationRecap.append("\(day) médicament pris")
            }
        }

        // Vérifier si tous les jours de la semaine ont été pris
        if medicationRecap.count == daysOfWeek.count {
            // Réinitialiser les valeurs de medicationTaken
            medicationTaken = Array(repeating: false, count: 7)
        }
    }
}

struct MedicationDayView: View {
    let dayOfWeek: String
    @Binding var isTaken: Bool

    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.headline)

            Image(systemName: isTaken ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(red: 0.596, green: 0.878, blue: 0.599))
                .onTapGesture {
                    isTaken.toggle()
                }
        }
    }
}



struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}

