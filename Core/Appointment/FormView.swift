//
//  FormView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 24/01/2025.
//

import SwiftUI

struct FormView: View {
    @EnvironmentObject private var viewModel: ApptViewModel
    @State private var presentNameTextfield = false
    @State private var presentServiceSelection = false
    @State private var isBooked = false
    @Binding var showSideMenu: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            MainHeaderView(showSideMenu: $showSideMenu, onDismiss: true, title: currentDate.dayOfTheWeek())
            Spacer()
            VStack(spacing: 25) {
                FormInputVew(text: $viewModel.name, title: "Name", placeholder: "Name") { presentNameTextfield.toggle() }
                    .overlay(alignment: .trailing) {
                        clearButton
                    }
                DropDownMenu(service: $viewModel.selectedSerivce, title: "Service", placeholder: "None") { presentServiceSelection.toggle() }
                
                timePicker
                confirmButton
                if let selectedTime = viewModel.selectedTime {
                    
                    Text(selectedTime.dayViewDateFormat())
                        .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
            .onAppear {
                viewModel.generateAvailableTimes(for: currentDate)
                viewModel.name = ""
                viewModel.selectedTime = nil
                viewModel.selectedSerivce = nil
            }
            .alert("Enter Name", isPresented: $presentNameTextfield) {
                TextField("Name", text: $viewModel.name)
            }
            .sheet(isPresented: $presentServiceSelection) {
                NavigationStack {
                    SelectionSheet(selection: $viewModel.selectedSerivce, items: viewModel.dataService.services)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        FormView(showSideMenu: .constant(false), currentDate: Date())
            .environmentObject(ApptViewModel())
    }
}

private extension FormView {
    
    private var clearButton: some View {
        Button {
            withAnimation(.easeInOut) {
                viewModel.name = ""
                viewModel.selectedSerivce = nil
            }
        } label: {
            Image(systemName: "xmark.circle")
                .imageScale(.medium).bold()
                .foregroundStyle(Color(.darkGray))
        }
        .padding(.top, 26).padding(.trailing)
    }
    
    private var timePicker: some View {
        VStack {
            // Time Picker
            if !viewModel.availableTimes.isEmpty {
                Picker("Select Time", selection: $viewModel.selectedTime) {
                    ForEach(viewModel.availableTimes, id: \.self) { time in
                        Text(viewModel.timeFormatter.string(from: time)).tag(time as Date?)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxHeight: 200)
                
            } else {
                Text("No available times for this date")
            }
        }
    }
    
    private var confirmButton: some View {
        Button("Confirm") {
            if let selectedTime = viewModel.selectedTime,
               let selectedService = viewModel.selectedSerivce {
                viewModel.book(name: viewModel.name, description: selectedService.title, price: viewModel.selectedSerivce?.price ?? 0, date: currentDate, time: selectedTime)
                isBooked.toggle()
            }
        }
        .foregroundStyle(.dark)
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.icon))
        .opacity(viewModel.name.isEmpty && viewModel.selectedSerivce == nil ? 0.5 : 1.0)
        .disabled(viewModel.name.isEmpty && viewModel.selectedSerivce == nil)
    }
}
