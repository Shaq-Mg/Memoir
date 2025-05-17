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
                    .overlay(alignment: .trailing) { clearButton }
                DropDownMenu(service: $vm.selectedSerivce, animate: $presentSelectionSheet, title: "Service", prompt: "None") { presentSelectionSheet.toggle() }
                
                TimePickerView()
                    .environmentObject(vm)
                
                confirmButton
                if let time = vm.selectedTime {
                    
                    Text(time.dayViewDateFormat())
                        .foregroundStyle(Color(.darkGray))
                }
            }
            .padding(.horizontal)
            .onAppear {
                vm.generateAvailableTimes(currentDate)
                vm.removeFormInformation()
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
    
    private var clearButton: some View {
        Button {
            withAnimation(.easeInOut) {
                vm.removeFormInformation()
            }
        } label: {
            Image(systemName: "xmark.circle")
                .imageScale(.large).bold()
                .foregroundStyle(Color(.darkGray))
        }
        .padding(.top, 26).padding(.trailing)
    }
    
    private var confirmButton: some View {
        Button("Confirm") {
            Task { try await vm.book(for: currentDate) }
            isBooked.toggle()
        }
        .foregroundStyle(Color(.white))
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.accent))
        .opacity(formValidation ? 1.0 : 0.5)
        .disabled(formValidation)
    }
    
    private var formValidation: Bool {
        return !vm.name.isEmpty && vm.selectedTime != nil && vm.selectedSerivce != nil
    }
}
