//
//  FormView.swift
//  Memoir
//
//  Created by Shaquille McGregor on 15/05/2025.
//

import SwiftUI

struct FormView: View {
    @StateObject private var vm = FormViewModel()
    @State private var presentNameField = false
    @State private var presentSelectionSheet = false
    @State private var isBooked = false
    @Binding var showSideMenu: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            DismissHeaderView(title: currentDate.dayOfTheWeek())
            Spacer()
            VStack(spacing: 25) {
                FormInputView(text: $vm.name, title: "Name", placeholder: "Name") { presentNameField.toggle() }
                    .overlay(alignment: .trailing)
                { ResetButtonView().environmentObject(vm).padding(.top, 24) }
                DropDownMenu(service: $vm.selectedSerivce, animate: $presentSelectionSheet, title: "Service", prompt: "None") { presentSelectionSheet.toggle() }
                
                TimePickerView()
                    .environmentObject(vm)
                
                confirmButton
                if vm.selectedTime != nil {
                    
                    Text(vm.selectedTime?.dayViewDateFormat() ?? "")
                        .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
            .onAppear {
                vm.resetFormInformation()
                Task { await vm.loadAvailableTimes(currentDate) }
            }
            .onChange(of: currentDate) { _, _ in
                Task { await vm.loadAvailableTimes(currentDate) }
            }
            .alert("Enter Name", isPresented: $presentNameField) {
                TextField("Name", text: $vm.name)
            }
            .sheet(isPresented: $presentSelectionSheet) {
                NavigationStack {
                    // present service selection sheet
                    SelectionSheet(selection: $vm.selectedSerivce, items: vm.services)
                }
            }
            .fullScreenCover(isPresented: $isBooked) {
                NavigationStack {
                    // present confirmation sheet
                    BookedView(date: currentDate)
                        .environmentObject(vm)
                }
            }
            .confirmationDialog("Confirm Appointment", isPresented: $vm.showConfirmationAlert, titleVisibility: .visible) {
                Button("Yes") {
                    Task { try await vm.bookAppointments(for: currentDate) }
                    isBooked.toggle()
                }
            } message: {
                Text("Do you want to book appointment for this date?")
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        FormView(showSideMenu: .constant(false), currentDate: Date())
    }
}

private extension FormView {
    
    private var confirmButton: some View {
        Button("Confirm") {
            vm.showConfirmationAlert.toggle()
        }
        .foregroundStyle(Color(.white))
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.accent))
        .opacity(vm.formValidation ? 1.0 : 0.5)
        .disabled(!vm.formValidation)
    }
}
