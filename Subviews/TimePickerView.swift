//
//  TimePickerView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 17/05/2025.
//

import SwiftUI

struct TimePickerView: View {
    @EnvironmentObject private var vm: FormViewModel
    
    var body: some View {
        VStack {
            // Time Picker
            if !vm.availableTimes.isEmpty {
                Picker("Select Time", selection: $vm.selectedTime) {
                    ForEach(vm.availableTimes, id: \.self) { time in
                        Text(AppointmentManager.shared.timeFormatter.string(from: time))
                            .tag(time as Date?)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
            } else {
                Text("No available times for this date")
            }
        }
        .frame(maxHeight: 250)
    }
}

#Preview {
    TimePickerView()
        .environmentObject(FormViewModel())
}
